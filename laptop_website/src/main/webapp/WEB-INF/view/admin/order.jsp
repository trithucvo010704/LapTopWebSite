<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Quản lý đơn hàng</title>

    <!-- Favicons -->
    <link href="${pageContext.request.contextPath}/resources/assets/img/favicon.png" rel="icon"/>
    <link href="${pageContext.request.contextPath}/resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon"/>

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet"/>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Vendor CSS Files -->
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap-icons.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/boxicons.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.snow.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.bubble.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/remixicon/remixicon.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/style.css" rel="stylesheet"/>

    <!-- Template Main CSS File -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet"/>
    
    <!-- Custom CSS -->
    <style>
        .status-badge {
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.875rem;
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .filter-section {
            background-color: #fff;
            padding: 1rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 1.5rem;
        }
        .table-responsive {
            overflow-x: auto;
        }
        .avatar-sm {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
        }
    </style>
</head>

<body>
    <!-- ======= Header ======= -->
    <jsp:include page="header.jsp"/>
    <!-- End Header -->

    <!-- ======= Sidebar ======= -->
    <jsp:include page="sidebar.jsp"/>
    <!-- End Sidebar-->

    <main id="main" class="main">
        <div class="pagetitle d-flex justify-content-between align-items-center">
            <div>
                <h1>Quản lý đơn hàng</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active">Đơn hàng</li>
                    </ol>
                </nav>
            </div>
<%--            Xuất file Excel--%>
            <a href="${pageContext.request.contextPath}/admin/order/export/csv" class="btn btn-success">
                <i class="bi bi-file-earmark-excel me-1"></i> Xuất file Excel
            </a>
        </div>

        <section class="section">
            <div class="row">
                <div class="col-12">
                    <!-- Orders Table -->
                    <div class="card">
                        <div class="card-body">
                            <div class="container-fluid mt-4">
                                <!-- Show message -->
                                <div class="toast-container position-fixed top-0 end-0 p-3">
                                    <c:if test="${not empty successMessage}">
                                        <div id="successToast" class="toast align-items-center text-white bg-success border-0" role="alert"
                                             aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
                                            <div class="d-flex">
                                                <div class="toast-body">${successMessage}</div>
                                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                                                        aria-label="Close"></button>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty errorMessage}">
                                        <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert"
                                             aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
                                            <div class="d-flex">
                                                <div class="toast-body">${errorMessage}</div>
                                                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                                                        aria-label="Close"></button>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Header: Tiêu đề  -->
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4 class="mb-0">Danh sách đơn hàng</h4>
                                    
                                </div>

                                <!-- Search & Filter Form -->
                                <form class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/view/admin/order">
                                    <div class="col-md">
                                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm theo tên khách hàng..." name="searchId"
                                               value="${param.searchId}">
                                    </div>
                                    <div class="col-md">
                                        <select class="form-select" name="status" onchange="this.form.submit()">
                                            <option value="">-- Tất cả trạng thái --</option>
                                            <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                                            <option value="PROCESSING" ${param.status == 'PROCESSING' ? 'selected' : ''}>Đang xử lý</option>
                                            <option value="SHIPPED" ${param.status == 'SHIPPED' ? 'selected' : ''}>Đang giao hàng</option>
                                            <option value="DELIVERED" ${param.status == 'DELIVERED' ? 'selected' : ''}>Đã giao hàng</option>
                                            <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                                        </select>
                                    </div>
                                    <div class="col-md">
                                        <select class="form-select" name="sortBy" onchange="this.form.submit()">
                                            <option value="">-- Sắp xếp --</option>
                                            <option value="dateAsc" ${param.sortBy == 'dateAsc' ? 'selected' : ''}>Ngày đặt: Tăng dần</option>
                                            <option value="dateDesc" ${param.sortBy == 'dateDesc' ? 'selected' : ''}>Ngày đặt: Giảm dần</option>
                                            <option value="priceAsc" ${param.sortBy == 'priceAsc' ? 'selected' : ''}>Tổng tiền: Tăng dần</option>
                                            <option value="priceDesc" ${param.sortBy == 'priceDesc' ? 'selected' : ''}>Tổng tiền: Giảm dần</option>
                                        </select>
                                    </div>
                                    <div class="col-md">
                                        <select class="form-select" name="size" onchange="this.form.submit()">
                                            <option value="5" ${param.size == '5' ? 'selected' : ''}>5 đơn hàng/trang</option>
                                            <option value="10" ${param.size == '10' ? 'selected' : ''}>10 đơn hàng/trang</option>
                                            <option value="20" ${param.size == '20' ? 'selected' : ''}>20 đơn hàng/trang</option>
                                            <option value="50" ${param.size == '50' ? 'selected' : ''}>50 đơn hàng/trang</option>
                                        </select>
                                    </div>
                                    <div class="col-md">
                                        <button class="btn btn-primary w-100" type="submit">Lọc</button>
                                    </div>
                                </form>

                                <!-- Table -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-bordered align-middle">
                                        <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>Khách hàng</th>
                                            <th>Ngày đặt</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${not empty orders}">
                                                <c:forEach var="order" items="${orders}" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAA7AAAAOwBeShxvQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAKoSURBVFiF7ZdPSBRRHMe/b2Z2/+3urCUpuZmUhRgaJGhJlxAi6BJB0LVDHSKCOtS9U4fwkKcuRdQhglqljh0i6GBQiKBUhLWwRqXLuqAUbvszZ2ceLWG7M7OzM7tB0Pd0Zt7v+/t+Z37v994T2CXIsgxA9/2lGxG/+woQkuV4qWJkZASAYDCIw2FAkiQURUGWZUQxYbfhcJhwOEwkEkFRFPx+P4FAAEVRACgvL6e6uppQKEQoFCIYDBIMBhFFkYqKCvx+P4IgYBgG8XicWCxGNBolGo2iqioAqqpSWVlJVVUVsViMWCyGrusbcW1tbZbvkiTR0tJCPB4nHo+j6zqGYQBQWlpKWVkZmqahqiqKouD1egkEAgBks1kikQjhcJhEIoGu6/h8PrxeL7quEw6HmZ+fJ5PJAOByuhoasLS0hNvtJpvNUlJSQmhoKI/Hw+fzEQwGUSqVKCsrQ1RUFNlsVkxMDFwuF4FAAJVKJYRCoVAoBCgqKqKzsxOPx8Pv9xMNBoiiCLPZLHq9HvPz89rb23E4HIyPj2MymTQ0NCAYDLK6uopkMkkwGGR+fp7V1VWcnp6mpqYGXddJpVLodruMjY3h8XjodDptB0CVSiWEQkHtdotsNoqiCLqu09PTw+PxsN/z50+y/bDTMVVVdHZ2ElVVSUlJCV3XaWdnJ5vNApvN0tLSglQqRVlZGZqmoaury+98S7KdnZ20tLQQjUaJxWJMTU0RTZNlZWWcnp7G4/FgbO3t7QCAw+FgcnKSzs5O+vt7CQaDjI+PMzU1RW9vL21tbaGjo4OhoSHGmZubY3R0lMLCQvR6PbquYxgGysvLyWQyRKFQALC8vJzKyko8Hg+maQBgYmKCoihYLBaGYQDDMKCpKhiGAaZpmpqamhobG/l2k6mpKXg8nr2WZTm/0tLS0tLSgnQ6TSQSERUVhdLSUpRSBgYGKKWUwMBABgYGaGlpoaWlhdzcXMbGxmhqamoGgsHn/Xw+TygUAoHA5/PR3d3N0dFRDg4O0N/fz+joKJvNAoDZbCYaDSKRSADQ3d3N0dERlUrlkK0tLSUlJQUul2uPhUKhpqamHA6HXw/4B/7Q406+b21tZW5uLpvNAoDxeJxoNCYajfJ6vSQSCcrlcjKZLKfTyeVyGYaBIAgwGAxMJhOMx2MAWFtbGwwGs9/b2Njg8/nwer0AgMlkEvV6nUQigbW1NZVKJYFAALVazf7Dcrkkm83y/X4Wi0WAwcHBhMNhxGLxL29uLrvS3p99B9gAAAAASUVORK5CYII="
                                                                     alt="Avatar" class="avatar-sm">
                                                                <div class="ms-2">
                                                                    <div class="fw-medium">${order.user.fullname}</div>
                                                                    <div class="text-muted small">${order.phone}</div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td><fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                        <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" pattern="#,##0.##"/></td>
                                                        <td>
                                                            <span class="badge bg-${order.status == 'PENDING' ? 'warning' :
                                                                                        order.status == 'PROCESSING' ? 'info' :
                                                                                        order.status == 'SHIPPED' ? 'primary' :
                                                                                        order.status == 'DELIVERED' ? 'success' : 'danger'}">
                                                                ${order.status == 'PENDING' ? 'Chờ xử lý' :
                                                                 order.status == 'PROCESSING' ? 'Đang xử lý' :
                                                                 order.status == 'SHIPPED' ? 'Đang giao hàng' :
                                                                 order.status == 'DELIVERED' ? 'Đã giao hàng' : 'Đã hủy'}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex gap-2">
                                                                <button class="btn btn-sm btn-primary" data-bs-toggle="modal"
                                                                        data-bs-target="#viewOrderModal_${order.id}">
                                                                    <i class="bi bi-eye"></i>
                                                                </button>
                                                                <button class="btn btn-sm btn-warning" data-bs-toggle="modal"
                                                                        data-bs-target="#updateStatusModal_${order.id}">
                                                                    <i class="bi bi-pencil-fill"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="7" class="text-center text-danger fw-bold">Không có đơn hàng</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <c:if test="${not empty orders}">
                                    <nav aria-label="Page navigation" class="mt-4">
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage > 0 ? currentPage - 1 : 0}&size=${param.size}${not empty param.searchId ? '&searchId='.concat(param.searchId) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">Trước</a>
                                            </li>
                                            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="?page=${i}&size=${param.size}${not empty param.searchId ? '&searchId='.concat(param.searchId) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">${i + 1}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage + 1}&size=${param.size}${not empty param.searchId ? '&searchId='.concat(param.searchId) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">Sau</a>
                                            </li>
                                        </ul>
                                    </nav>
                                    <p class="mt-3">
                                        Bạn đang xem trang ${currentPage + 1} trên ${totalPages} trang
                                    </p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- ======= Footer ======= -->
    <jsp:include page="footer.jsp"/>
    <!-- End Footer-->

    <!-- Vendor JS Files -->
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/apexcharts/apexcharts.min.js"
    ></script>
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/chart.js/chart.umd.js"
    ></script>
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/echarts/echarts.min.js"
    ></script>
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.js"
    ></script>
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/simple-datatables.js"
    ></script>
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/tinymce/tinymce.min.js"
    ></script>
    <script
      src="${pageContext.request.contextPath}/resources/assets/vendor/php-email-form/validate.js"
    ></script>

    <!-- Template Main JS File -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>

    <!-- Ensure this is the only Bootstrap Bundle with Popper JS link, and it's at the very end of body -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var successToastEl = document.getElementById('successToast');
            if (successToastEl) {
                var successToast = new bootstrap.Toast(successToastEl);
                successToast.show();
            }

            var errorToastEl = document.getElementById('errorToast');
            if (errorToastEl) {
                var errorToast = new bootstrap.Toast(errorToastEl);
                errorToast.show();
            }
        });
    </script>

    <!-- Include modals -->
    <c:if test="${not empty orders}">
        <c:forEach var="order" items="${orders}">
            <%@ include file="crud_order/view_order.jsp" %>
            <%@ include file="crud_order/update_status.jsp" %>
        </c:forEach>
    </c:if>
</body>
</html>
