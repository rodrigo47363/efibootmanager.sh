#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# efiboot-manager.sh
# Autor: Rodrigo (Rodrigo-47363)
#
# Plataformas y perfiles:
#   GitHub:           https://github.com/rodrigo47363
#   Hack The Box:     Rodrigovil, https://app.hackthebox.com/users/2072477
#   LinkedIn:         https://linkedin.com/in/rodrigo-v-695728215
#   TryHackMe:        https://tryhackme.com/p/RodrigoVil
#   Twitter (X):      https://twitter.com/rodrigo47363
#   YouTube:          https://youtube.com/@Rodrigo-47363
#
# Descripción:
#   Gestión interactiva de entradas EFI (listar, eliminar, reordenar) mediante efibootmgr.
#
# Requisitos:
#   bash, efibootmgr, privilegios de root, sistema con firmware EFI.
# -----------------------------------------------------------------------------

set -euo pipefail
IFS=$'\n\t'

readonly SCRIPT_NAME="${0##*/}"

# Colores para salida
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# --- Verificar dependencias y entorno ---
verificar_dependencias() {
  if ! command -v efibootmgr &>/dev/null; then
    echo -e "${RED}ERROR:${RESET} 'efibootmgr' no está instalado. Instálalo con: sudo apt install efibootmgr" >&2
    exit 1
  fi

  if [[ ! -d /sys/firmware/efi ]]; then
    echo -e "${RED}ERROR:${RESET} El sistema no es compatible con EFI. Este script no se puede ejecutar." >&2
    exit 1
  fi

  if [[ "$EUID" -ne 0 ]]; then
    echo -e "${RED}ERROR:${RESET} Este script requiere privilegios de superusuario. Usa 'sudo'." >&2
    exit 1
  fi
}

# --- Mostrar entradas EFI ---
listar_entradas() {
  echo -e "${YELLOW}Entradas EFI actuales:${RESET}"
  efibootmgr
  echo
}

# --- Validar formato del Boot ID ---
validar_boot_id() {
  local boot_id="$1"
  if [[ ! "$boot_id" =~ ^[0-9A-Fa-f]{4}$ ]]; then
    echo -e "${RED}ERROR:${RESET} BOOT_ID inválido. Debe ser un valor hexadecimal de 4 dígitos (Ej: 0001, 1A2B)."
    return 1
  fi
  return 0
}

# --- Confirmar acción ---
confirmar() {
  local prompt_msg="$1"
  read -rp "$prompt_msg [s/N]: " resp
  [[ "$resp" =~ ^[sS]$ ]]
}

# --- Eliminar entrada EFI ---
eliminar_entrada() {
  listar_entradas

  read -rp "Ingresa el número hexadecimal de la entrada a eliminar (ej. 0001): " boot_id
  if ! validar_boot_id "$boot_id"; then
    echo -e "${RED}Entrada inválida. Operación cancelada.${RESET}"
    return
  fi

  if ! efibootmgr | grep -q "Boot$boot_id"; then
    echo -e "${RED}ERROR:${RESET} Entrada Boot$boot_id no encontrada."
    return
  fi

  if confirmar "¿Estás seguro de eliminar la entrada Boot$boot_id?"; then
    if efibootmgr -b "$boot_id" -B; then
      echo -e "${GREEN}✅ Entrada Boot$boot_id eliminada correctamente.${RESET}"
    else
      echo -e "${RED}❌ Falló la eliminación de la entrada Boot$boot_id.${RESET}"
    fi
  else
    echo "Operación cancelada."
  fi
}

# --- Cambiar orden de arranque ---
cambiar_orden() {
  echo -e "${YELLOW}Orden actual de arranque:${RESET}"
  efibootmgr | grep "^BootOrder"

  read -rp "Ingresa el nuevo orden (ej. 0001,0002,2001,...): " nuevo_orden
  # Validación sencilla: verificar que solo haya caracteres hexadecimales y comas
  if [[ ! "$nuevo_orden" =~ ^([0-9A-Fa-f]{4},)*[0-9A-Fa-f]{4}$ ]]; then
    echo -e "${RED}ERROR:${RESET} Formato inválido para el orden."
    return
  fi

  if confirmar "¿Confirmas cambiar el orden de arranque a: $nuevo_orden?"; then
    if efibootmgr -o "$nuevo_orden"; then
      echo -e "${GREEN}✅ Orden de arranque actualizado correctamente.${RESET}"
    else
      echo -e "${RED}❌ Error al actualizar el orden de arranque.${RESET}"
    fi
  else
    echo "Operación cancelada."
  fi
}

# --- Menú principal ---
menu() {
  while true; do
    echo -e "\n${YELLOW}===== Gestión EFI: Menú Principal =====${RESET}"
    echo "1) Listar entradas EFI"
    echo "2) Eliminar una entrada EFI"
    echo "3) Cambiar orden de arranque EFI"
    echo "4) Salir"
    read -rp "Selecciona una opción [1-4]: " opcion

    case "$opcion" in
      1) listar_entradas ;;
      2) eliminar_entrada ;;
      3) cambiar_orden ;;
      4) echo "Saliendo..."; exit 0 ;;
      *) echo -e "${RED}Opción inválida. Intenta de nuevo.${RESET}" ;;
    esac
  done
}

# --- Punto de entrada ---
main() {
  verificar_dependencias
  menu
}

main "$@"
