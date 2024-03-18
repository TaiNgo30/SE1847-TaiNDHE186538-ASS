<%-- 
    Document   : Panner
    Created on : Feb 23, 2023, 2:11:06 AM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.CartItem, model.Product, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Panner</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="Free HTML Templates" name="keywords" />
        <meta content="Free HTML Templates" name="description" />

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet"
            />

        <!-- Font Awesome -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet" />
        <style>
            .badge {
                padding-left: 9px;
                padding-right: 9px;
                -webkit-border-radius: 9px;
                -moz-border-radius: 9px;
                border-radius: 9px;
            }

            .label-warning[href],
            .badge-warning[href] {
                background-color: #c67605;
            }
            #lblCartCount {
                font-size: 12px;
                background: #ff0000;
                color: #fff;
                padding: 0 5px;
                vertical-align: top;
                margin-left: -10px;
            }
        </style>
    </head>

    <body>
        <!-- Topbar Start -->
        <div class="container-fluid">
            <div class="row bg-secondary py-2 px-xl-5">
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="d-inline-flex align-items-center">
                        <span class="text-muted px-2">|</span>
                        <a class="text-dark" href="#">HE186538</a>
                        <span class="text-muted px-2">|</span>
                        <a class="text-dark" href="#">Ngô Đức Tài</a>
                        <span class="text-muted px-2">|</span>
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-right">

                    <c:if test="${sessionScope.fullname != null}">
                        <span class="text-muted px-2">|</span>
                        <span class="text-dark">Welcome: ${sessionScope.fullname}</span>
                        <span class="text-muted px-2">|</span>

                        <span class="text-muted px-2">|</span>
                        <a class="text-dark" href="logout">Logout</a>
                        <span class="text-muted px-2">|</span>
                    </c:if>

                </div>
            </div>
            <div class="row align-items-center py-3 px-xl-5">
                <div class="col-lg-3 d-none d-lg-block">
                    <a href="customer" class="text-decoration-none">
                        <h1 class="m-0 display-5 font-weight-semi-bold">
                            <span class="text-primary font-weight-bold border px-3 mr-1"
                                  >E</span
                            >Shopper
                        </h1>
                    </a>
                </div>

                <div class="col-lg-6 col-6 text-left">
                    <c:if test="${user.role_id != 0}">

                        <form action="customer" id="searchByName">
                            <input type="hidden" name="service" value="searchByKeywords"/>
                            <div class="input-group">
                                <input
                                    type="text"
                                    class="form-control"
                                    placeholder="Search for products"
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
                    </c:if>
                </div>
                <c:if test="${user.role_id == 1}">
                    <div class="col-lg-3 col-6 text-right">
                        <a href="cart?service=showCart" class="btn border">
                            <i class="fas fa-shopping-cart text-primary"></i>
                            <%
                                int numberProductsInCart = 0;
                                java.util.Enumeration ens = session.getAttributeNames();

                                            while (ens.hasMoreElements()) {

                                                String id = ens.nextElement().toString();

                                                if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                                                    //numberProductsInCart++;
                                                    
                                                    CartItem cartItem = (CartItem) session.getAttribute(id); 
                                                    Product product = cartItem.getProduct();
                                                    int quantity = cartItem.getQuantity();
                                                    numberProductsInCart += quantity;
                                    }
                                }
                                session.setAttribute("numberProductsInCart", numberProductsInCart);
                            %>
                            <span class='badge badge-warning' id='lblCartCount'> ${numberProductsInCart} </span>
                            <span class="badge">Show Cart</span>
                        </a>
                    </div>
                </c:if>
            </div>
        </div>   
        <!-- Topbar End -->

        <!-- Navbar Start -->
        <div class="container-fluid">
            <div class="row border-top px-xl-5">
                <div class="col-lg-3 d-none d-lg-block">
                    <a
                        class="btn shadow-none d-flex align-items-center justify-content-center bg-primary text-white w-100"
                        data-toggle="collapse"
                        href="#navbar-vertical"
                        style="height: 65px; margin-top: -1px; padding: 0 30px"
                        >
                        <h6 class="m-0">Laptop World</h6>
                    </a>
                </div>
                <div class="col-lg-9">
                    <nav
                        class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0"
                        >
                        <a href="" class="text-decoration-none d-block d-lg-none">
                            <h1 class="m-0 display-5 font-weight-semi-bold">
                                <span class="text-primary font-weight-bold border px-3 mr-1"
                                      >E</span
                                >Shopper
                            </h1>
                        </a>
                        <button
                            type="button"
                            class="navbar-toggler"
                            data-toggle="collapse"
                            data-target="#navbarCollapse"
                            >
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div
                            class="collapse navbar-collapse justify-content-between"
                            id="navbarCollapse"
                            >
                            <div class="navbar-nav mr-auto py-0">
                                <a href="customer" class="nav-item nav-link active">Shop</a>
                                <a href="#product" class="nav-item nav-link">Products</a>
                                <a href="#footer" class="nav-item nav-link">Contact</a>
                                <a href="admin" class="nav-item nav-link">Shop Manager</a>
                            </div>
                            <div class="navbar-nav ml-auto py-0">
                                <c:if test="${sessionScope.user eq null}" >
                                    <a href="login" class="nav-item nav-link">Login</a>
                                    <a href="register" class="nav-item nav-link">Register</a>
                                </c:if>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar End -->

        <!-- Page Header Start -->
        <div class="container-fluid bg-secondary mb-5">
            <div
                class="d-flex flex-column align-items-center justify-content-center"
                style="min-height: 300px"
                >
                <h1 class="font-weight-semi-bold text-uppercase mb-3">
                    Welcome to EShopper
                </h1>
                <div class="d-inline-flex">
                    <p class="m-0"><a href="">Home</a></p>
                    <p class="m-0 px-2">-</p>
                    <p class="m-0">Shop</p>
                </div>
            </div>
        </div>
        <!-- Page Header End -->

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
