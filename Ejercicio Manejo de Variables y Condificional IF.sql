USE LabT_SQL;
GO


ALTER PROCEDURE sp_comprobarStock
--1. Declaración de variables
@ID_Producto_Buscado INT,
@StockActual INT OUTPUT,
@NombreProducto VARCHAR(100) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
--2. Asignación de valores(Hardcoding para el ejemplo)
--SET @ID_Producto_Buscado=1;--(Leche Entera 1L)

--3. Obtener datos de la DB y asignarlos a las variables
-- (Esta es la forma preferida de asignar desde una consulta)
SELECT
	Stock,
	NombreProducto
FROM 
	Productos
WHERE
	ID_Producto = @ID_Producto_Buscado;

	@@IDENTITY = @StockActual;



--4. Lógica condicional(IF...ELSE)
IF @StockActual IS NOT NULL
BEGIN
	--Bloque TRUE
	IF @StockActual < 50
	BEGIN
		PRINT 'ALERTA: El stock de ' + @NombreProducto + ' es bajo (' + CONVERT(VARCHAR, @StockActual) + ' unidades).';
	END
	ELSE
	BEGIN
		PRINT 'INFO: El stock de ' + @NombreProducto + ' es suficiente (' + CONVERT(VARCHAR, @StockActual) + ' unidades).';
	END
END
ELSE
BEGIN
	--Bloque FALSE (si el producto no se encontró)
	PRINT 'ERROR: El producto con ID ' + CONVERT(VARCHAR, @ID_Producto_Buscado) + ' no existe.';
END
END
GO

EXEC sp_comprobarStock @ID_Producto_Buscado = 1;
GO