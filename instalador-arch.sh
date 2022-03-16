#!/bin/bash
# nao suporte uefi
# somente conexão cabeada

# carrega o teclado br
loadkeys br-abnt2

# locale br
sed -i 's/en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# fuso horario
timedatectl set-ntp true
timedatectl set-timezone America/Sao_Paulo

# particionando o disco
(echo n; echo p; echo ""; echo ""; echo "+1G"; echo t; echo 82; echo n; echo p; echo ""; echo ""; echo ""; echo w;) | fdisk /dev/sda
clear
fdisk -l

# formatando as partições
mkfs.ext4 /dev/sda2
mkswap /dev/sda1

# montando as partições
mount /dev/sda2 /mnt
swapon /dev/sda1

# instalação dos pacotes basicos
pacstrap /mnt base linux linux-firmware nano man wget dhcpcd

# gerando o arquivo fstab
genfstab -U /mnt >> /mnt/etc/fstab

# mudando a raiz
arch-chroot /mnt

# fuso horario da maquina
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

