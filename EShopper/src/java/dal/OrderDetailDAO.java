/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;
import model.Order;

/**
 *
 * @author ducta
 */
public class OrderDetailDAO extends DBContext {

    public void insert(Order order, CartItem cartItem) {
        PreparedStatement stm = null;

        String sql = "INSERT INTO [dbo].[order_detail]\n"
                + "           ([product_quantity]\n"
                + "           ,[product_id]\n"
                + "           ,[order_id]\n"
                + "           ,[price])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, cartItem.getQuantity());
            stm.setInt(2, cartItem.getProduct().getId());
            stm.setInt(3, order.getId());
            stm.setDouble(4, cartItem.getProduct().getPrice());
            stm.executeUpdate();

            System.out.println("Insert OK");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(OrderDetailDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
