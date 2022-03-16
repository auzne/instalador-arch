#!/bin/bash

# fuso horario da maquina
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# locale br
#sed -i 's/en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/g' /etc/locale.gen
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

clear
# troca senha do root
echo "Digite a senha do root"
passwd

# sai do chroot
exit

