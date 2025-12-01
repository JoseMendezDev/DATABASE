USE ECOMMERCE_DB;
GO

-- Trigger para actualizar fecha de último acceso del cliente
CREATE TRIGGER trg_cliente_ultimo_acceso
ON clientes
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET ultimo_acceso = GETDATE()
    FROM clientes c
    INNER JOIN inserted i ON c.id = i.id
    INNER JOIN deleted d ON c.id = d.id 
    -- El cambio es de inactivo (0) a activo (1)
    WHERE i.activo = 1 AND d.activo = 0;
END
GO

-- Trigger para calcular subtotal en detalle_pedidos (INSTEAD OF para calcular el valor)
CREATE TRIGGER trg_calcular_subtotal_detalle
ON detalle_pedidos
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario, subtotal)
    SELECT 
        i.pedido_id, 
        i.producto_id, 
        i.cantidad, 
        i.precio_unitario, 
        i.cantidad * i.precio_unitario 
    FROM inserted i;
END
GO

-- Trigger para validar stock antes de agregar al carrito
CREATE TRIGGER trg_validar_stock_carrito
ON items_carrito
INSTEAD OF INSERT 
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN inventario inv ON i.producto_id = inv.producto_id
        WHERE i.cantidad > inv.stock_actual
    )
    BEGIN
        THROW 50001, N'Stock insuficiente para agregar uno o más productos al carrito.', 1;
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO items_carrito (carrito_id, producto_id, cantidad, precio_unitario)
        SELECT carrito_id, producto_id, cantidad, precio_unitario
        FROM inserted;
    END
END
GO