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
<jsp:include page="header.jsp"/>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<jsp:include page="sidebar.jsp"/>
<!-- End Sidebar-->

<!-- Main hearing -->
<main id="main" class="main">
    <div class="pagetitle d-flex justify-content-between">
        <h1>User</h1>
        <nav>
            <ol class="breadcrumb d-flex">
                <li class="breadcrumb-item ms-auto">
                    <a href="/view/admin/dashboard"><i class="bi bi-house"></i></a>
                </li>
                <li class="breadcrumb-item active">User</li>
            </ol>
        </nav>
    </div>
    <!-- End Page Title -->
    <div class="container-fluid mt-4">
        <!-- Header: Tiêu đề + Thêm mới -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="mb-0">Danh sách người dùng</h4>
            <div>
                <a href="${pageContext.request.contextPath}/admin/user/export" class="btn btn-info me-2" id="xuatex">
                    <i class="bi bi-file-excel"></i> Xuất Excel
                </a>
                <a href="#" class="btn btn-success" id="openModalBtn">+ Thêm mới</a>
            </div>
        </div>

        <!-- Search & Filter -->
        <%--@elvariable id="searchRequest" type="com.example.balo_center.domain.request.SearchRequest"--%>
        <form:form class="row g-3 mb-4" id="searchForm" method="GET" action="/view/admin/user" modelAttribute="searchRequest" >
            <div class="col-md-4">
                <form:input type="text" class="form-control" placeholder="Tìm theo tên..." onChange="this.form.submit()" path="searchName"/>
            </div>
            <div class="col-md-3">
                <form:select class="form-select" path="searchRole" onChange="this.form.submit()">
                    <form:option value="">-- Vai trò --</form:option>
                    <form:option value="ADMIN">Admin</form:option>
                    <form:option value="EDITOR">Editor</form:option>
                    <form:option value="USER">User</form:option>
                </form:select>
            </div>
            <div class="col-md-3">
                <form:select class="form-select" path="searchStatus" onChange="this.form.submit()">
                    <form:option value="">-- Trạng thái --</form:option>
                    <form:option value="ACTIVE">Hoạt động</form:option>
                    <form:option value="LOCKED">Bị khóa</form:option>
                </form:select>
            </div>
            <div class="col-md-1">
                <button class="btn btn-primary w-100" id="findUser">Lọc</button>
            </div>
        </form:form>

        <div class="card shadow-sm p-3 mb-5 bg-body rounded">
            <table class="table table-hover table-bordered mt-3">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col" style="width: 5%;">ID</th>
                    <th scope="col" style="width: 15%;">Họ và tên</th>
                    <th scope="col" style="width: 15%;">Email</th>
                    <th scope="col" style="width: 10%;">Số điện thoại</th>
                    <th scope="col" style="width: 8%;">Vai trò</th>
                    <th scope="col">Trạng thái</th>
                    <th scope="col">Ngày tạo</th>
                    <th scope="col" style="width: 12%;">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="9" class="text-center text-danger fw-bold">Không có người dùng nào</td>
                    </tr>
                </c:if>
                <c:forEach var="user" items="${users}" varStatus="loop">
                    <tr>
                        <th scope="row">${loop.index + 1 + (searchRequest.page * searchRequest.size)}</th>
                        <td style="width: 5%;">${user.id}</td>
                        <td style="width: 15%;">${user.fullname}</td>
                        <td style="width: 15%;">${user.email}</td>
                        <td style="width: 10%;">${user.userPhone}</td>
                        <td style="width: 8%;">${user.role}</td>
                        <td>
                            <span class="badge ${user.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'}">
                                    ${user.status == 'ACTIVE' ? 'Hoạt động' : 'Bị khóa'}
                            </span>
                        </td>
                        <td><fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td style="width: 12%;">
                            <button class="btn btn-sm btn-primary me-1" onclick="detailsUser(
                                    '${user.id}',
                                    '${user.fullname}',
                                    '${user.email}',
                                    '${user.userPhone}',
                                    '${user.role}',
                                    '${user.status}',
                                    '${user.createdDate}'
                                    )"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                            </svg></button>
                            <button class="btn btn-sm btn-warning me-1" onclick="editUser(
                                    '${user.id}',
                                    '${user.fullname}',
                                    '${user.email}',
                                    '${user.userPhone}',
                                    '${user.role}',
                                    '${user.status}',
                                    '${user.createdDate}'
                                    )"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                                <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.5.5 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11z"/>
                            </svg></button>
                            <button class="btn btn-sm btn-danger btn-delete-user" data-id="${user.id}"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3-fill" viewBox="0 0 16 16">
                                <path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>
                            </svg></button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage > 0 ? currentPage - 1 : 0}&size=${searchRequest.size}&searchName=${searchRequest.searchName}&searchRole=${searchRequest.searchRole}&searchStatus=${searchRequest.searchStatus}">Trước</a>
                </li>
                <c:if test="${totalPages > 0}">
                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&size=${searchRequest.size}&searchName=${searchRequest.searchName}&searchRole=${searchRequest.searchRole}&searchStatus=${searchRequest.searchStatus}">${i + 1}</a>
                        </li>
                    </c:forEach>
                </c:if>
                <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}&size=${searchRequest.size}&searchName=${searchRequest.searchName}&searchRole=${searchRequest.searchRole}&searchStatus=${searchRequest.searchStatus}">Sau</a>
                </li>
            </ul>
        </nav>
        <p class="mt-3">
            Bạn đang xem trang ${currentPage + 1} trên ${totalPages} trang
        </p>
    </div>


</main>
<!-- End #main -->


<!-- ======= Footer ======= -->
<jsp:include page="footer.jsp"/>
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