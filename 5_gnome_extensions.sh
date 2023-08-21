#!/usr/bin/env bash
set -e

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


