<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>

    <title>User Page</title>
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
    <link
            href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap.min.css"
            rel="stylesheet"
            type="text/css"
    />
    <link
            href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap-icons.css"
            rel="stylesheet"
            type="text/css"
    />
    <link
            href="${pageContext.request.contextPath}/resources/assets/vendor/css/boxicons.min.css"
            rel="stylesheet"
            type="text/css"
    />
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.snow.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.bubble.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/resources/assets/vendor/remixicon/remixicon.css" rel="stylesheet" type="text/css"/>
    <link
            href="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/style.css"
            rel="stylesheet"
            type="text/css"
    />

    <!-- Template Main CSS File -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet"/>

    <style>
        .user-details p {
            margin-bottom: 0.5rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.5rem;
        }
        .user-details p:last-child {
            border-bottom: none;
        }
        .user-details strong {
            display: inline-block;
            width: 120px;
        }


        footer {
            /* position: fixed; */
            /* bottom: 0; */
            padding: 20px 0 !important;
            /* display: block; */
            /* width: 90% !important; */
            margin-top: 20px; /* Thêm khoảng trống phía trên footer */
        }

        #main {
            padding-bottom: 80px; /* Thêm khoảng trống ở cuối nội dung chính để tránh bị footer che */
        }

        .table-bordered th,
        .table-bordered td {
            border: 1px solid #dee2e6 !important; /* Đảm bảo đường viền hiển thị */
        }
    </style>
</head>

<body>
<!-- ======= Header ======= -->
<jsp:include page="layout/header.jsp"/>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<jsp:include page="layout/sidebar.jsp"/>
<!-- End Sidebar-->

