#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"


echo -e "${GREEN}        -----------------LINUX UPGRADE -----------------------${GREEN}"
echo -e "${GREEN}     ¿DESEA ACTUALIZAR TODO LOS PAQUETES Y REPOSITORIOS?     ${RESET}"

echo "[Y] Si"
echo "[N] NO"
echo ""

read input  
shopt -s nocasematch
if [[ "$input" = "y" ]]
then
    echo "   ¿Desea Guardar los datos y errores de la actualización en un Documento?"
    echo "[Y] si / yes"
    echo "[N] No"
    read option2
    
    case $option2 in 
        [yY])
            clear
            echo "            Ok! INICIADO ACTUALIZACIÓN                "
            sudo apt update -y
            sudo apt full-upgrade -y &> informe.txt
            if sudo apt full-upgrade -y | grep -q "0 actualizados, 0 nuevos se instalarán, 0 para eliminar y 0 no actualizados."
            then
                echo -e "${RED}     ---- SIN ACTUALIZACIONES DISPONIBLES --- ${RESET}"
            else
                echo "${GREEN}      --- SISTEMA ACTUALIZADO CON EXITO ---    ${RESET}"
            fi
            ;;
        [nN])
            clear
            echo "Ok!, Solo se hará las actualizaciónes"
            sudo apt update -y
            sudo apt full-upgrade -y 
            if sudo apt full-upgrade -y | grep -q "0 actualizados, 0 nuevos se instalarán, 0 para eliminar y 0 no actualizados." | grep -q "Todos los paquetes están actualizados."
            then
                echo "${RED}      ----- SIN ACTUALIZACIONES DISPONIBLE -----     ${RESET}"
            else
                echo -e "${GREEN}  ----- SISTEMA ACTUALIZADO CON EXITO ----- ${RESET}"
            fi
            ;;
        *) 
            echo -e "${RED} ----- OPCIÓN INVÁLIDA -----  ${RESET}"
    esac
elif [[ "$input" = "n" ]]
then
    echo -e "${RED} ------------ NO SE ACTUALIZARÁ EL SISTEMA ----------------- ${RESET}"
fi