#!/bin/bash
echo "================================="
echo "     REPORTE DE MONITOREO G1      "
echo "================================="
echo
echo "Fecha y hora: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Servidor: $(hostname)"
echo
echo "-- Usuarios Conectados --"
who | wc -l
echo
echo "-- Espacio disponible en disco --"
df -h / | awk 'NR==2 {print "Disponible: " $4 " | Uso: " $5}'
echo
echo " --- Memoria RAM --- "
free -h | awk '/Mem:/ {print "Disponible: " $7 " | Total: " $2}'
echo
echo " --- Contenedores Docker Activos ---"
if command -v docker >/dev/null 2>&1; then
   if sudo -n -u adminsys docker info >/dev/null 2>&1; then
        sudo -n -u adminsys docker ps -q | wc -l
   else
        echo "Docker está instalado, pero no se puede consultar el servicio"
    fi
else
    echo "Docker no está instalado :( o no está disponible en el PATHH. "
fi
echo "=:=:=:=:=:=:=:=ISL135 GRUPO 1=:=:=:=:=:=:=:=:=:="
