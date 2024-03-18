<%-- 
    Document   : CustomerManager
    Created on : Feb 14, 2023, 1:28:41 PM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 class="font-weight-semi-bold text-uppercase mb-3 text-center">
            Customers Manager
        </h1>

        <!--Search customer by name-->
        <div
            class="d-flex align-items-center justify-content-between mb-4"
            >
            <form action="manageCustomer" id="searchByName">
                <input type="hidden" name="service" value="searchByKeywords"/>
                <div class="input-group">
                    <input
                        type="text"
                        class="form-control"
                        placeholder="Search by name"
                        name="keywords"
                        value="${keywords}"
                        />
                    <div class="input-group-append">
                        <button class="search-button btn btn-primary" type="submit">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>            
        </div>

        <c:if test="${notFoundCustomer ne null}">
            <h4 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                ${notFoundCustomer}
            </h4>
        </c:if>
        <div class="col-lg-12 table-responsive mb-5">
            <table class="table table-bordered text-center mb-0">
                <thead class="bg-secondary text-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Fullname</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Banned</th>
                        <th>Ban this user?</th>
                    </tr>
                </thead>                                       
                <tbody class="align-middle">
                    <c:forEach items="${allCustomers}" var="customer">
                        <tr>
                            <td class="align-middle">${customer.id}</td>
                            <td class="align-middle">${customer.username}</td>
                            <td class="align-middle">${customer.password}</td>
                            <td class="align-middle">${customer.fullname}</td>
                            <td class="align-middle">${customer.email}</td>
                            <td class="align-middle">${customer.phone}</td>
                            <td class="align-middle">${customer.address}</td>
                            <td class="align-middle">
                                <c:if test="${customer.banned == 1}">X</c:if>
                                </td>
                                <td class="align-middle"><a href="manageCustomer?service=ban&id=${customer.id}"><button class="btn btn-sm btn-primary">
                                        <i class="fa fa-times"></i>
                                    </button></a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
