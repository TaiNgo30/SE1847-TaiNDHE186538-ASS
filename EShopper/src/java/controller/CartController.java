/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.BillDAO;
import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.Enumeration;
import java.util.Vector;
import model.BillDetail;
import model.CartItem;
import model.Order;
import model.Product;
import model.User;

/**
 *
 * @author ducta
 */
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String service = request.getParameter("service");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
        } else {

            if (service.equals("showCart")) {
                response.sendRedirect("Cart.jsp");
            }

            if (service.equals("addToCart")) {
                Integer productId = Integer.parseInt(request.getParameter("productId"));
                Product product = (new ProductDAO()).getProductsById(productId);
                if (session.getAttribute(productId.toString()) == null) {
                    CartItem cartItem = new CartItem(product, 1);
                    session.setAttribute(productId.toString(), cartItem);
                } else {
                    int newQuantity = ((CartItem) session.getAttribute(productId.toString())).getQuantity() + 1;
                    CartItem cartItem = new CartItem(product, newQuantity);
                    session.setAttribute(productId.toString(), cartItem);
                }

                response.sendRedirect("customer");
            }

            if (service.equals("removeItem")) {
                String id = request.getParameter("id");
                session.removeAttribute(id);
                response.sendRedirect("Cart.jsp");

            }

            if (service.equals("removeAll")) {
                Enumeration en = session.getAttributeNames();
                while (en.hasMoreElements()) {
                    String id = en.nextElement().toString();
                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        session.removeAttribute(id);
                    }
                }
                response.sendRedirect("Cart.jsp");

            }

            if (service.equals("update")) {
                Enumeration em = session.getAttributeNames();

                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key

                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        int quantity = Integer.parseInt(request.getParameter("p" + id));
                        CartItem cartItem = (CartItem) session.getAttribute(id);
                        cartItem.setQuantity(quantity);
                        session.setAttribute(id, cartItem);
                    }
                }
                response.sendRedirect("Cart.jsp");

            }

            if (service.equals("checkOut")) {
                java.util.Date date = new java.util.Date();
                Date currentDate = new Date(date.getTime());
                //insert order
                Order order = new Order(currentDate, user);
                int orderId = (new OrderDAO()).insert(order, user);
                //insert order detail
                Enumeration em = session.getAttributeNames();

                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key

                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        CartItem cartItem = (CartItem) session.getAttribute(id);
                        (new OrderDetailDAO()).insert((new OrderDAO()).getOrdersById(orderId), cartItem);
                    }
                }

                //insert bill
                int billId = (new BillDAO()).insert((new OrderDAO()).getOrdersById(orderId), user, "wait");

                //remove all products in cart
                Enumeration en = session.getAttributeNames();
                while (en.hasMoreElements()) {
                    String id = en.nextElement().toString();
                    if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                        session.removeAttribute(id);
                    }
                }

                request.setAttribute("checkOutDone", "checkOutDone");
                request.setAttribute("BillId", billId);
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            }

            if (service.equals("showBill")) {
                int billId = Integer.parseInt(request.getParameter("billId"));

                Vector<BillDetail> billDetails = (new BillDAO()).showBillDetail(billId);
                request.setAttribute("billDetails", billDetails);
                request.setAttribute("showBill", "showBill");
                request.getRequestDispatcher("Cart.jsp").forward(request, response);
            }
        }
    }

}
