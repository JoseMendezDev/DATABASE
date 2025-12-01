USE ECOMMERCE_DB;
GO

-- Procedimiento para registrar un nuevo cliente
CREATE PROCEDURE sp_insertar_cliente
    @email NVARCHAR(100),
    @password NVARCHAR(255),
    @nombre NVARCHAR(150),
    @telefono NVARCHAR(20),
    @direccion_envio NVARCHAR(max)
AS
BEGIN 
    INSERT INTO clientes (email, password, nombre, telefono, direccion_envio)
    VALUES (@email, @password, @nombre, @telefono, @direccion_envio)
END
GO

-- Procedimiento para comprobar si existe email registrado
CREATE PROCEDURE sp_existe_email
    @email NVARCHAR(100)
AS
BEGIN
    SELECT COUNT(*) FROM clientes WHERE email = @email;
END
GO

-- Procedimiento para iniciar sesión
CREATE PROCEDURE sp_autenticar
    @email NVARCHAR(100),
    @password NVARCHAR(255)
AS
BEGIN
    SELECT * FROM clientes WHERE email = @email AND password = @password;
END
GO

SELECT * from clientes

-- Procedimiento para buscar todos los productos
CREATE PROCEDURE sp_productos
AS
BEGIN
    SELECT p.*, i.stock_actual
        FROM productos p
            INNER JOIN inventario i ON p.id = i.producto_id
        WHERE p.activo = 1
END
GO

-- Procedimiento para buscar producto por nombre
CREATE PROCEDURE sp_buscar_producto_por_nombre
    @nombre_producto NVARCHAR(200)
AS
BEGIN
    SELECT * FROM productos
        WHERE nombre LIKE '%'+@nombre_producto+'%' AND activo = 1;
END
GO

-- Procedimiento para buscar producto por id
ALTER PROCEDURE sp_buscar_producto_por_id
    @id_producto INT
    AS
BEGIN
    SELECT p.*, c.nombre AS categoria_nombre, c.descripcion AS categoria_desc, i.stock_actual
        FROM productos p
            INNER JOIN categorias c ON p.categoria_id = c.id
            INNER JOIN inventario i ON p.id = i.producto_id
        WHERE p.id = @id_producto
END
GO

-- Procedimiento para insertar pedido
CREATE PROCEDURE sp_insertar_pedido
    @cliente_id INT,
    @direccion_envio NVARCHAR(MAX),
    @total DECIMAL(10,2),
    @estado NVARCHAR(50)
AS
BEGIN
    INSERT INTO pedidos(cliente_id, direccion_envio, total, estado)
        VALUES  (@cliente_id, @direccion_envio, @total, @estado);
END
GO

SELECT p.*,i.* FROM productos p INNER JOIN inventario i ON p.id = i.producto_id;

SELECT * FROM productos

id nombre, precio, stock