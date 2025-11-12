USE LabT_SQL
GO

CREATE PROCEDURE sp_GenerarReporteInventario
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE 
        @ID INT,
        @NombreProducto NVARCHAR(100),
        @Precio DECIMAL(18,2),
        @Stock INT,
        @Valor DECIMAL(18,2);

    DECLARE cur_Productos CURSOR FOR
        SELECT ID_Producto, NombreProducto, Precio, Stock
        FROM Productos;
    OPEN cur_Productos;
    FETCH NEXT FROM cur_Productos INTO @ID, @NombreProducto, @Precio, @Stock;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Valor = @Precio * @Stock;
        PRINT 'ID: ' + CAST(@ID AS NVARCHAR(10)) +
              ' - Producto: ' + @NombreProducto +
              ' - Stock: ' + CAST(@Stock AS NVARCHAR(10)) +
              ' - Valor: ' + CAST(@Valor AS NVARCHAR(20));

        FETCH NEXT FROM cur_Productos INTO @ID, @NombreProducto, @Precio, @Stock;
    END;
    CLOSE cur_Productos;
    DEALLOCATE cur_Productos;
END;
GO

EXEC sp_GenerarReporteInventario;