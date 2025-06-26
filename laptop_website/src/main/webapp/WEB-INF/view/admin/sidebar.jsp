<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ======= Sidebar ======= -->
<% String uri = request.getRequestURI(); %>

<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item <%= uri.contains("/index") ? "active" : "" %>">
            <a class="nav-link" href="/view/admin/dashboard">
                <i class="bi bi-grid"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <!-- End Dashboard Nav -->

        <li class="nav-item <%= uri.contains("/user") ? "active" : ""%>">
            <a
                    class="nav-link collapsed"
                    data-bs-target="#user-nav"
                    href="/view/admin/user">
                <i class="bi bi-person"></i><span>Người sử dụng</span>
                <i class="bi bi-chevron-right ms-auto"></i>
            </a>
        </li>

        <li class="nav-item <%= uri.contains("/product") ? "active" : ""%>">
            <a
                    class="nav-link collapsed"
                    data-bs-target="#product-nav"
                    href="/view/admin/product"
            >
                <i class="bi bi-journal-text"></i><span>Sản phẩm</span
            ><i class="bi bi-chevron-right ms-auto"></i>
            </a>
        </li>
        <!-- End Forms Nav -->

        <li class="nav-item <%= uri.contains("/order") ? "active" : ""%>">
            <a
                    class="nav-link collapsed"
                    data-bs-target="#orders-nav"
                    href="/view/admin/order"
            >
                <i class="bi bi-layout-text-window-reverse"></i
                ><span>Đơn hàng</span
            ><i class="bi bi-chevron-right ms-auto"></i>
            </a>
        </li>
        <!-- End Tables Nav -->

    </ul>
</aside>
<!-- End Sidebar-->
</body>

<style>

    .sidebar-nav .nav-item.active > .nav-link,
    .sidebar-nav .nav-item.active > .nav-link i,
    .nav-content .active > a,
    .nav-content .active > a i {
        color: #4154f1 !important;
    }

    .nav-item > .nav-link {
        background-color: transparent !important;
        color: #012970 !important; /* hoặc màu text mặc định của bạn */
    }

    .nav-link i.bi-chevron-right,
    .nav-link i.bi-chevron-down {
        padding-right: 0 !important;
        margin-right: 0 !important;
    }

    /* Sidebar Toggle Styles */
    .sidebar {
        transition: all 0.3s ease-in-out;
    }

    body.toggle-sidebar .sidebar {
        left: -300px;
    }

    @media (max-width: 1199px) {
        .sidebar {
            left: -300px;
        }

        body.toggle-sidebar .sidebar {
            left: 0;
        }
    }

    /* Modal Backdrop Styles */
    .modal-backdrop {
        background-color: rgba(252, 249, 249, 0.5) !important;
    }
    
    .modal-backdrop.show {
        opacity: 1 !important;
    }

</style>

<!-- Template Main JS File -->
<%--<script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>--%>
