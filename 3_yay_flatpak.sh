#!/usr/bin/env bash
set -e


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

echo ' ==== Install Flatpak package ===='
sudo flatpak install -y flathub org.mozilla.firefox org.onlyoffice.desktopeditors io.github.mimbrero.WhatsAppDesktop net.xmind.XMind com.todoist.Todoist io.github.shiftey.Desktop net.ankiweb.Anki org.gustavoperedo.FontDownloader com.rafaelmardojai.Blanket app.drey.Dialect com.brave.Browser de.bund.ausweisapp.ausweisapp2 com.bitwarden.desktop com.mattjakeman.ExtensionManager com.google.Chrome io.github.davidoc26.wallpaper_selector com.todoist.Todoist com.github.d4nj1.tlpui