<!-- Main hearing -->
<main id="main" class="main">
    <div class="pagetitle d-flex justify-content-between align-items-center">
        <div>
            <h1>Quản lý người dùng</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item active">Người dùng</li>
                </ol>
            </nav>
        </div>
        <div>
            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                + Thêm mới
            </button>
        </div>
    </div>
    <section class="section">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="container-fluid mt-4">
                            <div class="toast-container position-fixed top-0 end-0 p-3">
                                <c:if test="${not empty successMessage}">
                                    <div class="toast align-items-center text-white bg-success border-0" role="alert"
                                         aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
                                        <div class="d-flex">
                                            <div class="toast-body">${successMessage}</div>
                                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                                                    aria-label="Close"></button>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="toast align-items-center text-white bg-danger border-0" role="alert"
                                         aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
                                        <div class="d-flex">
                                            <div class="toast-body">${errorMessage}</div>
                                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                                                    aria-label="Close"></button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="mb-0">Danh sách người dùng</h4>
                            </div>
                            <form class="row g-3 mb-4" method="get" action="${pageContext.request.contextPath}/admin/user">
                                <div class="col-md-4">
                                    <input type="text" class="form-control" placeholder="Tìm theo tên..." name="searchName" value="${param.searchName}" onchange="this.form.submit()"/>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select" name="searchRole" onchange="this.form.submit()">
                                        <option value="">-- Vai trò --</option>
                                        <option value="ADMIN" ${param.searchRole == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                        <option value="EDITOR" ${param.searchRole == 'EDITOR' ? 'selected' : ''}>Editor</option>
                                        <option value="USER" ${param.searchRole == 'USER' ? 'selected' : ''}>User</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-select" name="searchStatus" onchange="this.form.submit()">
                                        <option value="">-- Trạng thái --</option>
                                        <option value="ACTIVE" ${param.searchStatus == 'ACTIVE' ? 'selected' : ''}>Hoạt động</option>
                                        <option value="LOCKED" ${param.searchStatus == 'LOCKED' ? 'selected' : ''}>Bị khóa</option>
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <button class="btn btn-primary w-100" type="submit">Lọc</button>
                                </div>
                            </form>
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered align-middle">
                                    <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Họ và tên</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <c:forEach var="user" items="${users}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${user.fullname}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.userPhone}</td>
                                                    <td>${user.role}</td>
                                                    <td>
                                                        <span class="badge ${user.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">
                                                            ${user.status == 'ACTIVE' ? 'Hoạt động' : 'Bị khóa'}
                                                        </span>
                                                    </td>
                                                    <td><fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                    <td>
                                                        <div class="d-flex gap-2">
                                                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#viewUserModal_${user.id}"><i class="bi bi-eye"></i></button>
                                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#editUserModal_${user.id}"><i class="bi bi-pencil-fill"></i></button>
                                                            <button class="btn btn-sm btn-danger" data-bs-toggle="modal" data-bs-target="#deleteUserModal_${user.id}"><i class="bi bi-trash3"></i></button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center text-danger fw-bold">Không có người dùng</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not empty users}">
                                <c:forEach var="user" items="${users}">
                                    <%-- Có thể include các modal view/edit/delete user ở đây nếu cần --%>
                                </c:forEach>
                            </c:if>
                            <c:if test="${totalPages > 0}">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        Bạn đang xem trang ${currentPage} trên ${totalPages} trang
                                    </div>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-end">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="?page=${currentPage - 1}&size=${param.size}${not empty searchName ? '&searchName='.concat(searchName) : ''}${not empty searchRole ? '&searchRole='.concat(searchRole) : ''}${not empty searchStatus ? '&searchStatus='.concat(searchStatus) : ''}">Trước</a>
                                            </li>
                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="?page=${i}&size=${param.size}${not empty searchName ? '&searchName='.concat(searchName) : ''}${not empty searchRole ? '&searchRole='.concat(searchRole) : ''}${not empty searchStatus ? '&searchStatus='.concat(searchStatus) : ''}">${i}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="?page=${currentPage + 1}&size=${param.size}${not empty searchName ? '&searchName='.concat(searchName) : ''}${not empty searchRole ? '&searchRole='.concat(searchRole) : ''}${not empty searchStatus ? '&searchStatus='.concat(searchStatus) : ''}">Sau</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<!-- End #main -->


<!-- ======= Footer ======= -->
<jsp:include page="layout/footer.jsp"/>
<!-- End Footer -->


<a
        href="#"
        class="back-to-top d-flex align-items-center justify-content-center"
><i class="bi bi-arrow-up-short"></i
></a>

<!-- Nút mở Modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
    Thêm người dùng mới
</button>

<!-- Modal thêm người dùng -->

<%--Modal delete người dùng--%>
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel">Xác nhận xoá</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xoá?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Huỷ</button>
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Xoá</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="userDetailsModal" tabindex="-1" aria-labelledby="userDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content border border-2 border-primary rounded">
            <div class="modal-header">
                <h5 class="modal-title" id="userDetailsModalLabel">Thông tin người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="user-details p-3">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <th scope="row" class="col-md-4">ID:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userId"></span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="col-md-4">Tên đầy đủ:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userFullname"></span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="col-md-4">Email:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userEmail"></span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="col-md-4">Số điện thoại:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userUserPhone"></span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="col-md-4">Vai trò:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userRole"></span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="col-md-4">Trạng thái:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userStatusText"></span></td>
                        </tr>
                        <tr>
                            <th scope="row" class="col-md-4">Ngày tạo:</th>
                            <td class="col-md-8"><span class="form-control-plaintext text-secondary fw-bold" id="userCreatedDate"></span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="userEditModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userEditModalLabel">Chỉnh sửa thông tin người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <%--            <form:form class="form-horizontal" role="form" id="editUserForm">--%>
                    <input type="hidden" id="edituserId">
                    <div class="mb-3">
                        <label for="edituserFullname" class="form-label">Tên đầy đủ</label>
                        <input type="text" class="form-control" id="edituserFullname" required>
                    </div>
                    <div class="mb-3">
                        <label for="edituserEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="edituserEmail" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="edituserPhone" class="form-label">Số điện thoại</label>
                        <input type="tel" class="form-control" id="edituserPhone" required>
                    </div>
                    <div class="mb-3">
                        <label for="edituserRole" class="form-label">Vai trò</label>
                        <%--                        <input type="text" class="form-control" id="edituserRole" required>--%>
                        <select class="form-select" id="edituserRole" required>
                            <option value="ADMIN">ADMIN</option>
                            <option value="USER">USER</option>
                            <option value="EDITOR">EDITOR</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="edituserStatus" class="form-label">Trạng thái</label>
                        <select class="form-select" id="edituserStatus" required>
                            <option value="ACTIVE">ACTIVE</option>
                            <option value="LOCKED">LOCKED</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="edituserCreatedDate" class="form-label">Ngày tạo</label>
                        <input type="text" class="form-control" id="edituserCreatedDate" readonly>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="updateUserButton" onclick="updateUser()">Cập nhật</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <form action="/admin/user" method="post" id="adduserform">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Thêm người dùng mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="fullname" class="form-label">Họ và tên</label>
                        <input id="fullname" type="text" class="form-control" name="fullname" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="userPhone" class="form-label">Số điện thoại</label>
                        <input id="userPhone" type="text" class="form-control" name="userPhone" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" required autocomplete="current-password">
                    </div>
                    <div class="mb-3">
                        <label for="role" class="form-label">Vai trò</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="ADMIN">Admin</option>
                            <option value="EDITOR">Editor</option>
                            <option value="USER">User</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="ACTIVE">ACTIVE</option>
                            <option value="LOCKED">LOCKED</option>
                        </select>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="submit" class="btn btn-primary" id="adduser">Lưu</button>
            </div>

        </div>
    </div>
</div>

<!-- Template Main JS File -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script>
    document.getElementById("openModalBtn").addEventListener("click", function () {
        var myModal = new bootstrap.Modal(document.getElementById("addUserModal"));
        myModal.show();
    });

    // Fix delete user modal
    document.querySelectorAll(".btn-delete-user").forEach(button => {
        button.addEventListener("click", function () {
            const userId = this.getAttribute("data-id");
            const confirmDelModal = new bootstrap.Modal(document.getElementById("confirmDeleteModal"));
            confirmDelModal.show();

            // Xử lý sự kiện cho nút xóa
            const deleteButton = document.querySelector("#confirmDeleteModal .btn-danger");
            deleteButton.onclick = function() {
                deleteUser(userId);
                confirmDelModal.hide();
            };

            // Xử lý sự kiện cho nút huỷ
            const cancelButton = document.querySelector("#confirmDeleteModal .btn-secondary");
            cancelButton.onclick = function() {
                confirmDelModal.hide();
            };
        });
    });

    // Fix details user modal
    function detailsUser(id, fullname, email, userPhone, role, status, createdDate) {
        try {
            // Format date
            const formattedDate = createdDate ? new Date(createdDate).toLocaleDateString('vi-VN') : 'Không có';

            // Update modal content
            document.getElementById('userId').textContent = id || 'Không có';
            document.getElementById('userFullname').textContent = fullname || 'Không có';
            document.getElementById('userEmail').textContent = email || 'Không có';
            document.getElementById('userUserPhone').textContent = userPhone || 'Không có';
            document.getElementById('userRole').textContent = role || 'Không có';
            document.getElementById('userStatusText').textContent = status == 'ACTIVE' ? 'Hoạt động' : 'Bị khóa';
            document.getElementById('userCreatedDate').textContent = formattedDate;

            // Show modal
            const userDetailsModal = new bootstrap.Modal(document.getElementById('userDetailsModal'));
            userDetailsModal.show();
        } catch (error) {
            console.error('Lỗi khi hiển thị modal:', error);
            alert('Có lỗi xảy ra khi hiển thị thông tin người dùng');
        }
    }

    function editUser(id, fullname, email, userPhone, role, status, createdDate) {
        try {
            // Format date
            const formattedDate = createdDate ? new Date(createdDate).toLocaleDateString('vi-VN') : 'Không có';

            // Update modal content
            document.getElementById('edituserId').value = id || '';
            document.getElementById('edituserFullname').value = fullname || '';
            document.getElementById('edituserEmail').value = email || '';
            document.getElementById('edituserPhone').value = userPhone || '';
            document.getElementById('edituserRole').value = role || '';
            document.getElementById('edituserStatus').value = status.toUpperCase() || 'ACTIVE';
            document.getElementById('edituserCreatedDate').value = formattedDate;

            // Show modal using Bootstrap 5 syntax
            const editUserModal = new bootstrap.Modal(document.getElementById('editUserModal'));
            editUserModal.show();
        } catch (error) {
            console.error('Lỗi khi hiển thị modal chỉnh sửa:', error);
            alert('Có lỗi xảy ra khi hiển thị thông tin người dùng');
        }
    }

    $("#updateUserButton").click(function () {
        var json = {
            id: $("#edituserId").val(),
            fullname: $("#edituserFullname").val(),
            email: $("#edituserEmail").val(),
            userPhone: $("#edituserPhone").val(),
            role: $("#edituserRole").val(),
            status: $("#edituserStatus").val()
        };

        // Kiểm tra dữ liệu trước khi gửi
        if (!json.id || !json.fullname || !json.email || !json.userPhone || !json.role || !json.status) {
            alert("Vui lòng điền đầy đủ thông tin");
            return;
        }
        updateUser(json);
    });

    // Sửa hàm updateUser
    function updateUser(json) {
        $.ajax({
            type: "PUT",
            url: "/admin/user/" + json.id, // Sửa URL để thêm ID
            data: JSON.stringify(json),
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                console.log("Response:", response);
                if (response.message === "Success") {
                    alert("Cập nhật người dùng thành công");
                    window.location.href = "/view/admin/user";
                } else {
                    alert("Cập nhật người dùng thất bại: " + (response.message || "Lỗi không xác định"));
                    window.location.href = "/view/admin/user";
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                console.error("Response:", xhr.responseText);
                let errorMessage = xhr.responseJSON?.message || xhr.responseText || error;
                alert("Cập nhật người dùng thất bại: " + errorMessage);
                window.location.href = "/view/admin/user";
            }
        });
    }

    $("#adduser").click(function () {
        var formData = $("#adduserform").serializeArray();
        var json = {};
        $.each(formData, function (i, it) {
            json["" + it.name + ""] = it.value;
        });

        $.ajax({
            type: "POST",
            url: "/admin/user",
            data: JSON.stringify(json),
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
                console.log("Response:", response);
                if (response.message === "Success") {
                    alert("Thêm người dùng thành công");
                    window.location.href = "/view/admin/user";
                } else {
                    alert("Thêm người dùng thất bại: " + (response.message || JSON.stringify(response)));
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                console.error("Response:", xhr.responseText);
                let errorMessage = xhr.responseJSON?.message || xhr.responseText || error;
                alert(errorMessage);
            }
        });
    });

    function deleteUser(id) {
        $.ajax({
            type: "DELETE",
            url: "/admin/user/"+id,
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                console.log("Response:", response);
                if (response.message === "Success") {
                    alert("Xoá người dùng thành công");
                    window.location.href = "/view/admin/user";
                } else {
                    alert("Xoá người dùng thất bại: " + (response.message || JSON.stringify(response)));
                    window.location.href = "/view/admin/user";
                }
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                console.error("Response:", xhr.responseText);
                alert("Xoá người dùng thất bại: " + (xhr.responseText || error));
                window.location.href = "/view/admin/user";
            }
        });

    }

    $("#findUser").click(function (e){
        e.preventDefault();
        $("#searchForm").submit();
    });

    $("#xuatex").click(function (e){
        e.preventDefault();
        var searchName = $("input[name='searchName']").val();
        var searchRole = $("select[name='searchRole']").val();
        var searchStatus = $("select[name='searchStatus']").val();

        var url = "${pageContext.request.contextPath}/admin/user/export";
        url += "?searchName=" + searchName;
        url += "&searchRole=" + searchRole;
        url += "&searchStatus=" + searchStatus;

        window.location.href = url;
    });


</script>
</body>
</html>