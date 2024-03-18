<%-- 
    Document   : Menu
    Created on : Feb 23, 2023, 2:10:57 AM
    Author     : ducta
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Menu</title>
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

        <div class="col-lg-3 col-md-12">
            <!-- Price Start -->
            <div class="border-bottom mb-4 pb-4">
                <h5 class="font-weight-semi-bold mb-4">Filter by price</h5>
                <form>
                    <div
                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                        >
                        <input
                            type="checkbox"
                            class="custom-control-input"
                            name="price"
                            id="price-all"
                            onchange="filter(this.id)"
                            <c:if test="${filterByPrice eq null}">checked</c:if>
                            <c:if test="${filterByPrice eq 'price-all'}">checked</c:if>
                                />
                            <label class="custom-control-label" for="price-all"
                                   >All Price</label
                            >
                        </div>
                        <div
                            class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                            >
                            <input
                                type="checkbox"
                                class="custom-control-input"
                                name="price"
                                id="price-500-750"
                                onchange="filter(this.id)"
                            <c:if test="${filterByPrice eq 'price-500-750'}">checked</c:if>
                                />
                            <label class="custom-control-label" for="price-500-750"
                                   >$500 - $750</label
                            >
                        </div>
                        <div
                            class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                            >
                            <input
                                type="checkbox"
                                class="custom-control-input"
                                name="price"
                                id="price-750-1000"
                                onchange="filter(this.id)"
                            <c:if test="${filterByPrice eq 'price-750-1000'}">checked</c:if>
                                />
                            <label class="custom-control-label" for="price-750-1000"
                                   >$750 - $1000</label
                            >
                        </div>
                        <div
                            class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                            >
                            <input
                                type="checkbox"
                                class="custom-control-input"
                                name="price"
                                id="price-1000-1500"
                                onchange="filter(this.id)"
                            <c:if test="${filterByPrice eq 'price-1000-1500'}">checked</c:if>
                                />
                            <label class="custom-control-label" for="price-1000-1500"
                                   >$1000 - $1500</label
                            >
                        </div>
                        <div
                            class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                            >
                            <input
                                type="checkbox"
                                class="custom-control-input"
                                name="price"
                                id="price-1500up"
                                onchange="filter(this.id)"
                            <c:if test="${filterByPrice eq 'price-1500up'}">checked</c:if>
                                />
                            <label class="custom-control-label" for="price-1500up">$1500+</label>
                        </div>
                    </form>
                </div>
                <!-- Price End -->

                <!-- Brand Start -->
                <div class="border-bottom mb-4 pb-4">
                    <h5 class="font-weight-semi-bold mb-4">Filter by brand</h5>
                    <form>
                        <div
                            class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                            >
                            <input
                                type="checkbox"
                                class="custom-control-input"
                                name="brand"
                                id="brand-all"
                                onchange="filter(this.id)"
                            <c:if test="${filterByBrand eq 'brand-all'}">checked</c:if>
                            <c:if test="${filterByBrand eq null}">checked</c:if>
                                />
                            <label class="custom-control-label" for="brand-all">All</label>
                        </div>
                    <c:forEach items="${allBrands}" var="b">
                        <div
                            class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                            >
                            <c:set value="brand-${b.id}" var="id" />
                            <input
                                type="checkbox"
                                class="custom-control-input"
                                name="brand"
                                id="brand-${b.id}"
                                onchange="filter(this.id)"
                                <c:if test="${filterByBrand eq id}">checked</c:if>
                                    />
                                <label class="custom-control-label" for="brand-${b.id}">${b.name}</label>
                        </div>
                    </c:forEach>
                </form>
            </div>
            <!-- Brand End -->
        </div>
        <!-- Shop Sidebar End -->

        <script>
            // Get all checkbox groups
            const checkboxGroups = document.querySelectorAll('input[type="checkbox"][name]');

            // Add change event listener to each checkbox group
            checkboxGroups.forEach(group => {
                group.addEventListener('change', () => {
                    // Uncheck other checkboxes in the same group
                    checkboxGroups.forEach(checkbox => {
                        if (checkbox.name === group.name && checkbox !== group) {
                            checkbox.checked = false;
                        }
                    });
                });
            });
        </script>


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
