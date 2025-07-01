<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ page
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Product Page</title>
    <meta content="" name="description" />
    <meta content="" name="keywords" />

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon" />
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon" />

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect" />
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />
    <!-- Vendor CSS Files -->
    <link
      href="${pageContext.request.contextPath}/resources/assets/vendor/css/bootstrap.min.css"
      rel="stylesheet"
    />
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
    <link
      href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"
      rel="stylesheet"
    />

    <!-- Template Main CSS File -->
    <link
      href="${pageContext.request.contextPath}/resources/assets/css/style.css"
      rel="stylesheet"
    />

    <style>
      .ui-autocomplete {
        max-height: 200px;
        overflow-y: auto;
        overflow-x: hidden;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 4px;
        z-index: 1000;
      }

      .ui-autocomplete .ui-menu-item {
        padding: 8px 12px;
        cursor: pointer;
      }

      .ui-autocomplete .ui-menu-item:hover {
        background-color: #f8f9fa;
      }

      .ui-autocomplete .ui-menu-item .product-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .ui-autocomplete .ui-menu-item .product-details {
        font-size: 0.9em;
        color: #666;
      }
    </style>

    <!-- =======================================================
* Template Name: NiceAdmin
* Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
* Updated: Apr 20 2024 with Bootstrap v5.3.3
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
======================================================== -->
  </head>

  <body>
    <div class="wrapper">
      <jsp:include page="layout/header.jsp" />

      <jsp:include page="layout/sidebar.jsp" />

      <main id="main" class="main">
        <div
          class="pagetitle d-flex justify-content-between align-items-center"
        >
          <div>
            <h1>Quản lý sản phẩm</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item">
                  <a href="dashboard">Dashboard</a>
                </li>
                <li class="breadcrumb-item active">Sản phẩm</li>
              </ol>
            </nav>
          </div>
          <div>
            <button
              class="btn btn-success"
              data-bs-toggle="modal"
              data-bs-target="#addProductModal"
            >
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
                        <div
                          class="toast align-items-center text-white bg-success border-0"
                          role="alert"
                          aria-live="assertive"
                          aria-atomic="true"
                          data-bs-autohide="true"
                          data-bs-delay="3000"
                        >
                          <div class="d-flex">
                            <div class="toast-body">${successMessage}</div>
                            <button
                              type="button"
                              class="btn-close btn-close-white me-2 m-auto"
                              data-bs-dismiss="toast"
                              aria-label="Close"
                            ></button>
                          </div>
                        </div>
                      </c:if>
                      <c:if test="${not empty errorMessage}">
                        <div
                          class="toast align-items-center text-white bg-danger border-0"
                          role="alert"
                          aria-live="assertive"
                          aria-atomic="true"
                          data-bs-autohide="true"
                          data-bs-delay="3000"
                        >
                          <div class="d-flex">
                            <div class="toast-body">${errorMessage}</div>
                            <button
                              type="button"
                              class="btn-close btn-close-white me-2 m-auto"
                              data-bs-dismiss="toast"
                              aria-label="Close"
                            ></button>
                          </div>
                        </div>
                      </c:if>
                    </div>
                    <div
                      class="d-flex justify-content-between align-items-center mb-3"
                    >
                      <h4 class="mb-0">Danh sách sản phẩm</h4>
                    </div>

                    <!-- AJAX Search and Filter Form -->
                    <div class="row g-3 mb-4">
                      <div class="col-md">
                        <input
                          type="text"
                          class="form-control"
                          id="searchInput"
                          placeholder="Tìm theo tên..."
                        />
                      </div>
                      <div class="col-md">
                        <select
                          class="form-select"
                          name="brand"
                          id="brandFilter"
                        >
                          <option value="">-- Tất cả hãng --</option>
                          <c:forEach var="brand" items="${brands}">
                            <option value="${brand.branchName}">
                              ${brand.branchName}
                            </option>
                          </c:forEach>
                        </select>
                      </div>
                      <div class="col-md">
                        <select
                          class="form-select"
                          name="category"
                          id="categoryFilter"
                        >
                          <option value="">-- Tất cả danh mục --</option>
                          <c:forEach var="category" items="${categories}">
                            <option value="${category.name}">
                              ${category.name}
                            </option>
                          </c:forEach>
                        </select>
                      </div>
                      <div class="col-md">
                        <select
                          class="form-select"
                          name="sortBy"
                          id="sortByFilter"
                        >
                          <option value="">-- Sắp xếp --</option>
                          <option value="priceAsc">Giá: Tăng dần</option>
                          <option value="priceDesc">Giá: Giảm dần</option>
                          <option value="soldAsc">Đã bán: Tăng dần</option>
                          <option value="soldDesc">Đã bán: Giảm dần</option>
                        </select>
                      </div>
                      <div class="col-md">
                        <select class="form-select" name="size" id="sizeFilter">
                          <option value="10">10 sản phẩm/trang</option>
                          <option value="5">5 sản phẩm/trang</option>
                          <option value="20">20 sản phẩm/trang</option>
                          <option value="50">50 sản phẩm/trang</option>
                        </select>
                      </div>
                    </div>

                    <!-- Loading indicator -->
                    <div id="loadingIndicator" class="text-center d-none">
                      <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Đang tải...</span>
                      </div>
                    </div>

                    <!-- Products Table -->
                    <div class="table-responsive">
                      <table
                        class="table table-hover table-bordered align-middle"
                      >
                        <thead class="table-light">
                          <tr>
                            <th>#</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Thương hiệu</th>
                            <th>Số lượng</th>
                            <th>Đã bán</th>
                            <th>Giá</th>
                            <th>Thao tác</th>
                          </tr>
                        </thead>
                        <tbody>
                          <!-- Products will be loaded dynamically via AJAX -->
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

      <jsp:include page="layout/footer.jsp" />
    </div>
    <a
      href="#"
      class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>


    <jsp:include page="crud_product/create_product.jsp" />
    <jsp:include page="crud_product/edit_product.jsp" />
    <jsp:include page="crud_product/delete_product.jsp" />
    <jsp:include page="crud_product/import_file.jsp" />
    <jsp:include page="crud_product/product_detail.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

    <!-- Template Main JS File -->
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

    <!-- Product AJAX Handler -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/product-ajax.js"></script>

    <script>
      $(document).ready(function () {
        // Initialize autocomplete for search input
        $("#searchInput")
          .autocomplete({
            source: function (request, response) {
              $.ajax({
                url: "${pageContext.request.contextPath}/api/products/search-suggestions",
                dataType: "json",
                data: {
                  term: request.term,
                },
                success: function (data) {
                  response(data);
                },
              });
            },
            minLength: 2,
            select: function (event, ui) {
              $("#searchInput").val(ui.item.value);
              return false;
            },
          })
          .autocomplete("instance")._renderItem = function (ul, item) {
          return $("<li>")
            .append(
              "<div class='product-info'>" +
                "<div>" +
                "<strong>" +
                item.label +
                "</strong><br>" +
                "<span class='product-details'>" +
                "Danh mục: " +
                item.category +
                " | " +
                "Hãng: " +
                item.brand +
                " | " +
                "Giá: " +
                item.price +
                " VND" +
                "</span>" +
                "</div>" +
                "</div>"
            )
            .appendTo(ul);
        };
      });
    </script>

    <style>
      footer {
        position: fixed;
        bottom: 0;
        padding: 20px 0 !important;
        display: block;
        width: 90% !important;
      }

      .d-none {
        display: none !important;
      }
    </style>
  </body>
</html>
