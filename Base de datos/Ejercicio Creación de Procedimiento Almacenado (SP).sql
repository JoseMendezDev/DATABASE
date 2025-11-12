USE LabT_SQL
GO

CREATE PROCEDURE sp_ObtenerProductosPorCategoria
	--Parámetros de entrada
	@NombreCategoriaParcial VARCHAR(100)
AS
BEGIN
	--Evita que SQL Server envíe mensajes de 'filas afectadas'
	SET NOCOUNT ON;

	--La consulta principal del SP
	SELECT
		p.NombreProducto,
		p.Precio,
		p.Stock,
		c.NombreCategoria
	FROM
		Productos p
	INNER JOIN
		Categorias c ON p.ID_Categoria = c.ID_Categoria
	WHERE
		--Usamos LIKE para que sea una búsqueda parcial
		c.NombreCategoria LIKE '%' + @NombreCategoriaParcial + '%';
END
GO

-- PRUEBA DE PROCEDMIENTO
EXEC sp_ObtenerProductosPorCategoria @NombreCategoriaParcial = 'Lácteos';
GO
EXEC sp_ObtenerProductosPorCategoria @NombreCategoriaParcial = 'Beb'; --Prueba parcial
GO
