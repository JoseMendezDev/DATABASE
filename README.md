# Proyecto Java + SQL Server

Sistema de gestión de usuarios con Java y SQL Server.

## Requisitos Previos

- JDK 11 o superior
- Apache NetBeans 25
- SQL Server 2021
- Microsoft JDBC Driver for SQL Server

## Configuración para Colaboradores

### 1. Descargar el Driver JDBC

1. Descarga el [Microsoft JDBC Driver for SQL Server](https://learn.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server)
2. Extrae el archivo y guarda el `.jar` en una carpeta local
3. En NetBeans: Tools → Services → Databases → Drivers → New Driver
4. Agrega el archivo `.jar` descargado

### 2. Configurar SQL Server

Ejecuta los scripts SQL en orden:
```bash
sql/01_crear_base_datos.sql
sql/02_crear_usuario.sql         # ⚠️ Cambia la contraseña
sql/03_crear_tablas.sql
sql/04_procedimientos_almacenados.sql