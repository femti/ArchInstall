#!/usr/bin/env bash

echo 'install Dark Theme'
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
