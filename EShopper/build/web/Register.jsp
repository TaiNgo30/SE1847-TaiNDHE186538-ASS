<%-- 
    Document   : Resgister
    Created on : Feb 23, 2023, 4:00:38 PM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Oswald&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/styleLogin.css"/>
    </head>
    <body>
        <div class="form_hoa">
            <div class="box_login">

                <c:if test="${registerSuccess ne null}">
                    <p style="color: red; font-size: 1.5rem; text-align: center">${registerSuccess}</p>
                </c:if>

                <form action="register" method="POST">
                    <div class="row-item login-now">
                        <span style="text-align: center">You have an account? </span>
                        <a href="login" class="button-login-now">Login Now</a>
                    </div>

                    <h2>Register</h2>
                    <div class="row-item">
                        <label for="username">Username</label>
                        <input type="text" name="username" placeholder="Enter Username" />
                    </div>

                    <c:if test="${duplicateUsername ne null}">
                        <p style="color: red; font-size: 1.25rem; text-align: center">${duplicateUsername}</p>
                    </c:if>

                    <div class="row-item">
                        <label for="password">Password</label>
                        <input type="password" name="password" placeholder="Enter Password" />
                    </div>
                    <div class="row-item">
                        <label for="fullname">Fullname</label>
                        <input type="text" name="fullname" placeholder="Enter Fullname" />
                    </div>

                    <div class="row-item">
                        <label for="email">Email</label>
                        <input type="text" name="email" placeholder="Enter email" />
                    </div>

                    <div class="row-item">
                        <label for="phone">Phone</label>
                        <input type="text" name="phone" placeholder="Enter Phone" />
                    </div>

                    <div class="row-item">
                        <label for="address">Address</label>
                        <input type="text" name="address" placeholder="Enter Address" />
                    </div>

                    <div class="row-item">
                        <button type="submit">Register</button>
                    </div>
                        
                </form>
            </div>
        </div>
    </body>
</html>
