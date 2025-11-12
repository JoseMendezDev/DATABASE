/*
CREACION DE BASE DE DATOS Y TABLAS
*/
--1. Crear la Base de Datos
CREATE DATABASE LabT_SQL;
GO

--2. Usar la nueva Base de Datos
USE LabT_SQL;
GO

--3. Crear Tabla Categorias
CREATE TABLE Categorias(
	ID_Categoria INT PRIMARY KEY IDENTITY(1,1),
	NombreCategoria VARCHAR(100) NOT NULL,
	Descripcion VARCHAR(255)
);
GO

--4. Crear Tabla Productos
CREATE TABLE Productos(
	ID_Producto INT PRIMARY KEY IDENTITY(1,1),
	NombreProducto VARCHAR(100) NOT NULL,
	Precio DECIMAL(10,2) NOT NULL,
	Stock INT NOT NULL,
	ID_Categoria INT,
	FOREIGN KEY(ID_Categoria) REFERENCES Categorias(ID_Categoria)
);
GO

--5. Insertar Datos de Muestra
INSERT INTO Categorias(NombreCategoria, Descripcion) VALUES
	('Lácteos', 'Productos derivados de la leche'),
	('Panaderia', 'Panes y pasteles frescos'),
	('Bebidas', 'Jugos, gaseosas y agua');
GO

INSERT INTO Productos (NombreProducto, Precio, Stock, ID_Categoria) VALUES
	('Leche Entera 1L', 4.50, 50, 1),
	('Queso Fresco 500g', 15.00, 30, 1),
	('Pan de Molde Integral', 5.20, 100, 2),
	('Yogurt Natural 1L', 6.00, 40, 1),
	('Jugo de Naranja 2L', 8.50, 60, 3),
	('Agua Mineral 1.5L', 2.50, 150, 3);
GO

PRINT 'Entorno de Laboratorio creado exitosamente en LabT_SQL.';
GO
