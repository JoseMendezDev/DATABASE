-- EJERCICIO PROPUESTO 1 (FUNCIÓN)
§ Cree una función escalar llamada fn_StockValorizadoTotal que reciba un @ID_Producto
como parámetro.
§ La función debe devolver el valor total de inventario para ese producto (Precio * Stock).
§ Si el producto no existe, la función debe devolver 0

CREATE FUNCTION fn_StockValorizadoTotal (
	@ID_Producto INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN 
	DECLARE @valorTotal DECIMAL(10,2);
	SET @valorTotal = precio * cantidad
