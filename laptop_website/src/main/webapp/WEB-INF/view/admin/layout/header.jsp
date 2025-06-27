<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
        <a href="/view/admin/dashboard" class="logo d-flex align-items-center justify-content-center">
            <img src="/image/logo.png" alt="" class="bg-success"/>
            <span class="d-none d-lg-block">Admin Page</span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
    </div>
    <!-- End Logo -->

    <div class="search-bar">
        <form
                class="search-form d-flex align-items-center"
                method="POST"
                action="#"
        >
            <input
                    type="text"
                    name="query"
                    placeholder="Search"
                    title="Enter search keyword"
            />
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
    document.addEventListener('DOMContentLoaded', function() {
        const toggleSidebarBtn = document.querySelector('.toggle-sidebar-btn');
        const sidebar = document.querySelector('#sidebar');
        const body = document.querySelector('body');

        toggleSidebarBtn.addEventListener('click', function() {
            sidebar.classList.toggle('toggle-sidebar');
            body.classList.toggle('toggle-sidebar');
        });
    });
</script>
