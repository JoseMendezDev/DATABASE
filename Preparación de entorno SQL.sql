CREATE DATABASE ECOMMERCE_DB
GO

USE ECOMMERCE_DB;
GO

CREATE TABLE categorias (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(25) NOT NULL,
    descripcion VARCHAR(75),
    categoria_padre_id INT NULL,
    fecha_creacion DATETIME2 DEFAULT GETDATE(),
    activo BIT DEFAULT 1,
    FOREIGN KEY (categoria_padre_id) REFERENCES categorias(id) ON DELETE NO ACTION
);
GO

CREATE TABLE productos (
    id INT PRIMARY KEY IDENTITY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(50),
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    categoria_id INT NOT NULL,
    activo BIT DEFAULT 1,
    fecha_creacion DATETIME2 DEFAULT GETDATE(),
    fecha_actualizacion DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE NO ACTION
);
GO

CREATE TRIGGER trg_productos_fecha_actualizacion
ON productos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE productos
    SET fecha_actualizacion = GETDATE()
    WHERE id IN (SELECT id FROM inserted);
END
GO

CREATE TABLE inventario (
    id INT PRIMARY KEY IDENTITY,
    producto_id INT NOT NULL UNIQUE,
    stock_actual INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INT NOT NULL DEFAULT 10,
    stock_maximo INT NOT NULL DEFAULT 1000,
    ultima_actualizacion DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
);
GO

CREATE TABLE clientes (
    id INT PRIMARY KEY IDENTITY,
    email VARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(20) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    telefono VARCHAR(9),
    direccion_envio VARCHAR(100),
    fecha_registro DATETIME2 DEFAULT GETDATE(),
    ultimo_acceso DATETIME2 NULL,
    activo BIT DEFAULT 1
);
GO

CREATE TABLE administradores (
    id INT PRIMARY KEY IDENTITY,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    telefono VARCHAR(9),
    fecha_registro DATETIME2 DEFAULT GETDATE(),
    activo BIT DEFAULT 1
);
GO

CREATE TABLE transportes (
    id INT PRIMARY KEY IDENTITY,
    matricula VARCHAR(7) NOT NULL UNIQUE,
    tipo VARCHAR(15) NOT NULL CHECK (tipo IN ('MOTOCICLETA', 'AUTOMOVIL', 'CAMIONETA')),
    modelo VARCHAR(50),
    capacidad_kg INT NOT NULL,
    disponible BIT DEFAULT 1,
    cilindrada INT NULL,
    numero_puertas INT NULL,
    tiene_maletero BIT NULL,
    capacidad_carga DECIMAL(10, 2) NULL,
    tiene_refrigeracion BIT NULL,
    fecha_registro DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE repartidores (
    id INT PRIMARY KEY IDENTITY,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    telefono VARCHAR(9),
    licencia VARCHAR(15) NOT NULL,
    vehiculo_id INT NULL,
    en_servicio BIT DEFAULT 0,
    fecha_registro DATETIME2 DEFAULT GETDATE(),
    activo BIT DEFAULT 1,
    FOREIGN KEY (vehiculo_id) REFERENCES transportes(id) ON DELETE SET NULL
);
GO

CREATE TABLE pedidos (
    id INT PRIMARY KEY IDENTITY,
    cliente_id INT NOT NULL,
    direccion_envio VARCHAR(100) NOT NULL,
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    estado VARCHAR(10) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'CONFIRMADO', 'PROCESANDO', 'ENVIADO', 'ENTREGADO', 'CANCELADO')),
    fecha_pedido DATETIME2 DEFAULT GETDATE(),
    fecha_actualizacion DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE NO ACTION
);
GO

CREATE TABLE detalle_pedidos (
    id INT PRIMARY KEY IDENTITY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE NO ACTION,
    UNIQUE (pedido_id, producto_id)
);
GO

CREATE TABLE metodos_pago (
    id INT PRIMARY KEY IDENTITY,
    tipo VARCHAR(22) NOT NULL CHECK (tipo IN ('TARJETA_CREDITO', 'TRANSFERENCIA_BANCARIA')),
    activo BIT DEFAULT 1,
    numero_tarjeta VARCHAR(16) NULL,
    titular VARCHAR(20) NULL,
    fecha_expiracion DATE NULL,
    numero_cuenta VARCHAR(20) NULL,
    banco VARCHAR(100) NULL,
    fecha_registro DATETIME2 DEFAULT GETDATE()
);
GO

CREATE TABLE pagos (
    id INT PRIMARY KEY IDENTITY,
    pedido_id INT NOT NULL UNIQUE,
    metodo_pago_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL CHECK (monto >= 0),
    estado VARCHAR(12) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'PROCESANDO', 'COMPLETADO', 'FALLIDO', 'REEMBOLSADO')),
    numero_transaccion NVARCHAR(50) UNIQUE,
    fecha_pago DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id) ON DELETE NO ACTION
);
GO

CREATE TABLE envios (
    id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT NOT NULL UNIQUE,
    repartidor_id INT NULL,
    estado VARCHAR(15) DEFAULT 'PREPARANDO' CHECK (estado IN ('PREPARANDO', 'EN_TRANSITO', 'EN_REPARTO', 'ENTREGADO', 'DEVUELTO')),
    costo_envio DECIMAL(10, 2) NOT NULL DEFAULT 0,
    codigo_seguimiento VARCHAR(20) UNIQUE NOT NULL,
    fecha_envio DATETIME2 NULL,
    fecha_entrega DATETIME2 NULL,
    fecha_creacion DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (repartidor_id) REFERENCES repartidores(id) ON DELETE SET NULL
);
GO

CREATE TABLE carritos (
    id INT PRIMARY KEY IDENTITY,
    cliente_id INT NOT NULL UNIQUE,
    fecha_creacion DATETIME2 DEFAULT GETDATE(),
    fecha_actualizacion DATETIME2 DEFAULT GETDATE(),
    activo BIT DEFAULT 1,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);
GO

CREATE TABLE items_carrito (
    id INT PRIMARY KEY IDENTITY,
    carrito_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    fecha_agregado DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (carrito_id) REFERENCES carritos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    UNIQUE (carrito_id, producto_id)
);
GO

CREATE TABLE permisos (
    id INT PRIMARY KEY IDENTITY,
    administrador_id INT NOT NULL,
    permiso VARCHAR(50) NOT NULL,
    fecha_asignacion DATETIME2 DEFAULT GETDATE(),
    FOREIGN KEY (administrador_id) REFERENCES administradores(id) ON DELETE CASCADE,
    UNIQUE (administrador_id, permiso)
);
GO