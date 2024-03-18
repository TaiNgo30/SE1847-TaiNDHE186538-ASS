<%-- 
    Document   : Login
    Created on : Feb 23, 2023, 1:24:49 PM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Oswald&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/styleLogin.css"/>
    </head>
    <body>
        <div class="form_hoa">
            <div class="box_login">
                <form action="login" method="POST">
                    <h2>Login</h2>
                    <div class="row-item">
                        <label for="username">Username</label>
                        <input type="text" name="username" placeholder="Enter Username" />
                    </div>
                    <div class="row-item">
                        <label for="password">Password</label>
                        <input type="password" name="password" placeholder="Enter Password" />
                    </div>
                    <div class="row-item">
                        <c:if test="${invalidUser != null}">
                            <p style="color: red">${invalidUser}</p>
                        </c:if>
                    </div>

                    <div class="row-item">
                        <button type="submit">Login</button>
                    </div>

                    <div class="row-item login-now">
                        <span style="text-align: center">Don't have an account? </span>
                        <a href="register" class="button-login-now">Register now</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

