USE LabT_SQL
GO

CREATE FUNCTION fn_StockValorizadoTotal ( 
@ID_Producto INT 
) 
RETURNS DECIMAL(10, 2)
AS 
BEGIN
	DECLARE @ValorTotal DECIMAL(10, 2);
	SELECT @ValorTotal = Precio * Stock
	FROM Productos
	WHERE ID_Producto = @ID_Producto;

	IF @ValorTotal IS NULL
		SET @ValorTotal = 0;

	RETURN @ValorTotal;
END 
GO 

/* --- PRUEBA DE LA FUNCIÓN --- */
SELECT * FROM Productos WHERE ID_Producto = 3;
GO
SELECT dbo.fn_StockValorizadoTotal(3) AS [Valor Inventario];
GO