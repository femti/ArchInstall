

sudo dd if=/dev/zero of=/swapfile bs=1M count=17408
sudo mkswap /swapfile
sudo chmod 600 /swapfile
sudo swapon /swapfile
# Копирование строчки управления FSTAB
echo '/swapfile none    swap    defaults 0 0' | sudo tee -a /etc/fstab
# Проверка мотирования файла
sudo mount -a
# 

user $ sudo swapoff -a
user $ sudo dd if=/dev/zero of=/swapfile bs=1024 count=4M
user $ sudo chmod 600 /swapfile
user $ sudo mkswap /swapfile
user $ sudo swapoff -a
user $ sudo swapon /swapfile

/swapfile	none	swap	sw	0	0
###################################################################################
export fs_uuid=$(findmnt / -o UUID -n) && echo ${fs_uuid}
sudo mount -m -U $fs_uuid /mnt/system-${fs_uuid}
sudo btrfs subvolume create /mnt/system-${fs_uuid}/@swap
sudo umount /mnt/system-${fs_uuid}
sudo mount -m -U ${fs_uuid} -o subvol=@swap,nodatacow /swap

sudo truncate -s 0 /swap/swapfile
sudo chattr +C /swap/swapfile
export swp_size=$(echo "$(grep "MemTotal" /proc/meminfo | tr -d "[:blank:],[:alpha:],:") * 1.6 / 1000" | bc ) && echo ${swp_size}M
sudo fallocate -l ${swp_size}M /swap/swapfile
sudo chmod 0600 /swap/swapfile
sudo mkswap /swap/swapfile

sudo umount /swap
echo -e "UUID=$fs_uuid\t/swap\tbtrfs\tsubvol=@swap,nodatacow,noatime,nospace_cache\t0\t0" | sudo tee -a /etc/fstab
echo -e "/swap/swapfile\tnone\tswap\tdefaults\t0\t0" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo mount /swap
sudo swapon -a
swapon -s


#######################################################################
cd ~/Downloads
gcc -O2 -o btrfs_map_physical btrfs_map_physical.c
sudo ./btrfs_map_physical /swap/swapfile
sudo ./btrfs_map_physical /swap/swapfile | cut -f 9 | head -2
getconf PAGESIZE
resume=UUID=UUID-OF-DEV-MAPPER-CRYPTROOT resume_offset=CALCULATED-VALUE
#######################################################################
export swp_uuid=$(findmnt -no UUID -T /swap/swapfile) && echo $swp_uuid
curl -s "https://raw.githubusercontent.com/osandov/osandov-linux/master/scripts/btrfs_map_physical.c" > bmp.c
gcc -O2 -o bmp bmp.c
swp_offset=$(echo "$(sudo ./bmp /swap/swapfile | egrep "^0\s+" | cut -f9) / $(getconf PAGESIZE)" | bc) && echo $swp_offset
echo -e "GRUB_CMDLINE_LINUX_DEFAULT+=\" resume=UUID=$swp_uuid resume_offset=$swp_offset \"" | sudo tee -a /etc/default/grub
echo -e "HOOKS+=( resume )" | sudo tee -a /etc/mkinitcpio.conf
sudo mkdir -pv /etc/systemd/system/{systemd-logind.service.d,systemd-hibernate.service.d}
echo -e "[Service]\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" | sudo tee /etc/systemd/system/systemd-logind.service.d/override.conf
echo -e "[Service]\nEnvironment=SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK=1" | sudo tee /etc/systemd/system/systemd-hibernate.service.d/override.conf
sudo mkinitcpio -P && sudo grub-mkconfig -o /boot/grub/grub.cfg 


btrfs inspect-internal map-swapfile -r /swap/swapfile
