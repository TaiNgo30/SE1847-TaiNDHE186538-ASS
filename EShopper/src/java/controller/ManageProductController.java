/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.BrandDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.Vector;
import model.Brand;
import model.Product;

/**
 *
 * @author ducta
 */
public class ManageProductController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String service = request.getParameter("service");
        request.setAttribute("manageProduct", "Yes");
        if (service == null) {
            service = "listAll";
        }

        if (service.equals("listAll")) {
            Vector<Product> products = (new ProductDAO()).getAll();

            request.setAttribute("showSearchProduct", "Yes");
            request.setAttribute("allProducts", products);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("requestUpdate")) {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Product product = (new ProductDAO()).getProductsById(productId);

            request.setAttribute("productUpdate", product);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("sendUpdateDetail")) {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Date release_date = Date.valueOf(request.getParameter("release_date"));

            Product product = (new ProductDAO()).getProductsById(id);

            //set new value for product
            product.setName(name);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setRelease_date(release_date);

            (new ProductDAO()).updateProduct(product, id);
            request.setAttribute("UpdateDone", "Update information for Product (ID = " + id + ") done!\nClick Product Manager to see all changes");
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("requestInsert")) {
            Vector<Brand> brands = (new BrandDAO()).getAll();

            request.setAttribute("insertProduct", "insertProduct");
            request.setAttribute("allBrands", brands);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("sendInsertDetail")) {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String description = request.getParameter("description");
            String image_url = request.getParameter("image_url");
            int brandId = Integer.parseInt(request.getParameter("brand"));
            Date release_date = Date.valueOf(request.getParameter("release_date"));

            Product product = new Product(quantity, brandId, name, description, image_url, price, release_date);
            int gerenatedProductId = (new ProductDAO()).insertProduct(product);
            request.setAttribute("InsertDone", "Insert a new Product (ID = " + gerenatedProductId + ")\nClick Product Manager to see all changes");
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }

        if (service.equals("searchByKeywords")) {
            String keywords = request.getParameter("keywords");

            Vector<Product> products = (new ProductDAO()).getProductsByKeywords(keywords);

            if (products == null || products.isEmpty()) {
                request.setAttribute("notFoundProduct", "Your keywords do not match with any Product Name");
                products = (new ProductDAO()).getAll();
            }

            request.setAttribute("allProducts", products);
            request.setAttribute("keywords", keywords);
            request.setAttribute("showSearchProduct", "Yes");
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }
        
        if (service.equals("requestDelete")) {
            String productId_raw = request.getParameter("productId");
            int productId = Integer.parseInt(productId_raw);
            
            int n = (new ProductDAO()).deletetProduct(productId);
            if (n == 1) {
                request.setAttribute("deleteDone", "Delete Product (Id = " + productId +") done!");
            } else {
                request.setAttribute("deleteDone", "Failed to delete Product (Id  = " + productId + ") because this product is asociated with an order.");
            }
            
            Vector<Product> products = (new ProductDAO()).getAll();

            request.setAttribute("showSearchProduct", "Yes");
            request.setAttribute("allProducts", products);
            request.getRequestDispatcher("admin.index.jsp").forward(request, response);
        }
    }

}
