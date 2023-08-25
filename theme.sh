#!/usr/bin/env bash
set -e

echo '==== Copy files to directory ===='
cd /home/wlad
mkdir .myscripts
cp /home/wlad/arch/dark.sh /home/wlad/.myscripts
cp /home/wlad/arch/light.sh /home/wlad/.myscripts
cp /home/wlad/arch/update.sh /home/wlad/.myscripts
cp /home/wlad/arch/changebs.sh /home/wlad/.myscripts

echo '==== Install Flatpak package ===='
sudo flatpak install -y flathub org.mozilla.firefox org.onlyoffice.desktopeditors net.xmind.XMind io.github.shiftey.Desktop net.ankiweb.Anki org.gustavoperedo.FontDownloader com.rafaelmardojai.Blanket app.drey.Dialect com.brave.Browser de.bund.ausweisapp.ausweisapp2 com.bitwarden.desktop com.mattjakeman.ExtensionManager io.github.davidoc26.wallpaper_selector com.github.d4nj1.tlpui

echo
cd /home/wlad
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


echo '==== Instaling THEME ===='

su -l wlad <<< $(cat << THEME
cp /root/arch/background /home/wlad/.config/
cd .myscripts
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
cd /home/wlad/.myscript/WhiteSur-icon-theme
./install.sh -t all
cd /home/wlad/.myscript/WhiteSur-cursors
./install.sh
cd /home/wlad/.myscript/WhiteSur-gtk-theme
./install.sh -t all -c Light -c Dark -b "/home/wlad/.config/background"
sudo ./tweaks.sh -g -n -N -b "/home/wlad/.config/background"
./tweaks.sh -F
./tweaks.sh -d -c Light
sudo flatpak override --filesystem=xdg-config/gtk-4.0
THEME
)

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
echo 'gtk-hint-font-metrics=1' >> /home/wlad/.config/gtk-4.0/settings.ini
cp /root/arch /home/wlad
SIT
)

