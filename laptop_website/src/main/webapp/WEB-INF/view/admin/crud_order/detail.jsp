<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>

    <title>Chi tiết đơn hàng</title>
    <meta content="" name="description"/>
    <meta content="" name="keywords"/>

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon"/>
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon"/>

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect"/>
    <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
            rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap-icons.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/boxicons.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.snow.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.bubble.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/remixicon/remixicon.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/style.css" rel="stylesheet"/>

    <!-- Template Main CSS File -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet"/>
</head>
<body>
<!-- ======= Header ======= -->
<jsp:include page="../header.jsp"/>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<jsp:include page="../sidebar.jsp"/>
<!-- End Sidebar-->

<main id="main" class="main">
    <!-- Toast Container -->
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div id="successToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="bi bi-check-circle me-2"></i>
                    Cập nhật trạng thái thành công!
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <div class="pagetitle d-flex justify-content-between align-items-center">
        <h1>Chi tiết đơn hàng</h1>
        <nav>
            <ol class="breadcrumb d-flex m-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/view/admin/dashboard"><i class="bi bi-house"></i></a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/view/admin/order">Đơn hàng</a></li>
                <li class="breadcrumb-item active">Chi tiết</li>
            </ol>
        </nav>
    </div>

    <section class="section">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body pt-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title">Thông tin đơn hàng #${order.id}</h5>
                            <span class="badge bg-${order.status == 'PENDING' ? 'warning' : 
                                                  order.status == 'PROCESSING' ? 'info' : 
                                                  order.status == 'SHIPPED' ? 'primary' : 
                                                  order.status == 'DELIVERED' ? 'success' : 'danger'} 
                                   fs-6">${order.status}</span>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h6 class="card-subtitle mb-3 text-muted">Thông tin khách hàng</h6>
                                        <p class="mb-2"><strong>Tên khách hàng:</strong> ${order.user.fullname}</p>
                                        <p class="mb-2"><strong>Địa chỉ:</strong> ${order.address}</p>
                                        <p class="mb-0"><strong>Số điện thoại:</strong> ${order.phone}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h6 class="card-subtitle mb-3 text-muted">Thông tin đơn hàng</h6>
                                        <p class="mb-2"><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy HH:mm"/></p>
                                        <p class="mb-2"><strong>Số lượng sản phẩm:</strong> ${order.quality_product}</p>
                                        <p class="mb-0"><strong>Tổng tiền:</strong> <span class="text-primary fw-bold"><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/></span></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h6 class="card-subtitle mb-3 text-muted">Cập nhật trạng thái</h6>
                                        <form id="updateStatusForm" action="${pageContext.request.contextPath}/admin/order/${order.id}/status" method="post" class="d-flex align-items-center gap-3">
                                            <select id="status" name="status" class="form-select" style="max-width: 200px;">
                                                <option value="PENDING" <c:if test="${order.status == 'PENDING'}">selected</c:if>>Chờ xử lý</option>
                                                <option value="PROCESSING" <c:if test="${order.status == 'PROCESSING'}">selected</c:if>>Đang xử lý</option>
                                                <option value="SHIPPED" <c:if test="${order.status == 'SHIPPED'}">selected</c:if>>Đang giao hàng</option>
                                                <option value="DELIVERED" <c:if test="${order.status == 'DELIVERED'}">selected</c:if>>Đã giao hàng</option>
                                                <option value="CANCELLED" <c:if test="${order.status == 'CANCELLED'}">selected</c:if>>Đã hủy</option>
                                            </select>
                                            <button type="submit" class="btn btn-primary">
                                                <i class="bi bi-save me-1"></i> Cập nhật
                                            </button>
                                            <a href="${pageContext.request.contextPath}/view/admin/order" class="btn btn-secondary">
                                                <i class="bi bi-arrow-left me-1"></i> Quay lại
                                            </a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- ======= Footer ======= -->
<jsp:include page="../footer.jsp"/>
<!-- End Footer -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
    <i class="bi bi-arrow-up-short"></i>
</a>

<!-- Vendor JS Files -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/simple-datatables.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/tinymce/tinymce.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/php-email-form/validate.js"></script>

<!-- Template Main JS File -->
<script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>

<script>
    // Đợi cho tất cả tài nguyên được tải xong
    window.addEventListener('load', function() {
        // Khởi tạo toast
        const toastElList = document.getElementById('successToast');
        const toast = new bootstrap.Toast(toastElList, {
            animation: true,
            autohide: true,
            delay: 3000
        });

        // Xử lý form submit
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // Lấy dữ liệu form
                const formData = new FormData(form);
                const status = formData.get('status');
                
                // Gửi request
                fetch(form.action, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `status=${status}`
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    // Hiển thị toast
                    toast.show();
                    
                    // Đợi toast hiển thị xong rồi reload
                    setTimeout(() => {
                        window.location.reload();
                    }, 2000);
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi cập nhật trạng thái');
                });
            });
        }

        // Kiểm tra URL parameter và hiển thị toast nếu cần
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            toast.show();
        }
    });

    // Thêm debug logs
    console.log('Bootstrap version:', bootstrap.version);
    console.log('Toast element:', document.getElementById('successToast'));
</script>

</body>
</html>
