# Ускорение системы
pacman -S irqbalance
sudo systemctl enable --now irqbalance
# yay -Sy ananicy-cpp ananicy-rules-git
# sudo systemctl enable --now ananicy-cpp

sudo nano /etc/sysctl.d/99-sysctl.conf # Редактируем
vm.swappiness=10
cat /proc/sys/vm/swappiness

nano ~/.config/gtk-4.0/settings.ini
gtk-hint-font-metrics=1
noatime,ssd,space_cache=v2,compress=zstd:3,discard=async

https://confluence.jaytaala.com/display/TKB/Use+a+swap+file+and+enable+hibernation+on+Arch+Linux+-+including+on+a+LUKS+root+partition
