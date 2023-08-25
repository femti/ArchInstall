#!/usr/bin/env bash
set -e
echo '==== ZSH ===='
chsh -s /usr/bin/zsh
echo '==== oh-my-zsh ===='
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


id=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'") 
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$id/ visible-name 'Default'

echo '==== archcraft-dwm ===='
cd ~/.oh-my-zsh/themes
git clone https://github.com/mrx04programmer/ZshTheme-ArchCraft/
mv ZshTheme-ArchCraft/archcraft-dwm.zsh-theme $PWD
rm -rf ZshTheme-ArchCraft 
cd
sed -i '/ZSH_THEME=/s/robbyrussell/archcraft-dwm/' /home/wlad/.zshrc
source .zshrc

# echo '==== gogh ===='
# bash -c "$(wget -qO- https://git.io/vQgMr)"
