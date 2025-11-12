CREATE DATABASE ECOMMERCE_DB
GO

USE ECOMMERCE_DB;
GO

CREATE TABLE categorias (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(100) NOT NULL,
	descripcion TEXT,
	categoria_padre_id INT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	activo BOOLEAN DEFAULT TRUE,
	FOREIGN KEY (categoria_padre_id) REFERENCES categorias(id) ON DELETE SET NULL,
	INDEX idx_categoria_padre (categoria_padre_id),
	INDEX idx_activo (activo)
);
GO

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    imagen VARCHAR(255),
    categoria_id INT NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE RESTRICT,
    INDEX idx_categoria (categoria_id),
    INDEX idx_nombre (nombre),
    INDEX idx_activo (activo),
    INDEX idx_precio (precio),
    FULLTEXT INDEX ft_nombre_descripcion (nombre, descripcion)
);
GO

CREATE TABLE inventario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT NOT NULL UNIQUE,
    stock_actual INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INT NOT NULL DEFAULT 10,
    stock_maximo INT NOT NULL DEFAULT 1000,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    INDEX idx_producto (producto_id),
    INDEX idx_stock_bajo (stock_actual),
    CHECK (stock_minimo < stock_maximo)
);
GO

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    direccion_envio TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP NULL,
    activo BOOLEAN DEFAULT TRUE,
    INDEX idx_email (email),
    INDEX idx_activo (activo)
);
GO

CREATE TABLE administradores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    nivel ENUM('SUPER', 'MODERADOR', 'BASICO') DEFAULT 'BASICO',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    INDEX idx_email (email),
    INDEX idx_nivel (nivel)
);
GO

CREATE TABLE transportes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    tipo ENUM('MOTOCICLETA', 'AUTOMOVIL', 'CAMIONETA') NOT NULL,
    modelo VARCHAR(100),
    capacidad_kg INT NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    
    -- Campos específicos por tipo
    cilindrada INT NULL, -- Para motocicletas
    numero_puertas INT NULL, -- Para automóviles
    tiene_maletero BOOLEAN NULL, -- Para automóviles
    capacidad_carga DECIMAL(10, 2) NULL, -- Para camionetas
    tiene_refrigeracion BOOLEAN NULL, -- Para camionetas
    
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tipo (tipo),
    INDEX idx_disponible (disponible)
);
GO

CREATE TABLE repartidores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    licencia VARCHAR(50) NOT NULL,
    vehiculo_id INT NULL,
    en_servicio BOOLEAN DEFAULT FALSE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (vehiculo_id) REFERENCES transportes(id) ON DELETE SET NULL,
    INDEX idx_email (email),
    INDEX idx_en_servicio (en_servicio),
    INDEX idx_vehiculo (vehiculo_id)
);
GO

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    estado ENUM('PENDIENTE', 'CONFIRMADO', 'PROCESANDO', 'ENVIADO', 'ENTREGADO', 'CANCELADO') DEFAULT 'PENDIENTE',
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    direccion_envio TEXT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT,
    INDEX idx_cliente (cliente_id),
    INDEX idx_estado (estado),
    INDEX idx_fecha (fecha_pedido)
);
GO

CREATE TABLE detalle_pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal DECIMAL(10, 2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT,
    INDEX idx_pedido (pedido_id),
    INDEX idx_producto (producto_id)
);
GO

CREATE TABLE metodos_pago (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('TARJETA_CREDITO', 'PAYPAL', 'TRANSFERENCIA_BANCARIA') NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    
    -- Campos para Tarjeta de Crédito
    numero_tarjeta VARCHAR(16) NULL,
    titular VARCHAR(150) NULL,
    fecha_expiracion DATE NULL,
    
    -- Campos para PayPal
    email_cuenta VARCHAR(100) NULL,
    
    -- Campos para Transferencia Bancaria
    numero_cuenta VARCHAR(50) NULL,
    banco VARCHAR(100) NULL,
    
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_tipo (tipo)
);
GO

CREATE TABLE pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL UNIQUE,
    metodo_pago_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL CHECK (monto >= 0),
    estado ENUM('PENDIENTE', 'PROCESANDO', 'COMPLETADO', 'FALLIDO', 'REEMBOLSADO') DEFAULT 'PENDIENTE',
    numero_transaccion VARCHAR(100) UNIQUE,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id) ON DELETE RESTRICT,
    INDEX idx_pedido (pedido_id),
    INDEX idx_estado (estado),
    INDEX idx_fecha (fecha_pago)
);
GO

CREATE TABLE envios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL UNIQUE,
    repartidor_id INT NULL,
    estado ENUM('PREPARANDO', 'EN_TRANSITO', 'EN_REPARTO', 'ENTREGADO', 'DEVUELTO') DEFAULT 'PREPARANDO',
    costo_envio DECIMAL(10, 2) NOT NULL DEFAULT 0,
    codigo_seguimiento VARCHAR(50) UNIQUE NOT NULL,
    fecha_envio TIMESTAMP NULL,
    fecha_entrega TIMESTAMP NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (repartidor_id) REFERENCES repartidores(id) ON DELETE SET NULL,
    INDEX idx_pedido (pedido_id),
    INDEX idx_repartidor (repartidor_id),
    INDEX idx_estado (estado),
    INDEX idx_codigo (codigo_seguimiento)
);
GO

CREATE TABLE carritos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
    INDEX idx_cliente (cliente_id),
    INDEX idx_activo (activo)
);
GO

CREATE TABLE items_carrito (
    id INT PRIMARY KEY AUTO_INCREMENT,
    carrito_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    fecha_agregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (carrito_id) REFERENCES carritos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE,
    INDEX idx_carrito (carrito_id),
    INDEX idx_producto (producto_id),
    UNIQUE KEY uk_carrito_producto (carrito_id, producto_id)
);
GO

CREATE TABLE permisos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    administrador_id INT NOT NULL,
    permiso VARCHAR(50) NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (administrador_id) REFERENCES administradores(id) ON DELETE CASCADE,
    INDEX idx_admin (administrador_id),
    UNIQUE KEY uk_admin_permiso (administrador_id, permiso)
);
GO