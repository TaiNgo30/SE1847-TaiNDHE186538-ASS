<%-- 
    Document   : admin.index
    Created on : Feb 27, 2023, 12:38:41 AM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- Header -->
        <%@include file="Panner.jsp" %>

        <!-- Body -->
        <div class="container-fluid mb-5">
            <div class="row border-top px-xl-5">
                <!--Left Menu-->
                <div class="col-lg-3 d-none d-lg-block">
                    <a class="btn shadow-none d-flex align-items-center justify-content-between bg-primary text-white w-100" data-toggle="collapse" href="#navbar-vertical" style="height: 65px; margin-top: -1px; padding: 0 30px;">
                        <h6 class="m-0">Admin Manager</h6>
                    </a>
                    <nav class="collapse show navbar navbar-vertical navbar-light align-items-start p-0 border border-top-0 border-bottom-0" id="navbar-vertical">
                        <div class="navbar-nav w-100 overflow-hidden" style="height: 410px">
                            <a href="manageCustomer" class="nav-item nav-link">Customer Manager</a>
                            <a href="manageProduct" class="nav-item nav-link">Product Manager</a>
                            <a href="manageBill" class="nav-item nav-link">Bill Manager</a>

                    </nav>
                </div>
                <!--End Left Menu-->


                <!--Right Content-->   
                <div class="col-lg-9">

                    <!--Customer Manager-->
                    <c:if test="${manageCustomer ne null}">
                        <c:if test="${not empty allCustomers}">
                            <%@include file="CustomerManager.jsp" %>
                        </c:if>
                    </c:if>

                    <!--Customer Manager End-->

                    <!--Product Manager-->
                    <c:if test="${manageProduct ne null}">
                        <%@include file="ProductManager.jsp" %>

                    </c:if>
                    <!--Product Manager End-->

                    <c:if test="${manageBill ne null}">
                        <%@include file="BillManager.jsp" %>
                    </c:if>

                </div>
                <!--End Right Content-->

            </div>
        </div>

        <!-- Footer -->
        <%@include file="Footer.jsp" %>
    </body>
</html>
