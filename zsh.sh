#!/usr/bin/env bash
set -e
echo '==== ZSH ===='
chsh -s /usr/bin/zsh
# restart terminal
echo '==== oh-my-zsh ===='
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo '==== gogh ===='
# Переименовать профиль в Default
# Установить и выбрать профиль
bash -c "$(wget -qO- https://git.io/vQgMr)"

echo '==== archcraft-dwm ===='
# Выбрать шрифт Mono (JetBrains or Noto)
cd ~/.oh-my-zsh/themes
git clone https://github.com/mrx04programmer/ZshTheme-ArchCraft/
mv ZshTheme-ArchCraft/archcraft-dwm.zsh-theme $PWD
rm -rf ZshTheme-ArchCraft 
cd
# go to the section where is ZSH_THEME= and add 'archcraft-dwm'  ZSH_THEME="robbyrussell"
sed -i '/ZSH_THEME=/s/robbyrussell/archcraft-dwm/' /home/wlad/.zshrc
nano .zshrs
source .zshrc

