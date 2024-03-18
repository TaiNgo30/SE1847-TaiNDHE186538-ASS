/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Brand;

/**
 *
 * @author ducta
 */
public class BrandDAO extends DBContext {

    public Vector<Brand> getAll() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<Brand> brands = new Vector<>();
        String sql = "select * from [brand]";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");

                brands.add(new Brand(id, name));
            }
            return brands;

        } catch (SQLException ex) {
            Logger.getLogger(BrandDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                rs.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(BrandDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public Brand getBrandById(int id) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Brand brand = null;
        String sql = "select * from [brand] where id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                brand.setId(rs.getInt("id"));
                brand.setName(rs.getString("name"));
            }
            return brand;

        } catch (SQLException ex) {
            Logger.getLogger(BrandDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                rs.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(BrandDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
