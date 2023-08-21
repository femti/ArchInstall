#!/usr/bin/env bash
set -e


echo '===== Install Kernel ====='
curl -s https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | sudo pacman-key --add -
pacman-key --finger 56C464BAAC421453
pacman-key --lsign-key 56C464BAAC421453
echo '[linux-surface]' >> /etc/pacman.conf
echo 'Server = https://pkg.surfacelinux.com/arch/' >> /etc/pacman.conf
pacman -Syu
pacman -S --noconfirm linux-surface linux-surface-headers iptsd
# pacman -S linux-surface-secureboot-mok
grub-mkconfig -o /boot/grub/grub.cfg

echo '==== Install add package ===='
pacman -S --noconfirm --needed alacarte eog-plugins geany geary geany-plugins gnome-epub-thumbnailer ntfs-3g unrar p7zip dbus-broker tlp acpi acpi_call acpid plymouth ttf-droid noto-fonts ttf-roboto ttf-ubuntu-font-family ttf-fira-mono ttf-hack ttf-fira-code ttf-jetbrains-mono inter-font mesa-utils xorg-xdpyinfo xorg-xinit xorg-xinput xorg-xkill xorg-xrandr xf86-video-intel b43-fwcutter broadcom-wl-dkms dhclient dnsmasq dnsutils ethtool modemmanager networkmanager-openconnect networkmanager-openvpn nss-mdns usb_modeswitch bash-completion bluez-utils ffmpegthumbnailer gst-libav gst-plugins-ugly libdvdcss libopenraw mlocate efitools haveged nfs-utils nilfs-utils ntp dmidecode dmraid hdparm hwdetect lsscsi mtools sg3_utils sof-firmware intel-ucode gnome-power-manager gnome-shell-extension-appindicator webp-pixbuf-loader tlp-rdw upower thermald irqbalance

echo '==== Remove unnessary packages ===='
sudo pacman -R --noconfirm vim htop cheese yelp gnome-user-docs gnome-tour

echo '==== Start needed servises ===='
systemctl --user mask org.gnome.SettingsDaemon.Wacom.service
systemctl --user mask org.gnome.SettingsDaemon.A11ySettings.service
systemctl mask NetworkManager-wait-online.service
systemctl enable dbus-broker.service
systemctl enable fstrim.timer
systemctl enable acpid.service
systemctl enable bluetooth
systemctl enable tlp
systemctl enable upower
systemctl enable thermald
systemctl enable irqbalance

echo '==== Install YAY ===='
su -l wlad <<< $(cat << YAY
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd -
rm -rf /tmp/yay
YAY
)

echo '==== Inatall YAY packages ===='
yay -S --noconfirm --needed timeshift pycharm-community-edition raindrop evernote tradingview  insync-nautilus insync ttf-jetbrains-mono-nerd ttf-noto-nerd


 
echo '==== Install Plymouth Theme and edit GRUB ===='
yay -S --noconfirm  plymouth-theme-monoarch
echo 'add plymouth to HOOK'
sed -i '/^HOOK/s/ udev / udev plymouth /' /etc/mkinitcpio.conf
sudo plymouth-set-default-theme -R monoarch
echo 'add to GRUB splash, hidden and time'
sed -i '/GRUB_TIMEOUT=/s/5/1/'  /etc/default/grub
sed -i '/GRUB_TIMEOUT_STYLE=/s/menu/hidden/'  /etc/default/grub
sed -i '/GRUB_CMDLINE_LINUX_DEFAULT=/s/ quiet/ quiet splash/'  /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg



echo ' ==== Install Flatpak package ===='
sudo flatpak install -y flathub org.mozilla.firefox org.onlyoffice.desktopeditors io.github.mimbrero.WhatsAppDesktop net.xmind.XMind com.todoist.Todoist io.github.shiftey.Desktop net.ankiweb.Anki org.gustavoperedo.FontDownloader com.rafaelmardojai.Blanket app.drey.Dialect com.brave.Browser de.bund.ausweisapp.ausweisapp2 com.bitwarden.desktop com.mattjakeman.ExtensionManager com.google.Chrome io.github.davidoc26.wallpaper_selector com.todoist.Todoist com.github.d4nj1.tlpui

echo '==== Enable Shell ===='
yay -S --noconfirm --needed gnome-shell-extension-rounded-window-corners gnome-shell-extension-coverflow-alt-tab-git gnome-shell-extension-dash-to-dock gnome-shell-extension-openweather gnome-shell-extension-appindicator gnome-shell-extension-blur-my-shell gnome-shell-extension-gsconnect gnome-shell-extension-gtk4-desktop-icons-ng gnome-shell-extension-status-area-horizontal-spacing-git
su -l wlad <<< $(cat << SHEL
gsettings set org.gnome.shell disable-user-extensions false
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable blur-my-shell@aunetx
gnome-extensions enable rounded-window-corners@yilozt
gnome-extensions enable gsconnect@andyholmes.github.io
gnome-extensions enable gtk4-ding@smedius.gitlab.com
gnome-extensions enable status-area-horizontal-spacing@mathematical.coffee.gmail.com
gnome-extensions enable places-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
SHEL
)


echo ' ==== Clearing system ===='
yay -Syu && sudo pacman -Scc && sudo pacman -Rsn $(pacman -Qdtq) && sudo rm -rf ~/.cache/thumbnails/*

echo '==== Instaling THEME ===='

su -l wlad <<< $(cat << THEM
cp /root/where/background /home/wlad/.config/
cd /home/wlad
mkdir .myscripts
cd .myscripts
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
THEM
)
cd /home/wlad/.myscript/WhiteSur-icon-theme
./install.sh -t all
cd /home/wlad/.myscript/WhiteSur-cursors
./install.sh
cd /home/wlad/.myscript/WhiteSur-gtk-theme
./install.sh -t all -c Light -c Dark -b "/home/wlad/.config/background"
./tweaks.sh -g -n -N -b "/home/wlad/.config/background"
./tweaks.sh -F
./tweaks.sh -d -c Light
sudo flatpak override --filesystem=xdg-config/gtk-4.0

echo '==== Install Light Theme ===='
su -l wlad <<< $(cat << SIT
gsettings set org.gnome.shell.extensions.user-theme name "WhiteSur-Light"
gsettings set org.gnome.desktop.interface gtk-theme WhiteSur-Light
gsettings set org.gnome.desktop.interface icon-theme  WhiteSur-dark
gsettings set org.gnome.desktop.interface cursor-theme WhiteSur-cursors
gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface document-font-name "Roboto 10"
gsettings set org.gnome.desktop.interface font-name "Roboto 10"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrains Mono 10"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Roboto Medium 10"
gsettings set org.gnome.desktop.wm.preferences theme "WhiteSur-Light"
bash /home/wlad/.myscripts/WhiteSur-gtk-theme/install.sh -l -c Light
SIT
)
cd -


# GRUB_TIMEOUT=1
# GRUB_HIDDEN_TIMEOUT_QUIET=true
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"


