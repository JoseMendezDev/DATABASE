USE TestDB;
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerUsuarios')
    DROP PROCEDURE sp_ObtenerUsuarios;
GO

CREATE PROCEDURE sp_ObtenerUsuarios
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID, Nombre, Email, FechaRegistro
    FROM Usuarios
    ORDER BY ID;
END
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_ObtenerUsuarioPorID')
    DROP PROCEDURE sp_ObtenerUsuarioPorID;
GO

CREATE PROCEDURE sp_ObtenerUsuarioPorID
    @ID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ID, Nombre, Email, FechaRegistro
    FROM Usuarios
    WHERE ID = @ID;
END
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'sp_InsertarUsuario')
    DROP PROCEDURE sp_InsertarUsuario;
GO

CREATE PROCEDURE sp_InsertarUsuario
    @Nombre NVARCHAR(100),
    @Email NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Usuarios (Nombre, Email)
    VALUES (@Nombre, @Email);
    
    SELECT SCOPE_IDENTITY() AS NuevoID;
END
GO