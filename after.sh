#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl grub os-prober mtools dialog wpa_supplicant dhcpcd vim git make alsa-firmware wget xorg-server pulseaudio xorg-xinit curl tar libxft ranger fakeroot binutils patch pkgconf base-devel
#obs-studio

# Set date time
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc

# Set locale to en_US.UTF-8 UTF-8
echo "en_US.UTF-8 UTF-8
pl_PL.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen

# Set hostname
echo "ARCH" >> /etc/hostname
echo "
127.0.0.1	localhost
::1		localhost
127.0.1.1	ARCH" >> /etc/hosts

# Set root passwd
echo -en "root\nroot" | passwd

# Useradd,internet and sudo 
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
systemctl enable dhcpcd
useradd -m tajo48
echo -en "pass\npass" | passwd tajo48
usermod -aG wheel,audio,video,optical,storage,users tajo48

# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

<<testi3
#i3 wm
pacman -S --noconfirm i3-gaps feh firefox rxvt-unicode rofi neofetch termite
echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
setxkbmap -layout 'pl'
exec dwm" >> ~/.xinitrc
mkdir /home/tajo48/photos
cd /home/tajo48/photos
wget https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg
startx

###DWM part



#wallpaper
mkdir /home/tajo48/photos
wget https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg

#dwm try
cd /home/tajo48
echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
setxkbmap -layout 'pl'
exec dwm" >> ~/.xinitrc
pacman -S --noconfirm feh firefox rxvt-unicode neofetch

#download (almost temporary)
git clone https://git.suckless.org/dwm/
git clone https://git.suckless.org/st/
git clone https://git.suckless.org/dmenu/

###DWM

#wgetpatch (temporary)
cd /home/tajo48/dwm
wget https://dwm.suckless.org/patches/fakefullscreen/dwm-fakefullscreen-20170508-ceac8c9.diff
wget https://dwm.suckless.org/patches/pertag/dwm-pertag-6.2.diff
wget https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-6.2.diff
wget https://dwm.suckless.org/patches/movestack/dwm-movestack-6.1.diff

#patch (temporary)
cp dwm.c dwm.c.orig
patch < dwm-fakefullscreen-20170508-ceac8c9.diff
patch < dwm-pertag-6.2.diff
patch < dwm-uselessgap-6.2.diff
patch < dwm-movestack-6.1.diff

###DMENU

#wgetpatch (temporary)
cd /home/tajo48/dmenu
wget https://tools.suckless.org/dmenu/patches/center/dmenu-center-4.8.diff

#patch (temporary)
patch < dmenu-center-4.8.diff

###MKPKG

#cp config.h config.def.h
#makekpkg
cd /home/tajo48/st
make clean install
cd /home/tajo48/dmenu
make clean install
cd /home/tajo48/dwm
make clean install

startx
