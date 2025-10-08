/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author USER
 */

public class ConexionDB {
    
    // Parámetros de conexión
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=TestDB;encrypt=true;trustServerCertificate=true;";
    private static final String USUARIO = "usuario_netbeans";
    private static final String PASSWORD = "prueba";
    
    // Método para obtener la conexión
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Cargar el driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            
            // Establecer la conexión
            conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            System.out.println("Conexión exitosa a la base de datos!");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se encontró el driver JDBC de SQL Server");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error al conectar con la base de datos");
            e.printStackTrace();
        }
        return conn;
    }
    
    // Método para cerrar la conexión
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Conexión cerrada correctamente");
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexión");
                e.printStackTrace();
            }
        }
    }
    
    // Método para probar la conexión
    public static boolean probarConexion() {
        Connection conn = getConnection();
        if (conn != null) {
            closeConnection(conn);
            return true;
        }
        return false;
    }
}
