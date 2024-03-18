/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

/**
 *
 * @author ducta
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        UserDAO userDao = new UserDAO();
        User user = userDao.getOne(username, password);
        session.setAttribute("user", user);

        if (session.getAttribute("user") == null) {
            request.setAttribute("invalidUser", "Username or Password is invalid");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        } else if (user.getBanned() == 1) {
            response.sendRedirect("AccessDenied.jsp");
            session.removeAttribute("user");
        } else if (((User) session.getAttribute("user")).getRole_id() == 0) {
            session.setAttribute("fullname", ((User) session.getAttribute("user")).getFullname());
            request.getRequestDispatcher("admin").forward(request, response);
        } else if (((User) session.getAttribute("user")).getRole_id() == 1) {
            session.setAttribute("fullname", ((User) session.getAttribute("user")).getFullname());
            response.sendRedirect("customer");
        }
    }

}
