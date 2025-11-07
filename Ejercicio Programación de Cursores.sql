USE LabT_SQL
GO

DECLARE @ID_Producto_Cursor INT;
DECLARE @Precio_Cursor DECIMAL (10,2);
DECLARE @Stock_Cursor INT;

PRINT 'Iniciando proceso de actualización con cursor...';

--2. Declarar el CURSOR (Define la consulta que alimentará el cursor)
DECLARE cursor_aumento_lacteos CURSOR FOR
	SELECT ID_Producto, Precio, Stock
	FROM Productos
	WHERE ID_Categoria = 1; -- ID 1 es 'Lácteos'

PRINT 'Iniciando proceso de actualización con cursor...';
--3. Abrir el CURSOR (Ejecuta la consulta y carga los resultados)
OPEN cursor_aumento_lacteos;

--4. Iniciar el recorrido (FETCH) - Primera fila
FETCH NEXT FROM cursor_aumento_lacteos INTO @ID_Producto_Cursor,
@Precio_Cursor, @Stock_Cursor;

--5. Bucle (WHILE) mientras haya filas
-- @@FETCH_STATUS = 0 significa que el FETCH fue exitoso
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Lógica de negocio (fila por fila)
	IF @Stock_Cursor < 50
	BEGIN
		-- Actualizamos la fila actual
		UPDATE Productos
		SET Precio = @Precio_Cursor * 1.10
		WHERE ID_Producto = @ID_Producto_Cursor; -- Actualización precisa

		PRINT 'Producto ID' + CONVERT(VARCHAR, @ID_Producto_Cursor) + 'actualizado (Stock < 50).';
	END

	-- Avanzamos a la siguiente fila
	FETCH NEXT FROM cursor_aumento_lacteos INTO @ID_Producto_Cursor, @Precio_Cursor, @Stock_Cursor;
END

-- 6. Cerrar el CURSOR(Libera el bloqueo de filas)
CLOSE cursor_aumento_lacteos;

-- 7. Desasignar el CURSOR (Libera la memoria)
DEALLOCATE cursor_aumento_lacteos;
GO

PRINT 'Proceso de cursor finalizado.';

-- Verificamos los cambios (El Queso y el Yogurt deben haber aumentado)
SELECT * FROM Productos WHERE ID_Categoria = 1;
GO

SELECT * FROM Productos