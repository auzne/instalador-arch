#!/bin/bash

# carrega o teclado br
loadkeys br-abnt2

echo "O disco /dev/sda será formatado para a instalação do arch linux"
echo "A instalação requer conexão com a internet"
echo "Continuar? [S/n]"
read start

if [ $start = "S" ] || [ $start = "s" ]
then
    if [ -d /sys/firmware/efi/efivars ]
    then
        ./uefi/instalar-uefi.sh
    else
        ./bios/instalar-bios.sh
    fi
else
    echo "Cancelando instalação"
fi
