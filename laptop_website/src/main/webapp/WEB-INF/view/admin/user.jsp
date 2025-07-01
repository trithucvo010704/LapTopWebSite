<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

          <!DOCTYPE html>
          <html lang="en">

          <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />

            <title>User Page</title>
            <meta content="" name="description" />
            <meta content="" name="keywords" />

            <!-- Favicons -->
            <link href="assets/img/favicon.png" rel="icon" />
            <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon" />

            <!-- Google Fonts -->
            <link href="https://fonts.gstatic.com" rel="preconnect" />
            <link
              href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
              rel="stylesheet" />

            <!-- Vendor CSS Files -->
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap.min.css"
              rel="stylesheet" type="text/css" />
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap-icons.css"
              rel="stylesheet" type="text/css" />
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/css/boxicons.min.css"
              rel="stylesheet" type="text/css" />
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.snow.css"
              rel="stylesheet" type="text/css" />
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.bubble.css"
              rel="stylesheet" type="text/css" />
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/remixicon/remixicon.css"
              rel="stylesheet" type="text/css" />
            <link href="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/style.css"
              rel="stylesheet" type="text/css" />

            <!-- Template Main CSS File -->
            <link href="${pageContext.request.contextPath}/resources/assets/css/style.css" rel="stylesheet" />

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
                padding: 20px 0 !important;
                margin-top: 20px;
              }

              #main {
                padding-bottom: 80px;
              }

              .table-bordered th,
              .table-bordered td {
                border: 1px solid #dee2e6 !important;
              }

              .d-none {
                display: none !important;
              }
            </style>
          </head>

          <body>
            <!-- ======= Header ======= -->
            <jsp:include page="layout/header.jsp" />
            <!-- End Header -->

            <!-- ======= Sidebar ======= -->
            <jsp:include page="layout/sidebar.jsp" />
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
                                  <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast" aria-label="Close"></button>
                                </div>
                              </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                              <div class="toast align-items-center text-white bg-danger border-0" role="alert"
                                aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
                                <div class="d-flex">
                                  <div class="toast-body">${errorMessage}</div>
                                  <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast" aria-label="Close"></button>
                                </div>
                              </div>
                            </c:if>
                          </div>
                          <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0">Danh sách người dùng</h4>
                          </div>

                          <!-- AJAX Search and Filter Form -->
                          <div class="row g-3 mb-4 align-items-end">
                            <div class="col-md-3">
                              <input type="text" class="form-control" placeholder="Tìm theo tên..." name="searchName"
                                id="searchNameInput" />
                            </div>
                            <div class="col-md-2">
                              <select class="form-select" name="searchRole" id="searchRoleSelect">
                                <option value="">-- Vai trò --</option>
                                <option value="ADMIN">Quản trị viên</option>
                                <option value="EDITOR">Biên tập viên</option>
                                <option value="USER">Người dùng</option>
                              </select>
                            </div>
                            <div class="col-md-2">
                              <select class="form-select" name="searchStatus" id="searchStatusSelect">
                                <option value="">-- Trạng thái --</option>
                                <option value="ACTIVE">Hoạt động</option>
                                <option value="LOCKED">Bị khóa</option>
                                <option value="INACTIVE">Không hoạt động</option>
                              </select>
                            </div>
                            <div class="col-md-2">
                              <select class="form-select" name="sortBy" id="sortBySelect">
                                <option value="">-- Sắp xếp --</option>
                                <option value="createdAt">Ngày tạo</option>
                                <option value="fullname">Tên (A-Z)</option>
                                <option value="email">Email</option>
                                <option value="role">Vai trò</option>
                              </select>
                            </div>
                            <div class="col-md-2">
                              <select class="form-select" name="size" id="sizeSelect">
                                <option value="5">5 người dùng/trang</option>
                                <option value="10">10 người dùng/trang</option>
                                <option value="20">20 người dùng/trang</option>
                                <option value="50">50 người dùng/trang</option>
                              </select>
                            </div>
                          </div>

                          <!-- Loading indicator -->
                          <div id="loadingIndicator" class="text-center d-none">
                            <div class="spinner-border text-primary" role="status">
                              <span class="visually-hidden">Đang tải...</span>
                            </div>
                          </div>

                          <!-- Users Table -->
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
                                <!-- Users will be loaded dynamically via AJAX -->
                              </tbody>
                            </table>
                          </div>

                          <!-- Pagination -->
                          <div class="pagination-container">
                            <!-- Pagination will be rendered dynamically -->
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </section>
            </main>
            <!-- End #main -->

            <!-- ======= Footer ======= -->
            <jsp:include page="layout/footer.jsp" />
            <!-- End Footer -->

            <a href="#" class="back-to-top d-flex align-items-center justify-content-center">
              <i class="bi bi-arrow-up-short"></i>
            </a>
            <!-- Include modals for view, edit, delete -->
            <div id="userModals">
              <!-- Modals will be dynamically generated -->
            </div>

            <!-- Template Main JS File -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
            <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

            <!-- User AJAX Handler -->
            <script src="${pageContext.request.contextPath}/resources/assets/js/user-ajax.js"></script>

            <!-- Modal View User (moved from crud_user/view_user.jsp) -->
            <div class="modal fade" id="viewUserModal_${user.id}" tabindex="-1"
              aria-labelledby="viewUserModalLabel_${user.id}" aria-hidden="true">
              <div class="modal-dialog modal-lg">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="viewUserModalLabel_${user.id}">
                      Thông tin chi tiết người dùng
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Họ và tên:</label>
                      <div class="col-sm-9">
                        <p class="form-control-plaintext" id="view_fullname_${user.id}">
                          ${user.fullname}
                        </p>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Email:</label>
                      <div class="col-sm-9">
                        <p class="form-control-plaintext" id="view_email_${user.id}">
                          ${user.email}
                        </p>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Số điện thoại:</label>
                      <div class="col-sm-9">
                        <p class="form-control-plaintext" id="view_userPhone_${user.id}">
                          ${user.userPhone}
                        </p>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Địa chỉ:</label>
                      <div class="col-sm-9">
                        <p class="form-control-plaintext" id="view_address_${user.id}">
                          ${user.address}
                        </p>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Vai trò:</label>
                      <div class="col-sm-9">
                        <span
                          class="badge bg-${user.role == 'ADMIN' ? 'danger' : user.role == 'EDITOR' ? 'warning' : 'info'}"
                          id="view_role_${user.id}">${user.role == 'ADMIN' ? 'Quản trị viên' : user.role ==
                          'EDITOR' ? 'Biên tập viên' : 'Người dùng'}</span>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Trạng thái:</label>
                      <div class="col-sm-9">
                        <span
                          class="badge bg-${user.status == 'ACTIVE' ? 'success' : user.status == 'LOCKED' ? 'danger' : 'secondary'}"
                          id="view_status_${user.id}">${user.status == 'ACTIVE' ? 'Hoạt động' : user.status ==
                          'LOCKED' ? 'Bị khóa' : 'Không hoạt động'}</span>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Ngày tạo:</label>
                      <div class="col-sm-9">
                        <p class="form-control-plaintext" id="view_createdAt_${user.id}">
                          <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                        </p>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label fw-bold">Ngày cập nhật:</label>
                      <div class="col-sm-9">
                        <p class="form-control-plaintext" id="view_updatedAt_${user.id}">
                          <fmt:formatDate value="${user.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                      Đóng
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <jsp:include page="crud_user/add_user.jsp" />
            <jsp:include page="crud_user/edit_user.jsp" />
            <jsp:include page="crud_user/delete_user.jsp" />
            <jsp:include page="crud_user/user_detail.jsp" />
          </body>

          </html>