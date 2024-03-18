/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BillDetail;
import model.BillDetailForAdmin;
import model.Order;
import model.User;

/**
 *
 * @author ducta
 */
public class BillDAO extends DBContext {

    public int insert(Order order, User user, String status) {
        PreparedStatement stm = null;
        ResultSet generatedKeys = null;
        int insertedId = -1; // Giá trị mặc định nếu không có ID được chèn

        String sql = "INSERT INTO [dbo].[bill]\n"
                + "           ([created_date]\n"
                + "           ,[status]\n"
                + "           ,[order_id]\n"
                + "           ,[user_id])\n"
                + "     VALUES\n"
                + "           (?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setDate(1, order.getCreated_date());
            stm.setString(2, status);
            stm.setInt(3, order.getId());
            stm.setInt(4, user.getId());
            int affectedRows = stm.executeUpdate();

            if (affectedRows > 0) {
                generatedKeys = stm.getGeneratedKeys();
                if (generatedKeys.next()) {
                    insertedId = generatedKeys.getInt(1); // Lấy giá trị ID của bản ghi vừa chèn
                }
            }

            System.out.println("Insert OK");
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (generatedKeys != null) {
                    generatedKeys.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return insertedId;
    }

    public void updateStatus(String status, int billId) {
        PreparedStatement stm = null;

        String sql = "UPDATE [dbo].[bill]\n"
                + "   SET [status] = ?\n"
                + " WHERE id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, billId);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public Vector<BillDetail> showBillDetail(int billId) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetail> billDetails = new Vector<>();

        String sql = "select b.id, u.fullname as [CustomerName], b.created_date as [CreatedDate], p.[name] as [ProductName],\n"
                + "image_url, product_quantity as [Quantity], p.price, (p.price * product_quantity) as SubTotal from [bill] b\n"
                + "join [user] u on u.id = b.[user_id]\n"
                + "join [order_detail] od on od.order_id = b.order_id\n"
                + "join [product] p on p.id = od.product_id\n"
                + "where b.id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, billId);

            rs = stm.executeQuery();

            while (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setId(rs.getInt("id"));
                billDetail.setCustomerName(rs.getString("CustomerName"));
                billDetail.setCreated_date(rs.getDate("CreatedDate"));
                billDetail.setProductName(rs.getString("ProductName"));
                billDetail.setImage_url(rs.getString("image_url"));
                billDetail.setProductQuantity(rs.getInt("Quantity"));
                billDetail.setPrice(rs.getDouble("price"));
                billDetail.setSubTotal(rs.getDouble("SubTotal"));

                billDetails.add(billDetail);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return billDetails;
    }

    public Vector<BillDetailForAdmin> showBillDetailForAdmin() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetailForAdmin> billDetailForAdmins = new Vector<>();

        String sql = "select b.id, u.fullname as [Customer Name], b.created_date,\n"
                + "u.address, u.email, u.phone,\n"
                + "SUM(price * product_quantity) as [Total], b.[status] from [bill] b\n"
                + "join [order_detail] od on od.order_id = b.order_id\n"
                + "join [user] u on u.id = b.[user_id]\n"
                + "group by b.id, u.fullname , b.created_date, b.[status], u.address, u.email, u.phone";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                BillDetailForAdmin bdfa = new BillDetailForAdmin();
                bdfa.setId(rs.getInt("id"));
                bdfa.setCustomerName(rs.getString("Customer Name"));
                bdfa.setCreated_date(rs.getDate("created_date"));
                bdfa.setAddress(rs.getString("address"));
                bdfa.setEmail(rs.getString("email"));
                bdfa.setPhone(rs.getString("phone"));
                bdfa.setTotal(rs.getDouble("Total"));
                bdfa.setStatus(rs.getString("status"));

                billDetailForAdmins.add(bdfa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return billDetailForAdmins;
    }

    public Vector<BillDetailForAdmin> showBillDetailForAdminFilterByStatus(String status) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<BillDetailForAdmin> billDetailForAdmins = new Vector<>();

        String sql = "select b.id, u.fullname as [Customer Name], b.created_date,\n"
                + "u.address, u.email, u.phone,\n"
                + "SUM(price * product_quantity) as [Total], b.[status] from [bill] b\n"
                + "join [order_detail] od on od.order_id = b.order_id\n"
                + "join [user] u on u.id = b.[user_id]\n"
                + "where b.status = ?\n"
                + "group by b.id, u.fullname , b.created_date, b.[status], u.address, u.email, u.phone";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            rs = stm.executeQuery();

            while (rs.next()) {
                BillDetailForAdmin bdfa = new BillDetailForAdmin();
                bdfa.setId(rs.getInt("id"));
                bdfa.setCustomerName(rs.getString("Customer Name"));
                bdfa.setCreated_date(rs.getDate("created_date"));
                bdfa.setAddress(rs.getString("address"));
                bdfa.setEmail(rs.getString("email"));
                bdfa.setPhone(rs.getString("phone"));
                bdfa.setTotal(rs.getDouble("Total"));
                bdfa.setStatus(rs.getString("status"));

                billDetailForAdmins.add(bdfa);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return billDetailForAdmins;
    }

}
