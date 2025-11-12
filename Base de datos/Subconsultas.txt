USE Northwind
GO

--Módulo 1: Subconsultas
--Ejercicio 1.1: Uso de IN (Membresía en un conjunto)
SELECT CompanyName, ContactName
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);
GO

--Ejercicio 1.2: Uso de NOT IN (Exclusión de un cojunto)
SELECT ProductName
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM [Order Details]);
GO

--Ejercicio 1.3: Uso de EXISTS (Verificación de existencia)
SELECT CompanyName, ContactName
FROM Customers c
WHERE EXISTS (
	SELECT 1 -- El '1' es convencional, solo importa si devuelve filas
	FROM Orders o
	WHERE o.CustomerID = c.CustomerID
);
GO

--Módulo 2: Funciones Escalares
--Parte A: Funciones de Fecha
-- Ejercicio 2.1: GETDATE, DAY, MONTH, YEAR
SELECT
	OrderID,
	OrderDate,
	DAY(OrderDate) AS DiaPedido,
	MONTH(OrderDate) AS MesPedido,
	YEAR(Orderdate) AS AnioPedido
FROM Orders;
GO

-- Ejercicio 2.2: DATEDIFF (Diferencia de fechas)
SELECT
	OrderID,
	OrderDate,
	ShippedDate,
	DATEDIFF(day, OrderDate, ShippedDate) AS DiasDeGestion
	FROM Orders
	WHERE ShippedDate IS NOT NULL;
GO

-- Ejercicio 2.3: DATEADD (Añadir a fechas)
SELECT
	OrderID,
	OrderDate,
	DATEADD(day, 30, OrderDate) AS FechaVencimiento
FROM Orders;
GO

-- Parte B: Funciones de Cadena
-- Ejercicio 2.4: UPPER, LOWER, CONCAT
SELECT
	UPPER(CONCAT(LastName, ', ', Firstname)) AS [Nombre Completo]
	FROM Employees

-- Ejercicio 2.4: LEN, SUBSTRING, LTRIM, RTRIM
SELECT
	CompanyName, 
	LEN(CompanyName) [Longitud Nombre],
	CustomerID,
	SUBSTRING(CustomerID, 1, 3) [Codigo Cliente]
FROM Customers;
GO

-- Parte C: Funciones de Conversión
-- Ejercicio 2.6: CAST (Conversión de tipo)
SELECT
	ProductName,
	UnitPrice,
	CAST(UnitPrice AS INT) [Precio Entero]
FROM Products;
GO

-- Ejercicio 2.7: CONVERT (Formate de fechas y números)
SELECT
	OrderID,
	OrderDate,
	CONVERT(VARCHAR(10), OrderDate, 103) AS FechaLatam,
	CONVERT(VARCHAR(10), OrderDate, 120) AS FechaISO
FROM Orders;
GO

-- Módulo 3: Desafío de Integración
SELECT 
	c.CompanyName,
	o.OrderID,
	CONCAT(
	'Pedido realizado en el Mes: ',
	CAST(MONTH(o.OrderDate) AS VARCHAR(2)),
	', Día:', 
	CAST(DAY(o.OrderDate) AS VARCHAR(2)))
	AS [Reporte Fecha]
FROM 
	Customers c
JOIN 
	Orders o ON c.CustomerID = o.CustomerID
WHERE 
	c.Country = 'USA'
	AND YEAR(o.OrderDate) = 1997
ORDER BY c.CompanyName;
GO

-- ACTIVIDADES PROPUESTAS
-- I. Nivel Básico - Enfoque en Funciones
-- Funciones de Cadena
SELECT 
	ProductName,
	UPPER(ProductName) Mayuscula, 
	LEN(ProductName) Longitud
FROM 
	Products
GO

-- Funciones de Fecha
SELECT GETDATE() [Fecha Actual], YEAR(GETDATE()) Anio

-- Funciones de Conversión
SELECT 
	ProductName, 
	CONCAT('$ ',CAST(UnitPrice AS VARCHAR(7))) [Precio Unitario]
FROM
	Products
GO

--Subconsulta Escalar
SELECT 
	ProductName, 
	UnitPrice
FROM
	Products
WHERE
	UnitPrice > (
	SELECT AVG(UnitPrice)
	FROM Products);
GO

-- II. Nivel Intermedio - Enfoque en Combinación de Funciones y Subconsultas
SELECT 
	OrderId, 
	OrderDate, 
	CONVERT(VARCHAR(10),OrderDate, 105) [Día-Mes-Año]
FROM 
	Orders
GO

-- Cadena y Subconsulta
SELECT 
	CompanyName, 
	City
FROM 
	Customers c
WHERE 
	SUBSTRING(CompanyName, 1, 3) = (SELECT SUBSTRING(City, 1, 3)
	FROM 
		Customers c2
	WHERE c2.CustomerID = c.CustomerID);
GO

-- Subconsulta de Múltiples Valores


