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
import java.io.IOException;
import java.util.Vector;
import model.User;

/**
 *
 * @author ducta
 */
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        Vector<User> users = (new UserDAO()).getAll();
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                request.setAttribute("duplicateUsername", "Username already exists");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
        }

        UserDAO userDao = new UserDAO();
        User user = new User(username, password, fullname, email, phone, address, 1);
        userDao.insert(user);
        request.setAttribute("registerSuccess", "Register successful");
        request.getRequestDispatcher("Register.jsp").forward(request, response);
    }
}
