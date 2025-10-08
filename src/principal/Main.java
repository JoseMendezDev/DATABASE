/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package principal;

import conexion.ConexionDB;
import dao.UsuarioDAO;
import modelo.Usuario;
import java.util.List;
/**
 *
 * @author USER
 */

public class Main {
    
    public static void main(String[] args) {
        System.out.println("=== PRUEBA DE CONEXIÓN A SQL SERVER ===\n");
        
        // 1. Probar la conexión
        System.out.println("1. Probando conexión a la base de datos...");
        if (ConexionDB.probarConexion()) {
            System.out.println("✓ Conexión exitosa!\n");
        } else {
            System.out.println("✗ Error en la conexión\n");
            return;
        }
        
        // 2. Crear instancia del DAO
        UsuarioDAO dao = new UsuarioDAO();
        
        // 3. Obtener y mostrar todos los usuarios
        System.out.println("2. Obteniendo todos los usuarios...");
        List<Usuario> usuarios = dao.obtenerTodosLosUsuarios();
        
        if (usuarios.isEmpty()) {
            System.out.println("No hay usuarios en la base de datos\n");
        } else {
            System.out.println("\n--- LISTA DE USUARIOS ---");
            for (Usuario u : usuarios) {
                System.out.println(u);
            }
            System.out.println();
        }
        
        // 4. Obtener un usuario específico por ID
        System.out.println("3. Obteniendo usuario con ID = 1...");
        Usuario usuario = dao.obtenerUsuarioPorID(1);
        if (usuario != null) {
            System.out.println("Usuario encontrado: " + usuario);
        } else {
            System.out.println("Usuario no encontrado");
        }
        System.out.println();
        
        // 5. Insertar un nuevo usuario
        System.out.println("4. Insertando nuevo usuario...");
        int nuevoID = dao.insertarUsuario("Carlos López", "carlos@email.com");
        if (nuevoID > 0) {
            System.out.println("✓ Usuario insertado exitosamente con ID: " + nuevoID);
        } else {
            System.out.println("✗ Error al insertar usuario");
        }
        System.out.println();
        
        // 6. Verificar la inserción obteniendo todos los usuarios nuevamente
        System.out.println("5. Verificando inserción - Lista actualizada de usuarios:");
        usuarios = dao.obtenerTodosLosUsuarios();
        System.out.println("\n--- LISTA ACTUALIZADA DE USUARIOS ---");
        for (Usuario u : usuarios) {
            System.out.println(u);
        }
        
        System.out.println("\n=== PRUEBA FINALIZADA ===");
    }
}
