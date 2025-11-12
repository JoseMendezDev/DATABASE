USE Northwind
GO

--A.- Funciones Agregadas Básicas
--1. Total de Productos
SELECT COUNT(*) AS TotalProductos
FROM Products;
GO

--2. Análisis de Precios
SELECT	AVG(UnitPrice) AS PrecioPromedio,
		MAX(UnitPrice) AS PrecioMaximo,
		MIN(UnitPrice) AS PrecioMinimo
FROM Products;
GO
--3. Total de Unidades en Stock
SELECT SUM(UnitsInStock) AS TotalUnidadesEnStock
FROM Products;
GO

--B.- Agrupación de Datos con GROUP BY
--4. Productos por Categoría
SELECT CategoryID, COUNT(ProductID) AS CantidadProductos
FROM Products
GROUP BY CategoryID;
GO
--5. Precio Promedio por Proveedor
SELECT SupplierID, AVG(UnitPrice) AS PrecioPromedio
FROM Products
GROUP BY SupplierID
ORDER BY PrecioPromedio DESC;
GO
--6. Total de Unidades por Orden
SELECT OrderID, SUM(Quantity) AS TotalUnidades
FROM [Order Details]
GROUP BY OrderID;
GO

--C. Filtrado de Grupos con HAVING
--7. Categorías con más de 10 productos
SELECT CategoryID, COUNT(ProductID) AS TotalProductos
FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) > 10;
GO
--8. Países con más de 5 clientes
SELECT Country, COUNT(CustomerID) AS TotalClientes
FROm Customers
GROUP BY Country
HAVING NOT COUNT(CustomerID) <= 5;
GO
--9. Órdenes con más de 300 unidades
SELECT OrderID, SUM(Quantity) AS TotalUnidades
FROM [Order Details]
GROUP BY OrderID
HAVING NOT SUM(Quantity) <= 300;
GO

--D. Ejercicios Resueltos con Agrupación y Filtrado
--10. Valor del Inventario por  Categoria
SELECT T1.CategoryName,
		SUM(T2.UnitsInStock * T2.UnitPrice) ValorTotalInventario
FROM Categories T1
INNER JOIN Products T2 ON T1.CategoryID = T2.CategoryID
GROUP BY T1.CategoryName
ORDER BY ValorTotalInventario DESC;
GO
--11. Clientes por Título de Contacto (Filtrando grupos)
SELECT ContactTitle,
		COUNT(CustomerID) TotalClientes
FROM Customers
GROUP BY ContactTitle
HAVING COUNT(CustomerID) > 5;
GO
-- 12. Países de Envío con FLete Promedio Alto
SELECT ShipCountry,
		AVG(Freight) AS FletePromedio
FROM Orders
GROUP BY ShipCountry
HAVING AVG(Freight) > 50
ORDER BY FLetePromedio DESC;
GO



