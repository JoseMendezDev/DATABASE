IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'usuario_netbeans')
BEGIN
    CREATE LOGIN usuario_netbeans WITH PASSWORD = 'CambiarEstaContraseña';
END
GO

USE TestDB;
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'usuario_netbeans')
BEGIN
    CREATE USER usuario_netbeans FOR LOGIN usuario_netbeans;
    ALTER ROLE db_owner ADD MEMBER usuario_netbeans;
END
GO