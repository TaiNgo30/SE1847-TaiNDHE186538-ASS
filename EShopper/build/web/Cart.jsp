<%-- 
    Document   : Cart
    Created on : Feb 23, 2023, 12:36:23 PM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.CartItem, model.Product, java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Cart</title>
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
    </head>

    <body>

        <!-- Header -->
        <%@include file="Panner.jsp" %>


        <!-- Body -->
        <div class="container-fluid pt-5" id="product">
            <div class="row px-xl-5"> 
                <!-- Cart Start -->
                <div class="container-fluid pt-5">
                    <div class="row px-xl-5">
                        <c:if test="${showBill eq null}">
                            <div class="col-lg-8 table-responsive mb-5">
                                <button class="btn btn-block btn-primary my-3 py-3 w-25" onclick="goBack()">
                                    <-- Back
                                </button>
                                <table class="table table-bordered text-center mb-0">
                                    <thead class="bg-secondary text-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Product Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th>Remove</th>
                                        </tr>
                                    </thead>                                       
                                    <tbody class="align-middle">
                                        <%
                                            double total_raw = 0;
                                            java.util.Enumeration enms = session.getAttributeNames();

                                            while (enms.hasMoreElements()) {

                                                String id = enms.nextElement().toString();

                                                if (!id.equals("user") && !id.equals("fullname") && !id.equals("numberProductsInCart")) {
                                                    CartItem cartItem = (CartItem) session.getAttribute(id); 
                                                    Product product = cartItem.getProduct();
                                                    int quantity = cartItem.getQuantity();
                                        %>
                                    <form action="cart" id="add-cart">
                                        <input type="hidden" name="service" value="update"/>
                                    </form>
                                    <tr>
                                        <td class="align-middle"><%= product.getId()%></td>
                                        <td class="align-middle">
                                            <img src="<%= product.getImage_url()%>" alt="" style="width: 50px" />
                                            <%= product.getName()%>
                                        </td>
                                        <td class="align-middle"><%= product.getPrice()%></td>
                                        <td class="align-middle">
                                            <div class="input-group quantity mx-auto" style="width: 100px" >
                                                <input
                                                    type="number"
                                                    class="form-control form-control-sm bg-secondary text-center"
                                                    value="<%= quantity%>"
                                                    form="add-cart"
                                                    name="p<%= id%>"
                                                    />
                                            </div>
                                        </td>
                                        <td class="align-middle"><%= Math.round((product.getPrice() * quantity) * 10) / 10.0 %></td>
                                        <td class="align-middle">
                                            <a href="cart?service=removeItem&id=<%= id%>"><button class="btn btn-sm btn-primary">
                                                    <i class="fa fa-times"></i>
                                                </button></a>
                                        </td>
                                    </tr>
                                    <%      total_raw += (product.getPrice() * quantity);
                                            }
                                        }
                                    DecimalFormat df = new DecimalFormat("#.0");
                                    String total = df.format(total_raw);
                                    %>
                                    </tbody>
                                </table>

                                <button class="btn btn-block btn-primary my-3 py-3" 
                                        style="float: left; width: 15%;"
                                        onclick="document.getElementById('add-cart').submit();" >
                                    Update
                                </button>
                                <a href="cart?service=removeAll">
                                    <button class="btn btn-block btn-primary my-3 py-3"
                                            style="float: right; width: 15%;" >
                                        Remove all
                                    </button>
                                </a>

                            </div>

                            <div class="col-lg-4">
                                <div class="card border-secondary mb-5">
                                    <div class="card-header bg-secondary border-0">
                                        <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium">Subtotal</h6>
                                            <h6 class="font-weight-medium">$<%= total%></h6>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h6 class="font-weight-medium">Shipping</h6>
                                            <h6 class="font-weight-medium">$0</h6>
                                        </div>
                                    </div>
                                    <div class="card-footer border-secondary bg-transparent">
                                        <div class="d-flex justify-content-between mt-2">
                                            <h5 class="font-weight-bold">Total</h5>
                                            <h5 class="font-weight-bold">$<%= total%></h5>
                                        </div>

                                        <a href="cart?service=checkOut">
                                            <button class="btn btn-block btn-primary my-3 py-3">
                                                Proceed To Checkout
                                            </button>
                                        </a>

                                    </div>
                                    <c:if test="${checkOutDone ne null}">
                                        <div class="card-header bg-secondary border-0 text-center">
                                            Checkout Done! See your <a href="cart?service=showBill&billId=${BillId}">Bill? (click here)</a>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>

                        <!--show bill detail--> 
                        <c:if test="${showBill ne null}">

                            <div class="col-lg-8 table-responsive mb-5">
                                <h1 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                                    Your Bill Here!
                                </h1>
                                <table class="table table-bordered text-center mb-0">
                                    <thead class="bg-secondary text-dark">
                                        <tr>
                                            <th>BillID</th>
                                            <th>Customer Name</th>
                                            <th>Created Date</th>
                                            <th>Product Name</th>
                                            <th>Quantity</th>
                                            <th>SubTotal</th>
                                        </tr>
                                    </thead>
                                    <tbody class="align-middle">
                                        <c:set var="total" value="0" />
                                        <c:forEach var="billDetail" items="${billDetails}">
                                            <tr>
                                                <td class="align-middle">${billDetail.id}</td>
                                                <td class="align-middle">${billDetail.customerName}</td>
                                                <td class="align-middle">${billDetail.created_date}</td>
                                                <td class="align-middle">
                                                    <img src="${billDetail.image_url}" alt="" style="width: 50px" />
                                                    ${billDetail.productName}
                                                </td>
                                                <td class="align-middle">${billDetail.productQuantity}</td>
                                                <td class="align-middle">${Math.round(billDetail.subTotal)*1.0}</td>
                                            </tr>
                                            <c:set var="subtotal" value="${billDetail.subTotal}" />
                                            <c:set var="total" value="${total + subtotal}" />
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-lg-4" style="transform: translateY(65px)">
                                <div class="card border-secondary mb-5">
                                    <div class="card-header bg-secondary border-0">
                                        <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium">Subtotal</h6>
                                            <h6 class="font-weight-medium">$${Math.round(total)*1.0}</h6>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h6 class="font-weight-medium">Shipping</h6>
                                            <h6 class="font-weight-medium">$0</h6>
                                        </div>
                                    </div>
                                    <div class="card-footer border-secondary bg-transparent">
                                        <div class="d-flex justify-content-between mt-2">
                                            <h5 class="font-weight-bold">Total</h5>
                                            <h5 class="font-weight-bold">$${Math.round(total)*1.0}</h5>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </c:if>

                    </div>
                </div>
                <!-- Cart End -->
            </div>
        </div>

        <!-- Footer -->
        <%@include file="Footer.jsp" %>


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
        <script>
                                            function goBack() {
                                                window.history.back();
                                            }
        </script>
    </body>
</html>
