/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import conexion.ConexionDB;
import modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author USER
 */

public class UsuarioDAO {
    
    // Método para obtener todos los usuarios usando el procedimiento almacenado
    public List<Usuario> obtenerTodosLosUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionDB.getConnection();
            
            // Llamar al procedimiento almacenado
            stmt = conn.prepareCall("{CALL sp_ObtenerUsuarios}");
            rs = stmt.executeQuery();
            
            // Procesar los resultados
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("ID"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setEmail(rs.getString("Email"));
                
                // Convertir Timestamp a LocalDateTime
                Timestamp timestamp = rs.getTimestamp("FechaRegistro");
                if (timestamp != null) {
                    usuario.setFechaRegistro(timestamp.toLocalDateTime());
                }
                
                usuarios.add(usuario);
            }
            
            System.out.println("Se obtuvieron " + usuarios.size() + " usuarios");
            
        } catch (SQLException e) {
            System.err.println("Error al obtener usuarios");
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return usuarios;
    }
    
    // Método para obtener un usuario por ID
    public Usuario obtenerUsuarioPorID(int id) {
        Usuario usuario = null;
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionDB.getConnection();
            
            // Llamar al procedimiento almacenado con parámetro
            stmt = conn.prepareCall("{CALL sp_ObtenerUsuarioPorID(?)}");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("ID"));
                usuario.setNombre(rs.getString("Nombre"));
                usuario.setEmail(rs.getString("Email"));
                
                Timestamp timestamp = rs.getTimestamp("FechaRegistro");
                if (timestamp != null) {
                    usuario.setFechaRegistro(timestamp.toLocalDateTime());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error al obtener usuario por ID");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return usuario;
    }
    
    // Método para insertar un nuevo usuario
    public int insertarUsuario(String nombre, String email) {
        int nuevoID = -1;
        Connection conn = null;
        CallableStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConexionDB.getConnection();
            
            // Llamar al procedimiento almacenado
            stmt = conn.prepareCall("{CALL sp_InsertarUsuario(?, ?)}");
            stmt.setString(1, nombre);
            stmt.setString(2, email);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                nuevoID = rs.getInt("NuevoID");
                System.out.println("Usuario insertado con ID: " + nuevoID);
            }
            
        } catch (SQLException e) {
            System.err.println("Error al insertar usuario");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) ConexionDB.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return nuevoID;
    }
    
    public void EliminarUsuario() {

    }
    
    public void VerUsuario(){
        
    }
}
