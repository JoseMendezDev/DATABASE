USE LabT_SQL
GO

CREATE FUNCTION fn_CalcularPrecioVenta (
	@PrecioBase  DECIMAL(10,2)
)
RETURNS DECIMAL(10,2) --El tipo de dato de la función devolverá
AS
BEGIN
	--Declaramos la variable de retorno
	DECLARE @PrecioFinal DECIMAL(10,2);

	--La lógica de negocio
	SET @PrecioFinal = @PrecioBase * 1.18;

	--Retornamos el valor calculado
	RETURN @PrecioFinal;
END
GO

-- PRUEBA DE LA FUNCIÓN
--Ahora podemos usar la función como si fuera una columna más
SELECT
	NombreProducto,
	Precio AS PrecioBase,
	--Importante: Usar 'dbo.' (schema) para llamar la función
	dbo.fn_CalcularPrecioVenta(Precio) AS [Precio Venta con IGV]
FROM
	Productos;
GO