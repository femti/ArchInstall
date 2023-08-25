#!/usr/bin/env bash
set -e

echo '==== Copy files to directory ===='
cd /home/wlad
mkdir .myscripts
cp -r /home/wlad/arch/scripts /home/wlad/.myscripts
cd

echo '==== Install Flatpak package ===='
sudo flatpak install -y flathub org.onlyoffice.desktopeditors net.xmind.XMind io.github.shiftey.Desktop net.ankiweb.Anki org.gustavoperedo.FontDownloader com.rafaelmardojai.Blanket app.drey.Dialect com.brave.Browser de.bund.ausweisapp.ausweisapp2 com.bitwarden.desktop com.mattjakeman.ExtensionManager io.github.davidoc26.wallpaper_selector com.github.d4nj1.tlpui

echo 'Enable Gnome extensions ===='
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
cp /home/wlad/arch/background /home/wlad/.config/
cd .myscripts
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
git clone https://github.com/vinceliuice/WhiteSur-cursors.git
cd /home/wlad/.myscripts/WhiteSur-icon-theme
./install.sh -t all
cd /home/wlad/.myscripts/WhiteSur-cursors
./install.sh
cd /home/wlad/.myscripts/WhiteSur-gtk-theme
./install.sh -t all -c Light -c Dark -b "/home/wlad/.config/background"
sudo ./tweaks.sh -g -n -N -b "/home/wlad/.config/background"
./tweaks.sh -F
./tweaks.sh -d -c Light
sudo flatpak override --filesystem=xdg-config/gtk-4.0


echo '==== Install Light Theme ===='
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

echo 'Copy scripts to bin'
cd /home/wlad/.mysrcipts/scripts
chmod +x light
chmod +x dark
chmod +x upd
chmod +x chbs
sudo cp light /usr/bin
sudo cp dark /usr/bin
sudo cp upd /usr/bin
sudo cp chbs /usr/bin
cd

