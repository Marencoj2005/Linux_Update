#!/bin/bash

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"
LOG_DIR="/var/log/apt/info_actualizacion"
LOG_FILE="$LOG_DIR/informe.txt"

echo -e "${GREEN}        -----------------LINUX UPGRADE -----------------------${GREEN}"
echo "   DEBES EJECUTAR ESTE SCRIPT COMO SUPER-USUARIO, MAS ADELANTE TE QUITARÉ ESE PASO :3, SI NO ES ASI, VUELVE A EJECUTAR EL SCRIPT COMO 
   CON SUPER-USUARIO   " 
echo ""
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
            echo "                  Ok! INICIADO ACTUALIZACIÓN                "
            sudo apt update -y
            mkdir /var/log/apt/info_actualizacion
            sudo apt full-upgrade -y &> $LOG_FILE
            if sudo apt full-upgrade -y | grep -q "0 actualizados, 0 nuevos se instalarán, 0 para eliminar y 0 no actualizados."
            then
                #clear
                echo -e "${RED}     ---- SIN ACTUALIZACIONES DISPONIBLES --- ${RESET}"
                echo "       INFORME GUARDADO EN LA CARPETA /var/log/apt                   "
            else
                echo "${GREEN}      --- SISTEMA ACTUALIZADO CON EXITO ---    ${RESET}"
                echo "       INFORME GUARDADO EN LA CARPETA /var/log/apt                   "
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