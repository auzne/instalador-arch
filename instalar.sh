#!/bin/bash

# carrega o teclado br
loadkeys br-abnt2

if [ $(whoami) = "root" ]
then
    if [ -b /dev/sda ]
    then
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
    else
        echo "O disco /dev/sda não foi encontrado"
    fi
else
    echo "Você não pode realizar esta operação a menos que seja root"
fi
