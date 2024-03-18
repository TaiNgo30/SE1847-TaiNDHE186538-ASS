<%-- 
    Document   : Content
    Created on : Feb 23, 2023, 2:11:13 AM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Content Page</title>
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
        <!-- Shop Product Start -->
        <div class="col-lg-9 col-md-12">
            <div class="row pb-3">
                <div class="col-12 pb-1">
                    <div
                        class="d-flex align-items-center justify-content-between mb-4"
                        >
                        <form action="customer" id="searchByName">
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

                        <!--Sort product-->
                        <div class="sort-options ml-4">
                            <label for="sortSelect">Sort by:</label>
                            <select id="sortSelect" onchange="sortProducts(this.value)" name="sortBy">
                                <option value="unsorted" <c:if test="${sortBy == 'unsorted'}">selected</c:if> >Sort by...</option>
                                <option value="latest" <c:if test="${sortBy == 'latest'}">selected</c:if>  >Latest</option>
                                <option value="priceLowHigh" <c:if test="${sortBy == 'priceLowHigh'}">selected</c:if> >Price: Low to High</option>
                                <option value="priceHighLow" <c:if test="${sortBy == 'priceHighLow'}">selected</c:if> >Price: High to Low</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Product here -->
                <c:forEach items="${allProducts}" var="p" >
                    <div class="col-lg-4 col-md-6 col-sm-12 pb-1">
                        <div class="card product-item border-0 mb-4">
                            <div
                                class="card-header product-img position-relative overflow-hidden bg-transparent border p-0"
                                >
                                <img class="img-fluid w-100" src="${p.image_url}" alt="" style="height: 220px"/>
                            </div>
                            <div
                                class="card-body border-left border-right text-center p-0 pt-4 pb-3"
                                >
                                <h6 class="mb-3" >${p.name}</h6>
                                <div class="d-flex justify-content-center">
                                    <h6>$ ${p.price}</h6>
                                    <h6 class="text-muted ml-2"><del>$ ${Math.round(p.price * 1.25)}</del></h6>
                                </div>
                            </div>
                            <div
                                class="card-footer d-flex justify-content-center bg-light border"
                                >
                                <a href="cart?service=addToCart&productId=${p.id}" class="btn btn-sm text-dark p-0"
                                   ><i class="fas fa-shopping-cart text-primary mr-1"></i>Add
                                    To Cart</a
                                >
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- Shop Product End -->

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
