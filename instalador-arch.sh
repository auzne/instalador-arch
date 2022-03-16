#!/bin/bash
# nao suporte uefi
# somente conexão cabeada

# carrega o teclado br
echo "Carregando mapeamento de teclado BR ABNT2"
loadkeys br-abnt2

# locale br
echo "Gerando o Locale pt-br"
sed -i 's/en_US.UTF-8 UTF-8/#en_US.UTF-8 UTF-8/g' /etc/locale.gen
echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

timedatectl set-ntp true

