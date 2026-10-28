# Proyecto Final: Servidor de Servicios GNU/Linux y Contenedores

**Universidad de El Salvador**
**Facultad Multidisciplinaria de Occidente**
**Departamento de Ingeniería y Arquitectura**
**Carrera:** Ingeniería en Desarrollo de Software
**Asignatura:** Introducción al Software Libre (ISL135) — Ciclo II 2026
**Grupo de Trabajo:** Grupo 1

---

## 1. Ficha Técnica de Infraestructura

- **Hostname:** `servidor-grupo1`
- **Sistema Operativo Base:** Debian GNU/Linux 13 (Trixie)
- **Entorno de Despliegue:** Contenedor Proxmox VE LXC (ID: 201 / 205)
- **Dirección IP Principal:** `192.168.1.101/24` (eth1)
- **Gestión de Permisos:** SGID activo para persistencia de grupo en directorios operativos.

---

## 2. Estructura del Árbol de Trabajo (`/proyecto`)

El servidor centraliza todas las operaciones y servicios bajo el árbol jerárquico `/proyecto`, distribuido de la siguiente forma:

| Directorio | Grupo Asignado | Permisos Octales | Bit Especial | Propósito |
| :--- | :--- | :---: | :---: | :--- |
| `/proyecto/datos/` | `soporte` | `2775` (`rwxrwsr-x`) | **SGID** | Archivos de configuración del sistema y persistencia operativa. |
| `/proyecto/web/` | `web` | `2775` (`rwxrwsr-x`) | **SGID** | DocumentRoot de páginas servidas por contenedores Nginx. |
| `/proyecto/scripts/` | `root` | `0755` (`rwxr-xr-x`) | - | Scripts Bash de monitoreo, automatización y tareas Cron. |
| `/proyecto/capturas/`| `root` | `0755` (`rwxr-xr-x`) | - | Registro de evidencias de ejecución y pruebas de validación. |

---

## 3. Matriz de Usuarios y Grupos del Sistema

| Usuario | Shell | Grupo Primario | Grupos Secundarios | Rol / Responsabilidad |
| :--- | :---: | :---: | :---: | :--- |
| `adminsys` | `/bin/bash` | `adminsys` | `sudo` | Administración general del sistema con elevación de privilegios. |
| `tecnico` | `/bin/bash` | `tecnico` | `soporte` | Operación y mantenimiento de datos técnicos en `/proyecto/datos`. |
| `visitante` | `/bin/bash` | `visitante` | `web` | Gestión y edición de contenido web estático en `/proyecto/web`. |

---

## 4. Mapa de Servicios y Puertos en Contenedores (Docker)

Durante el despliegue de las fases del proyecto se orquestan los siguientes servicios:

| Servicio | Contenedor | Imagen Base | Puerto Host | Puerto Contenedor | Tipo de Montaje / Red |
| :--- | :--- | :--- | :---: | :---: | :--- |
| **Prueba Inicial** | `servidor-prueba` | `hello-world` | N/A | N/A | Verificación del runtime Docker. |
| **Web Host** | `servidor-web` | `nginx:alpine` | `8080` | `80` | Bind-mount directo de `/proyecto/web/`. |
| **Web Personalizado** | `servidor-custom` | `web-grupo1:v1` | `8081` | `80` | Dockerfile personalizado (HTML embebido). |
| **Web de Red 1** | `servidor-net1` | `nginx:alpine` | `8082` | `80` | Red tipo bridge `red-proyecto` + volumen persistente. |
| **Web de Red 2** | `servidor-net2` | `nginx:alpine` | `8083` | `80` | Red tipo bridge `red-proyecto` + volumen persistente. |

---

## 5. Estrategia de Ramas en Git (GitFlow)

El repositorio sigue un flujo estructurado de integración continua:

- `main`: Rama de producción y versión estable entregable para la evaluación final.
- `develop`: Rama de integración común donde convergen los módulos antes de la entrega final.
- `feat/sistema-git`: **Integrante 1** (Entorno base, usuarios, SGID y repositorio).
- `feat/monitoreo-docker`: **Integrante 2** (Script de monitoreo, Cron y motor Docker).
- `feat/nginx-imagen`: **Integrante 3** (Despliegue Nginx puerto 8080 y Dockerfile puerto 8081).
- `feat/redes-volumenes`: **Integrante 4** (Redes bridge, volúmenes puertos 8082/8083 y pruebas Alpine).

---

## 6. Integrantes del Equipo 1

- **Integrante 1:** *Rickelmy Josepf Cubías Alvarado* — Carnet: `CA04073`
- **Integrante 2:** *Uber de Jesús Barillas Quijada* — Carnet: `BQ24002`
- **Integrante 3:** *Gerardo Andrés Rodríguez Herrador* — Carnet: `RH19056`
- **Integrante 4:** *Carlos Ernesto García Ocampo* — Carnet: `GO25003`
