USE LabT_SQL
GO

CREATE PROCEDURE sp_MoverStockCategoria
    @ID_CategoriaOrigen INT,
    @ID_CategoriaDestino INT
AS
BEGIN
    SET NOCOUNT ON;
        -- Validar que ambas categorías existan
    IF NOT EXISTS (SELECT 1 FROM Categorias WHERE ID_Categoria = @ID_CategoriaOrigen)
    BEGIN
        PRINT 'Error: La categoría de origen no existe.';
        RETURN;
    END;
        IF NOT EXISTS (SELECT 1 FROM Categorias WHERE ID_Categoria = @ID_CategoriaDestino)
    BEGIN
        PRINT 'Error: La categoría de destino no existe.';
        RETURN;
    END;
    -- Si ambas existen, reasigna los productos
    UPDATE Productos
    SET ID_Categoria = @ID_CategoriaDestino
    WHERE ID_Categoria = @ID_CategoriaOrigen;

    PRINT 'Los productos fueron reasignados correctamente de la categoría origen a la categoría destino.';
END;
GO

SELECT * FROM Productos
EXEC sp_MoverStockCategoria @ID_CategoriaOrigen = 2, @ID_CategoriaDestino = 3;
SELECT * FROM Productos
