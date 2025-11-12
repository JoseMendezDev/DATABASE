USE TestDB;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Usuarios')
BEGIN
    CREATE TABLE Usuarios (
        ID INT PRIMARY KEY IDENTITY(1,1),
        Nombre NVARCHAR(100),
        Email NVARCHAR(100),
        FechaRegistro DATETIME DEFAULT GETDATE()
    );
END
GO

IF NOT EXISTS (SELECT * FROM Usuarios)
BEGIN
    INSERT INTO Usuarios (Nombre, Email) 
    VALUES 
        ('Juan Pérez', 'juan@email.com'),
        ('María García', 'maria@email.com');
END
GO