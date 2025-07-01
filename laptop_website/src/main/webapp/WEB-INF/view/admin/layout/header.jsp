<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- ======= Header ======= -->
    <header id="header" class="header fixed-top d-flex align-items-center">
        <div class="d-flex align-items-center justify-content-between">
            <a href="/admin/dashboard" class="logo d-flex align-items-center justify-content-center">
                <span class="fw-bold admin-title">Admin Page</span>
            </a>
            <i class="bi bi-list toggle-sidebar-btn"></i>
        </div>
        <!-- End Logo -->

        <div class="search-bar">
            <form class="search-form d-flex align-items-center" method="POST" action="#">
                <input type="text" name="query" placeholder="Search" title="Enter search keyword" />
                <button type="submit" title="Search">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>
        <!-- End Search Bar -->

        <nav class="header-nav ms-auto me-3">
            <ul class="d-flex align-items-center">
                <li class="text-center px-3 fw-bold">Hello, ${username}</li>
                <li>
                    <form id="logoutForm" action="/logout" method="post">
                        <button class="dropdown-item d-flex align-items-center" type="submit">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>Đăng xuất</span>
                        </button>
                    </form>

                </li>

            </ul>
        </nav>
        <!-- End Icons Navigation -->
    </header>
    <!-- End Header -->

    <!-- Template Main JS File -->
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const toggleSidebarBtn = document.querySelector('.toggle-sidebar-btn');
            const sidebar = document.querySelector('#sidebar');
            const body = document.querySelector('body');

            toggleSidebarBtn.addEventListener('click', function () {
                sidebar.classList.toggle('toggle-sidebar');
                body.classList.toggle('toggle-sidebar');
            });
        });
    </script>

    <style>
        header.header {
            min-height: 68px;
            padding: 0 32px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            border-bottom: 1px solid #e9ecef;
            z-index: 1002;
        }

        .logo {
            gap: 10px;
            padding: 6px 0;
        }

        .admin-title {
            font-size: 1.45rem;
            letter-spacing: 1px;
            color: #198754;
            line-height: 1.1;
            margin-top: 2px;
            text-shadow: 0 1px 0 #fff, 0 2px 4px rgba(0, 0, 0, 0.04);
        }

        .header .search-bar {
            flex: 1 1 400px;
            margin: 0 32px;
            max-width: 500px;
        }

        .header-nav {
            min-width: 180px;
        }
    </style>