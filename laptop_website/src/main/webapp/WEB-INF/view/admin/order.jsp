<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Quản lý đơn hàng</title>

    <!-- Favicons -->
    <link
      href="${pageContext.request.contextPath}/resources/assets/img/favicon.png"
      rel="icon"
    />
    <link
      href="${pageContext.request.contextPath}/resources/assets/img/apple-touch-icon.png"
      rel="apple-touch-icon"
    />

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect" />
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />

    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/css/boxicons.min.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.snow.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.bubble.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/remixicon/remixicon.css"
      rel="stylesheet"
    />
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/style.css"
      rel="stylesheet"
    />

    <!-- Template Main CSS File -->
    <link
      href="${pageContext.request.contextPath}/resources/assets/css/style.css"
      rel="stylesheet"
    />

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
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
      .toast-container {
        z-index: 9999;
      }
      .loading-spinner {
        display: inline-block;
        width: 20px;
        height: 20px;
        border: 3px solid #f3f3f3;
        border-top: 3px solid #3498db;
        border-radius: 50%;
        animation: spin 1s linear infinite;
      }
      @keyframes spin {
        0% {
          transform: rotate(0deg);
        }
        100% {
          transform: rotate(360deg);
        }
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
        <div>
          <button class="btn btn-success" onclick="orderHandler.exportOrders()">
            <i class="bi bi-file-earmark-excel me-1"></i> Xuất Excel
          </button>
        </div>
      </div>

      <section class="section">
        <div class="row">
          <div class="col-12">
            <!-- Orders Table -->
            <div class="card">
              <div class="card-body">
                <div class="container-fluid mt-4">
                  <!-- Toast Container -->
                  <div
                    class="toast-container position-fixed top-0 end-0 p-3"
                  ></div>

                  <!-- Header: Tiêu đề  -->
                  <div
                    class="d-flex justify-content-between align-items-center mb-3"
                  >
                    <h4 class="mb-0">Danh sách đơn hàng</h4>
                  </div>

                  <!-- Search & Filter Section -->
                  <div class="filter-section">
                    <div class="row g-3">
                      <div class="col-md-3">
                        <label for="searchOrderCodeInput" class="form-label"
                          >Mã đơn hàng</label
                        >
                        <input
                          type="text"
                          class="form-control"
                          id="searchOrderCodeInput"
                          placeholder="Tìm theo mã đơn hàng..."
                        />
                      </div>
                      <div class="col-md-3">
                        <label for="searchReceiverNameInput" class="form-label"
                          >Tên người nhận</label
                        >
                        <input
                          type="text"
                          class="form-control"
                          id="searchReceiverNameInput"
                          placeholder="Tìm theo tên người nhận..."
                        />
                      </div>
                      <div class="col-md-2">
                        <label for="searchStatusSelect" class="form-label"
                          >Trạng thái</label
                        >
                        <select class="form-select" id="searchStatusSelect">
                          <option value="">Tất cả trạng thái</option>
                          <option value="PENDING">Chờ xử lý</option>
                          <option value="CONFIRMED">Đã xác nhận</option>
                          <option value="PROCESSING">Đang xử lý</option>
                          <option value="SHIPPING">Đang giao hàng</option>
                          <option value="DELIVERED">Đã giao hàng</option>
                          <option value="CANCELLED">Đã hủy</option>
                          <option value="RETURNED">Đã trả hàng</option>
                        </select>
                      </div>
                      <div class="col-md-2">
                        <label
                          for="searchPaymentStatusSelect"
                          class="form-label"
                          >Thanh toán</label
                        >
                        <select
                          class="form-select"
                          id="searchPaymentStatusSelect"
                        >
                          <option value="">Tất cả thanh toán</option>
                          <option value="PENDING">Chờ thanh toán</option>
                          <option value="PAID">Đã thanh toán</option>
                          <option value="FAILED">Thanh toán thất bại</option>
                          <option value="REFUNDED">Đã hoàn tiền</option>
                        </select>
                      </div>
                      <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <div class="d-grid">
                          <button
                            class="btn btn-outline-secondary"
                            onclick="orderHandler.resetFilters()"
                          >
                            <i class="bi bi-arrow-clockwise"></i> Làm mới
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- Loading Indicator -->
                  <div id="loadingIndicator" class="text-center py-4 d-none">
                    <div class="loading-spinner"></div>
                    <p class="mt-2">Đang tải dữ liệu...</p>
                  </div>

                  <!-- Table -->
                  <div class="table-responsive">
                    <table
                      class="table table-hover table-bordered align-middle"
                    >
                      <thead class="table-light">
                        <tr>
                          <th>#</th>
                          <th>Mã đơn hàng</th>
                          <th>Người nhận</th>
                          <th>Số điện thoại</th>
                          <th>Tổng tiền</th>
                          <th>Trạng thái</th>
                          <th>Thanh toán</th>
                          <th>Ngày tạo</th>
                          <th>Thao tác</th>
                        </tr>
                      </thead>
                      <tbody>
                        <!-- Data will be loaded via AJAX -->
                      </tbody>
                    </table>
                  </div>

                  <!-- Pagination -->
                  <div class="pagination-container mt-4">
                    <!-- Pagination will be loaded via AJAX -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- ======= Footer ======= -->
    <jsp:include page="layout/footer.jsp" />
    <!-- End Footer-->

    <jsp:include page="crud_order/delete_order.jsp" />
    <jsp:include page="crud_order/order_detail.jsp" />
    <jsp:include page="crud_order/update_status.jsp" />

    <!-- Vendor JS Files -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/chart.js/chart.umd.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/echarts/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>

    <!-- Order AJAX Handler -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/order-ajax.js"></script>
  </body>
</html>
