#!/bin/bash
# nao suporte uefi
# somente conexão cabeada


# carrega o teclado br
loakeys br-abnt2

echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

timedatectl set-ntp true


