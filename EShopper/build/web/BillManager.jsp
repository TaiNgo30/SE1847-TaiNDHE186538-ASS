<%-- 
    Document   : BillManager
    Created on : Feb 17, 2023, 1:53:39 AM
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
            Bill Manager
        </h1>
        <c:if test="${not empty billDetailForAdmins}">
            <!--Filter by status-->
            <div class="border-bottom mb-4 pb-4">
                <h5 class="font-weight-semi-bold mb-4">Filter by Status</h5>
                <form>
                    <!--Status all-->
                    <div
                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                        >
                        <input
                            type="checkbox"
                            class="custom-control-input"
                            name="status"
                            id="all"
                            onchange="filterStatus(this.id)"

                            />
                        <label class="custom-control-label" for="all"
                               >All Status</label
                        >
                    </div>

                    <!--Status Wait-->
                    <div
                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                        >
                        <input
                            type="checkbox"
                            class="custom-control-input"
                            name="status"
                            id="wait"
                            onchange="filterStatus(this.id)"

                            />
                        <label class="custom-control-label" for="wait"
                               >Wait</label
                        >
                    </div>
                    <!--Status Process-->
                    <div
                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                        >
                        <input
                            type="checkbox"
                            class="custom-control-input"
                            name="status"
                            id="process"
                            onchange="filterStatus(this.id)"

                            />
                        <label class="custom-control-label" for="process"
                               >Process</label
                        >
                    </div>
                    <!--Status Done-->
                    <div
                        class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3"
                        >
                        <input
                            type="checkbox"
                            class="custom-control-input"
                            name="status"
                            id="done"
                            onchange="filterStatus(this.id)"

                            />
                        <label class="custom-control-label" for="done"
                               >Done</label
                        >
                    </div>
                </form>
            </div>

            <script>
                function filterStatus(value) {
                    console.log(value);
                    const urlParams = new URLSearchParams(window.location.search);
                    let service = urlParams.get('service');

                    if (service === null) {
                        service = "filterStatus";
                    }

                    window.location.href = "manageBill?service=" + service + "&filter=" + value;

                }
            </script>
            <!--Filter by status End-->
            <div class="col-lg-12 table-responsive mb-5">
                <table class="table table-bordered text-center mb-0">
                    <thead class="bg-secondary text-dark">
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Created Date</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Show Detail</th>
                        </tr>
                    </thead>                                       
                    <tbody class="align-middle">
                        <c:forEach items="${billDetailForAdmins}" var="b">
                            <tr>
                                <td class="align-middle">${b.id}</td>
                                <td class="align-middle">${b.customerName}</td>
                                <td class="align-middle">${b.created_date}</td>
                                <td class="align-middle">${b.address}</td>
                                <td class="align-middle">${b.email}</td>
                                <td class="align-middle">${b.phone}</td>
                                <td class="align-middle">$${Math.round(b.total)*1.0}</td>
                                <td class="align-middle">${b.status}</td>
                                <td class="align-middle"><a href="manageBill?service=showDetailBill&billId=${b.id}&status=${b.status}">Show Detail</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <c:if test="${not empty billDetails}">



            <div class="col-lg-12 table-responsive mb-5">
                <table class="table table-bordered text-center mb-0">
                    <thead class="bg-secondary text-dark">
                        <tr>
                            <th>BillID</th>
                            <th>Customer Name</th>
                            <th>Created Date</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>SubTotal</th>
                            <th>Bill Status</th>
                        </tr>
                    </thead>
                    <tbody class="align-middle">
                        <c:set var="total" value="0" />
                        <c:forEach var="billDetail" items="${billDetails}">
                            <c:set var="billId" value="${billDetail.id}"/>
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

                                <td class="align-middle bill-status">
                                    ${status}
                                </td>
                            </tr>
                            <c:set var="subtotal" value="${billDetail.subTotal}" />
                            <c:set var="total" value="${total + subtotal}" />
                            <c:set var="statusInShowDetail" value="${status}"/>
                        </c:forEach>
                        <tr><td colspan="7">&nbsp;</td></tr>
                        <tr>
                            <td colspan="4" style="text-align: right">Change Status of this Bill To:</td>
                            <td><a href="manageBill?service=changeStatusToWait&billId=${billId}&statusInShowDetail=${statusInShowDetail}">Wait</a></td>
                            <td><a href="manageBill?service=changeStatusToProcess&billId=${billId}&statusInShowDetail=${statusInShowDetail}">Process</a></td>
                            <td><a href="manageBill?service=changeStatusToDone&billId=${billId}&statusInShowDetail=${statusInShowDetail}">Done</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="card border-secondary mb-5 col-lg-3" style="float: right">
                <div class="card-footer border-secondary bg-transparent">
                    <div class="d-flex justify-content-between mt-2">
                        <h5 class="font-weight-bold">Total</h5>
                        <h5 class="font-weight-bold">$${Math.round(total)*1.0}</h5>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${changeStatus ne null}">
            <h3 class="font-weight-semi-bold text-uppercase mb-3 text-center">
                ${changeStatus}
            </h3>
        </c:if>
    </body>
</html>
