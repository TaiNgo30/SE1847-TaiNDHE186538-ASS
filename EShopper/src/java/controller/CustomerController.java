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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Vector;
import model.Brand;
import model.Product;

/**
 *
 * @author ducta
 */
public class CustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String service = request.getParameter("service");
        Vector<Brand> brands = (new BrandDAO()).getAll();
        request.setAttribute("allBrands", brands);

        if (session.getAttribute("numberProductsInCart") == null) {
            session.setAttribute("numberProductsInCart", 0);
        }
        
        if (service == null) {
            service = "listAllProducts";
        }

        if (service.equals("listAllProducts")) {
            Vector<Product> products = (new ProductDAO()).getAll();
            request.setAttribute("allProducts", products);

            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

        if (service.equals("searchByKeywords")) {
            String keywords = request.getParameter("keywords");
            String sortBy = request.getParameter("sortBy");
            String filterByPrice = request.getParameter("filterByPrice");
            String filterByBrand = request.getParameter("filterByBrand");

            if (filterByPrice == null) {
                filterByPrice = "price-all";
            }

            if (filterByBrand == null) {
                filterByBrand = "brand-all";
            }

            Vector<Product> productsAfterFilterByKeywords = (new ProductDAO()).getProductsByKeywords(keywords);
            Vector<Product> productsAfterFilterByPrice;
            Vector<Product> productsAfterFilterByBrand;

            request.setAttribute("keywords", keywords);
            //filter by price
            productsAfterFilterByPrice = (new ProductDAO()).filterByPrice(filterByPrice, productsAfterFilterByKeywords);
            request.setAttribute("filterByPrice", filterByPrice);

            //filter by brand
            productsAfterFilterByBrand = (new ProductDAO()).filterByBrand(filterByBrand, productsAfterFilterByPrice);
            request.setAttribute("filterByBrand", filterByBrand);

            if (sortBy == null || sortBy.equals("unsorted")) {
                request.setAttribute("allProducts", productsAfterFilterByBrand);
                request.setAttribute("sortBy", "unsorted");

            } else if (sortBy.equals("priceLowHigh") || sortBy.equals("priceHighLow") || sortBy.equals("latest")) {
                Vector<Product> productsAfterFilter = (new ProductDAO()).sortProducts(productsAfterFilterByBrand, sortBy);

                request.setAttribute("allProducts", productsAfterFilter);
                request.setAttribute("sortBy", sortBy);
            }
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

}
