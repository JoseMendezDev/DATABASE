/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

/**
 *
 * @author USER
 */
public class ConfigDB {
    private static final String CONFIG_FILE = "config.properties";
    private static Properties properties = new Properties();
    
    static {
        cargarConfiguracion();
    }
    
    private static void cargarConfiguracion() {
        try (InputStream input = new FileInputStream(CONFIG_FILE)) {
            properties.load(input);
            System.out.println("Configuración cargada desde " + CONFIG_FILE);
        } catch (IOException e) {
            System.out.println("No se encontró config.properties, usando valores por defecto");
            crearConfiguracionPorDefecto();
        }
    }
    
    private static void crearConfiguracionPorDefecto() {
        properties.setProperty("db.url", "jdbc:sqlserver://localhost:1433;databaseName=MiBaseDatos;encrypt=true;trustServerCertificate=true;");
        properties.setProperty("db.usuario", "usuario_netbeans");
        properties.setProperty("db.password", "");
        
        System.out.println("⚠️ IMPORTANTE: Configura tus credenciales en config.properties");
    }
    
    public static void guardarConfiguracion(String url, String usuario, String password) {
        try (OutputStream output = new FileOutputStream(CONFIG_FILE)) {
            properties.setProperty("db.url", url);
            properties.setProperty("db.usuario", usuario);
            properties.setProperty("db.password", password);
            
            properties.store(output, "Configuración de Base de Datos - NO SUBIR A GITHUB");
            System.out.println("✓ Configuración guardada exitosamente");
        } catch (IOException e) {
            System.err.println("Error al guardar configuración");
            e.printStackTrace();
        }
    }
    
    public static String getUrl() {
        return properties.getProperty("db.url");
    }
    
    public static String getUsuario() {
        return properties.getProperty("db.usuario");
    }
    
    public static String getPassword() {
        return properties.getProperty("db.password");
    }

}
