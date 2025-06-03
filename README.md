
# efibootmanager.sh
> **Gestión interactiva de entradas EFI para sistemas UEFI con `efibootmgr`**

---

## 📋 Descripción

`efibootmanager.sh` es un script Bash que facilita la administración de las entradas de arranque EFI en sistemas Linux con firmware UEFI.  
Proporciona una interfaz interactiva y segura para listar, eliminar y reordenar entradas EFI usando la herramienta `efibootmgr`.

---

## ⚙️ Características

- Validación automática de dependencias y entorno.
- Menú interactivo con opciones claras y confirmaciones para evitar errores.
- Listado de entradas EFI actuales.
- Eliminación segura de entradas EFI específicas.
- Reordenamiento flexible del orden de arranque EFI.
- Mensajes claros y manejo robusto de errores.
- Compatible con sistemas Linux con firmware UEFI y permisos root.

---

## 📌 Requisitos

- Sistema operativo Linux con firmware UEFI activo.
- Bash (`#!/usr/bin/env bash`).
- Herramienta `efibootmgr` instalada y disponible en PATH.
- Permisos de superusuario (ej. mediante `sudo`).
- Directorio `/sys/firmware/efi` accesible (indica soporte EFI).

---

## 🚀 Instalación y Uso

### 1. Clonar o descargar el repositorio

```bash
git clone https://github.com/rodrigo47363/efibootmanager.sh/
cd efibootmanager.sh
````

### 2. Otorgar permisos de ejecución

```bash
chmod +x efibootmanager.sh
```

### 3. Ejecutar el script con privilegios de superusuario

```bash
sudo ./efibootmanager.sh
```

### 4. Interactuar con el menú

Al iniciar, se mostrará un menú con las siguientes opciones:

| Opción | Acción                   |
| ------ | ------------------------ |
| 1      | Listar entradas EFI      |
| 2      | Eliminar una entrada EFI |
| 3      | Reordenar entradas EFI   |
| 4      | Salir                    |

---

## 💡 Ejemplo práctico: Eliminar una entrada EFI

1. Selecciona la opción `2` del menú.
2. Visualiza las entradas listadas para identificar la que deseas eliminar.
3. Introduce el ID de la entrada a eliminar (ejemplo: `0001`).
4. Confirma la eliminación cuando el script lo solicite.

---

## 🔒 Seguridad y recomendaciones

> ⚠️ **Precaución:** Manipular entradas EFI incorrectamente puede impedir que tu sistema arranque.

* Revisa cuidadosamente las entradas EFI antes de eliminar o modificar.
* Realiza un respaldo de la configuración EFI cuando sea posible.
* Utiliza este script únicamente en sistemas donde tengas control y autorización.

---

## 📞 Contacto y Redes Sociales

| Plataforma        | Usuario / Enlace                                          |
| ----------------- | --------------------------------------------------------- |
| GitHub            | [rodrigo47363](https://github.com/rodrigo47363)           |
| LinkedIn          | [Rodrigo V.](https://linkedin.com/in/rodrigo-v-695728215) |
| YouTube           | [Rodrigo-47363](https://youtube.com/@Rodrigo-47363)       |
| Hack The Box      | [Rodrigovil](https://app.hackthebox.com/users/2072477)    |
| TryHackMe         | [RodrigoVil](https://tryhackme.com/p/RodrigoVil)          |
| X (antes Twitter) | [@rodrigo47363](https://twitter.com/rodrigo47363)         |

---

## 📄 Licencia

MIT License. Consulta el archivo [`LICENSE`](LICENSE) para más detalles.

---

*Desarrollado por Rodrigo (Rodrigo-47363) — Hacking Ético & Pentesting*

```
