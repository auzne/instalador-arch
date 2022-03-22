#!/bin/bash

# locale br
sed -i 's/en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

# fuso horario
timedatectl set-ntp true
timedatectl set-timezone America/Sao_Paulo

# particionando o disco
(
    echo n; echo ""; echo ""; echo "+300M"; echo "EF00";
    echo n; echo ""; echo ""; echo "+1G"; echo "8200";
    echo n; echo ""; echo ""; echo ""; echo "";
    echo w; echo Y;
) | gdisk /dev/sda

# formatando as partições
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.fat -F 32 /dev/sda1

# montando as partições
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2

# instalação dos pacotes basicos
pacstrap /mnt base linux linux-firmware nano man git sudo networkmanager

# gerando o arquivo fstab
genfstab -U /mnt >> /mnt/etc/fstab

# copia o arquivo do instalador pós chroot para o /mnt
cp /root/instalador-arch/uefi/chroot-uefi.sh /mnt/chroot.sh

# mudando a raiz
arch-chroot /mnt /bin/bash -c "chmod +x ./chroot.sh; ./chroot.sh"

# quando o chroot finalizar
# apaga o arquivo de instalação
rm /mnt/chroot.sh

# desmonta os discos
umount -R /mnt

clear
# informa o usuário
echo "Para utilizar seu sistema, remova a mídia de instalação e ligue novamente o computador"
read -t 30 -n 1 -s -r -p "Pressione qualquer tecla para continuar"

# desliga o computador
poweroff
