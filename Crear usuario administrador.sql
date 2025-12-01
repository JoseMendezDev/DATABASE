-- LOGIN A NIVEL DE SERVIDOR

IF NOT EXISTS(SELECT * FROM sys.server_principals WHERE name = 'administrador')
	CREATE LOGIN administrador WITH PASSWORD = 'ecommerce';
GO

-- USAR BASE DE DATOS
IF  EXISTS(SELECT * FROM sys.databases WHERE name = 'ECOMMERCE_DB')
BEGIN
	USE ECOMMERCE_DB;
END
GO

-- USUARIO EN LA BASE DE DATOS
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'administrador')
	CREATE USER administrador FOR LOGIN administrador;
GO

-- PERMISOS
ALTER ROLE db_owner ADD MEMBER administrador;
GO
ALTER ROLE db_datareader ADD MEMBER administrador;
GO
ALTER ROLE db_datawriter ADD MEMBER administrador;
GO