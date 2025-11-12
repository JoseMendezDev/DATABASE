USE Northwind
GO

--ACTIVIDADES PROPUESTAS
--Nivel Básico
SELECT EmployeeID, COUNT(OrderID) AS TotalOrdenes
FROM Orders
GROUP BY EmployeeID
ORDER BY TotalOrdenes DESC
GO

SELECT SupplierID
FROM Products
GROUP BY SupplierID
HAVING MAX(UnitPrice) > 50
GO

SELECT OrderID, AVG(Discount) AS DescuentoPromedio
FROM [Order Details]
GROUP BY OrderID
HAVING AVG(Discount) > 0.05
GO

SELECT City, COUNT(CustomerID) AS Clientes 
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2
GO


--Nivel Intermedio
SELECT City, MAX(BirthDate) AS Nacimiento
FROM Employees
GROUP BY City
HAVING COUNT(EmployeeID) > 1
GO

SELECT ProductID, MIN(Quantity) AS VentaMinima
FROM [Order Details]
GROUP BY ProductID
HAVING MIN(Quantity) > 1
GO

SELECT SupplierID, SUM(UnitsInStock) AS Stock
FROM Products
GROUP By SupplierID
HAVING SUM(UnitsInStock) < 100
GO

SELECT ShipCountry ,AVG(Freight) AS FletePromedio
FROM Orders
GROUP BY ShipCountry
HAVING AVG(Freight) BETWEEN 20.00 AND 50.00
ORDER BY FletePromedio DESC;
GO

SELECT CustomerID, COUNT(OrderID) AS Ordenes
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) < 5
GO

SELECT OrderID, MAX(Discount) AS MaximoDescuento, MIN(Discount) AS MinimoDescuento
FROM [Order Details]
GROUP BY OrderID
HAVING MAX(Discount) > MIN(Discount)
GO

SELECT * FROM Employees
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Suppliers
SELECT * FROM Products
SELECT * FROM [Order Details]