<%-- 
    Document   : index
    Created on : Feb 23, 2023, 2:09:38 AM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EShopper</title>
    </head>
    <body>
        <!-- Header -->
        <%@include file="Panner.jsp" %>

        <!-- Body -->
        <div class="container-fluid pt-5" id="product">
            <div class="row px-xl-5"> 
                <%@include file="Menu.jsp" %>
                <%@include file="Content.jsp" %>
            </div>
        </div>

        <!-- Footer -->
        <%@include file="Footer.jsp" %>
    </body>
</html>
