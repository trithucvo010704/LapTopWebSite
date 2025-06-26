<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Dashboard - NiceAdmin Bootstrap Template</title>
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

    <!-- Template Main CSS File -->
    <link
      href="${pageContext.request.contextPath}/resources/assets/css/style.css"
      rel="stylesheet"
    />

    <!-- =======================================================
* Template Name: NiceAdmin
* Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
* Updated: Apr 20 2024 with Bootstrap v5.3.3
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
======================================================== -->
  </head>

  <body>
    <!-- ======= Header ======= -->
    <jsp:include page="header.jsp" />
    <!-- End Header -->

    <!-- ======= Sidebar ======= -->
    <jsp:include page="sidebar.jsp" />
    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle d-flex justify-content-between">
        <h1>Dashboard</h1>
        <nav>
          <ol class="breadcrumb d-flex">
            <li class="breadcrumb-item ms-auto">
              <a href="/view/admin/dashboard"><i class="bi bi-house"></i></a>
            </li>
            <li class="breadcrumb-item active">Dashboard</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section dashboard">
        <div class="row">
          <!-- Left side columns -->
          <div class="col-lg-12">
            <div class="row">
              <!-- Total Products Card -->
              <div class="col-xxl-3 col-md-6">
                <div class="card info-card sales-card">
                  <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown"
                      ><i class="bi bi-three-dots"></i
                    ></a>
                    <ul
                      class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                    >
                      <li class="dropdown-header text-start">
                        <h6>Filter</h6>
                      </li>

                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=today"
                          >Today</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=month"
                          >This Month</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=year"
                          >This Year</a
                        >
                      </li>
                    </ul>
                  </div>

                  <div class="card-body">
                    <h5 class="card-title">Tổng sản phẩm</h5>

                    <div class="d-flex align-items-center">
                      <div
                        class="card-icon rounded-circle d-flex align-items-center justify-content-center"
                      >
                        <i class="bi bi-box"></i>
                      </div>
                      <div class="ps-3">
                        <h6>${summary.totalProducts}</h6>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End Total Products Card -->

              <!-- Total Orders Card -->
              <div class="col-xxl-3 col-md-6">
                <div class="card info-card revenue-card">
                  <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown"
                      ><i class="bi bi-three-dots"></i
                    ></a>
                    <ul
                      class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                    >
                      <li class="dropdown-header text-start">
                        <h6>Filter</h6>
                      </li>

                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=today"
                          >Today</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=month"
                          >This Month</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=year"
                          >This Year</a
                        >
                      </li>
                    </ul>
                  </div>

                  <div class="card-body">
                    <h5 class="card-title">Tổng đơn hàng</h5>

                    <div class="d-flex align-items-center">
                      <div
                        class="card-icon rounded-circle d-flex align-items-center justify-content-center"
                      >
                        <i class="bi bi-cart"></i>
                      </div>
                      <div class="ps-3">
                        <h6>${summary.totalOrders}</h6>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End Total Orders Card -->

              <!-- Total Revenue Card -->
              <div class="col-xxl-3 col-md-6">
                <div class="card info-card revenue-card">
                  <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown"
                      ><i class="bi bi-three-dots"></i
                    ></a>
                    <ul
                      class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                    >
                      <li class="dropdown-header text-start">
                        <h6>Filter</h6>
                      </li>

                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=today"
                          >Today</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=month"
                          >This Month</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=year"
                          >This Year</a
                        >
                      </li>
                    </ul>
                  </div>

                  <div class="card-body">
                    <h5 class="card-title">Tổng doanh thu</h5>

                    <div class="d-flex align-items-center">
                      <div
                        class="card-icon rounded-circle d-flex align-items-center justify-content-center"
                      >
                        <i class="bi bi-currency-dollar"></i>
                      </div>
                      <div class="ps-3">
                        <h6>
                          <fmt:formatNumber
                            value="${summary.totalRevenue}"
                            pattern="#,##0"
                            currencySymbol="₫"
                          />
                        </h6>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End Total Revenue Card -->

              <!-- Total Users Card -->
              <div class="col-xxl-3 col-md-6">
                <div class="card info-card customers-card">
                  <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown"
                      ><i class="bi bi-three-dots"></i
                    ></a>
                    <ul
                      class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                    >
                      <li class="dropdown-header text-start">
                        <h6>Filter</h6>
                      </li>

                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=today"
                          >Today</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=month"
                          >This Month</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=year"
                          >This Year</a
                        >
                      </li>
                    </ul>
                  </div>

                  <div class="card-body">
                    <h5 class="card-title">Tổng người dùng</h5>

                    <div class="d-flex align-items-center">
                      <div
                        class="card-icon rounded-circle d-flex align-items-center justify-content-center"
                      >
                        <i class="bi bi-people"></i>
                      </div>
                      <div class="ps-3">
                        <h6>${summary.totalUsers}</h6>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <!-- End Total Users Card -->

              <!-- Reports -->
              <div class="col-12">
                <div class="card">
                  <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown"
                      ><i class="bi bi-three-dots"></i
                    ></a>
                    <ul
                      class="dropdown-menu dropdown-menu-end dropdown-menu-arrow"
                    >
                      <li class="dropdown-header text-start">
                        <h6>Filter</h6>
                      </li>

                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=today"
                          >Today</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=month"
                          >This Month</a
                        >
                      </li>
                      <li>
                        <a
                          class="dropdown-item"
                          href="${pageContext.request.contextPath}/view/admin/dashboard?filter=year"
                          >This Year</a
                        >
                      </li>
                    </ul>
                  </div>

                  <div class="card-body">
                    <h5 class="card-title">
                      Thống kê doanh thu theo trạng thái đơn hàng
                    </h5>

                    <!-- Donut Chart -->
                    <div
                      id="orderStatusChart"
                      style="max-height: 400px; min-height: 250px"
                    >
                      <canvas
                        id="orderStatusChartCanvas"
                        style="display: block; width: 100%; height: 100%"
                      ></canvas>
                    </div>

                    <script>
                      document.addEventListener("DOMContentLoaded", () => {
                        // Get data from Spring Model
                        const orderRevenueByStatusJson =
                          "${orderRevenueByStatusJson}";
                        let orderRevenueData = [];
                        try {
                          orderRevenueData = JSON.parse(
                            orderRevenueByStatusJson
                          );
                        } catch (e) {
                          console.error("Error parsing order revenue data:", e);
                        }

                        const labels = orderRevenueData.map((item) => {
                          let statusText = item.status;
                          switch (item.status) {
                            case "PENDING":
                              statusText = "Chờ xử lý";
                              break;
                            case "PROCESSING":
                              statusText = "Đang xử lý";
                              break;
                            case "SHIPPED":
                              statusText = "Đang giao hàng";
                              break;
                            case "DELIVERED":
                              statusText = "Đã giao hàng";
                              break;
                            case "CANCELLED":
                              statusText = "Đã hủy";
                              break;
                          }
                          return statusText;
                        });
                        const data = orderRevenueData.map(
                          (item) => item.totalRevenue
                        );

                        const colors = [
                          "rgba(255, 99, 132, 0.7)", // Red
                          "rgba(54, 162, 235, 0.7)", // Blue
                          "rgba(255, 206, 86, 0.7)", // Yellow
                          "rgba(75, 192, 192, 0.7)", // Green
                          "rgba(153, 102, 255, 0.7)", // Purple
                        ];

                        const canvas = document.querySelector(
                          "#orderStatusChartCanvas"
                        );
                        if (canvas && typeof Chart !== "undefined") {
                          new Chart(canvas, {
                            type: "doughnut", // Change to doughnut for circular chart
                            data: {
                              labels: labels,
                              datasets: [
                                {
                                  label: "Doanh thu",
                                  data: data,
                                  backgroundColor: colors,
                                  hoverOffset: 4,
                                },
                              ],
                            },
                            options: {
                              responsive: true,
                              maintainAspectRatio: false,
                              plugins: {
                                legend: {
                                  position: "top",
                                },
                                tooltip: {
                                  callbacks: {
                                    label: function (context) {
                                      let label = context.label || "";
                                      if (label) {
                                        label += ": ";
                                      }
                                      if (context.parsed) {
                                        label += new Intl.NumberFormat(
                                          "vi-VN",
                                          { style: "currency", currency: "VND" }
                                        ).format(context.parsed);
                                      }
                                      return label;
                                    },
                                  },
                                },
                              },
                            },
                          });
                        }
                      });
                    </script>
                    <!-- End Donut Chart -->
                  </div>
                </div>
              </div>
              <!-- End Reports -->

              <!-- Top Selling Products -->
              <div class="col-12">
                <div class="card top-selling">
                  <div class="card-body pb-0">
                    <h5 class="card-title">
                      Sản phẩm bán chạy nhất<span>/Hôm nay</span>
                    </h5>

                    <table class="table table-borderless">
                      <thead>
                        <tr>
                          <th scope="col">#</th>
                          <th scope="col">Sản phẩm</th>
                          <th scope="col">Giá</th>
                          <th scope="col">Đã bán</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach
                          var="product"
                          items="${topSellingProducts}"
                          varStatus="loop"
                        >
                          <tr>
                            <th scope="row">
                              <a href="#">${loop.index + 1}</a>
                            </th>
                            <td>
                              <a href="#" class="text-primary fw-bold"
                                >${product.productName}</a
                              >
                            </td>
                            <td>
                              <fmt:formatNumber
                                value="${product.price}"
                                type="currency"
                                currencySymbol="₫"
                                pattern="#,##0"
                              />
                            </td>
                            <td class="fw-bold">${product.totalSold}</td>
                          </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <!-- End Top Selling Products -->
            </div>
          </div>
          <!-- End Left side columns -->
        </div>
      </section>
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <jsp:include page="footer.jsp" />
    <!-- End Footer -->

    <a
      href="#"
      class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>

    <!-- Vendor JS Files -->
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/chart.js/chart.umd.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/echarts/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/quill/quill.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>
  </body>
</html>
