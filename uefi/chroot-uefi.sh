#!/bin/bash

# fuso horario da maquina
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# locale br
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# configurações do idioma e teclado
echo 'LANG=pt_BR.UTF-8' > /etc/locale.conf
echo 'KEYMAP=br-abnt2' > /etc/vconsole.conf

# hosts e hostname
echo 'instalador' > /etc/hostname
echo '127.0.0.1	localhost.localdomain	localhost' >> /etc/hosts
echo '::1		localhost.localdomain	localhost'  >> /etc/hosts
echo '127.0.1.1	instalador.localdomain	instalador' >> /etc/hosts

# ativa o networkmanager
systemctl enable NetworkManager

clear
# troca senha do root
echo "Digite a senha do root"
passwd

# instala o pacote do grub
pacman -Sy --noconfirm grub

# instala o grub no sda
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# configura o grub
grub-mkconfig -o /boot/grub/grub.cfg

# sai do chroot
exit
