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
import java.util.Stack;
import java.util.Vector;
import model.User;

/**
 *
 * @author ducta
 */
public class ManageCustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Vector<User> customers = (new UserDAO()).getAllCustomer();
        String service = request.getParameter("service");

        if (service == null) {
            service = "listAllCustomers";
        }

        if (service.equals("listAllCustomers")) {
            request.setAttribute("manageCustomer", "Yes");
            request.setAttribute("allCustomers", customers);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("ban")) {
            int id = Integer.parseInt(request.getParameter("id"));
            (new UserDAO()).banAnUser(id);

            customers = (new UserDAO()).getAllCustomer();
            request.setAttribute("manageCustomer", "Yes");
            request.setAttribute("allCustomers", customers);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("searchByKeywords")) {
            String keywords = request.getParameter("keywords");

            request.setAttribute("keywords", keywords);
            request.setAttribute("manageCustomer", "Yes");

            customers = (new UserDAO()).getCustomerByName(keywords);

            if (customers == null || customers.isEmpty()) {
                request.setAttribute("notFoundCustomer", "Your keywords do not match with any Customer Name");
                customers = (new UserDAO()).getAllCustomer();
            }

            request.setAttribute("allCustomers", customers);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }
    }

}
