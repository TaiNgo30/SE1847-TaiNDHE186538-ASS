/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.User;

/**
 *
 * @author ducta
 */
public class OrderDAO extends DBContext {

    public int insert(Order order, User user) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int generatedId = -1; // Giá trị mặc định nếu không có id được tạo

        String sql = "INSERT INTO [dbo].[order]\n"
                + "           ([created_date]\n"
                + "           ,[user_id])\n"
                + "     VALUES\n"
                + "           (?, ?)";
        try {
            stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setDate(1, order.getCreated_date());
            stm.setInt(2, user.getId());
            stm.executeUpdate();

            // Lấy kết quả id được tạo ra
            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }

            System.out.println("Insert OK");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return generatedId;
    }

    public Order getOrdersById(int orderId) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Order order = null;
        User user;
        String sql = "select * from [order] where id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, orderId);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id"), user_id = rs.getInt("user_id");
                user = (new UserDAO()).getUserById(user_id);
                java.sql.Date created_date = rs.getDate("created_date");
                
                order = new Order(id, created_date, user);
            }
            return order;

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                rs.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(OrderDAO.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
