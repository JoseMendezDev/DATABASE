USE ECOMMERCE_DB;
GO

-- Insertar categorías
INSERT INTO categorias (nombre, descripcion) VALUES(N'Electrónica', N'Productos electrónicos y tecnología');
INSERT INTO categorias (nombre, descripcion) VALUES(N'Ropa', N'Vestimenta y accesorios');
INSERT INTO categorias (nombre, descripcion) VALUES(N'Hogar', N'Artículos para el hogar');
INSERT INTO categorias (nombre, descripcion) VALUES(N'Deportes', N'Equipamiento deportivo');
INSERT INTO categorias (nombre, descripcion) VALUES(N'Libros', N'Libros y material educativo');
-- Subcategorías
INSERT INTO categorias (nombre, descripcion, categoria_padre_id) VALUES(N'Celulares', N'Smartphones y accesorios', 1);
INSERT INTO categorias (nombre, descripcion, categoria_padre_id) VALUES(N'Laptops', N'Computadoras portátiles', 1);
INSERT INTO categorias (nombre, descripcion, categoria_padre_id) VALUES(N'Hombre', N'Ropa para hombre', 2);
INSERT INTO categorias (nombre, descripcion, categoria_padre_id) VALUES(N'Mujer', N'Ropa para mujer', 2);
GO

-- Insertar productos
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'iPhone 15 Pro', N'Smartphone Apple última generación', 999.99, 6);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'Samsung Galaxy S24', N'Smartphone Android premium', 899.99, 6);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'MacBook Pro M3', N'Laptop profesional Apple', 1999.99, 7);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'Dell XPS 15', N'Laptop de alto rendimiento', 1499.99, 7);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'Camiseta Nike', N'Camiseta deportiva', 29.99, 8);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'Jeans Levis', N'Pantalón denim clásico', 79.99, 8);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'Vestido Casual', N'Vestido para mujer', 49.99, 9);
INSERT INTO productos (nombre, descripcion, precio, categoria_id) VALUES(N'Zapatillas Adidas', N'Calzado deportivo', 89.99, 4);
GO

-- Insertar inventario
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(1, 50, 10, 200);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(2, 30, 10, 150);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(3, 20, 5, 100);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(4, 25, 5, 100);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(5, 100, 20, 500);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(6, 75, 15, 300);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(7, 60, 15, 250);
INSERT INTO inventario (producto_id, stock_actual, stock_minimo, stock_maximo) VALUES(8, 80, 20, 400);
GO

-- Insertar administrador
INSERT INTO administradores (email, password, nombre, telefono, nivel) VALUES(N'admin@ecommerce.com', N'admin123', N'Administrador Sistema', N'999999999', N'SUPER');
GO

-- Insertar permisos para administrador
INSERT INTO permisos (administrador_id, permiso) VALUES(1, N'GESTIONAR_PRODUCTOS');
INSERT INTO permisos (administrador_id, permiso) VALUES(1, N'GESTIONAR_INVENTARIO');
INSERT INTO permisos (administrador_id, permiso) VALUES(1, N'VER_REPORTES');
INSERT INTO permisos (administrador_id, permiso) VALUES(1, N'GESTIONAR_USUARIOS');
GO

-- Insertar cliente de prueba
INSERT INTO clientes (email, password, nombre, telefono, direccion_envio) VALUES(N'juan@email.com', N'123456', N'Juan Pérez', N'987654321', N'Av. Principal 123, Lima');
GO

-- Insertar vehículos
INSERT INTO transportes (matricula, tipo, modelo, capacidad_kg, cilindrada) VALUES(N'ABC-123', N'MOTOCICLETA', N'Honda CB500', 50, 500);
INSERT INTO transportes (matricula, tipo, modelo, capacidad_kg, numero_puertas, tiene_maletero) VALUES(N'XYZ-789', N'AUTOMOVIL', N'Toyota Corolla', 200, 4, 1);
INSERT INTO transportes (matricula, tipo, modelo, capacidad_kg, capacidad_carga, tiene_refrigeracion) VALUES(N'DEF-456', N'CAMIONETA', N'Ford Ranger', 1000, 1500.00, 0);
GO

-- Insertar repartidor
INSERT INTO repartidores (email, password, nombre, telefono, licencia, vehiculo_id) VALUES(N'repartidor@ecommerce.com', N'rep123', N'Carlos Ramos', N'988776655', N'A-II-a', 1);
GO