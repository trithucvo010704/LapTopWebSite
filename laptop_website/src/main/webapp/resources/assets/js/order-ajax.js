// Order AJAX Handler
class OrderAjaxHandler {
  constructor() {
    this.currentPage = 0;
    this.pageSize = 10;
    this.searchOrderCode = "";
    this.searchStatus = "";
    this.searchPaymentStatus = "";
    this.searchReceiverName = "";
    this.init();
  }

  init() {
    this.loadOrders();
    this.bindEvents();
  }

  bindEvents() {
    $("#searchOrderCodeInput").on("input", (e) => {
      this.searchOrderCode = e.target.value;
      this.currentPage = 0;
      this.loadOrders();
    });

    $("#searchReceiverNameInput").on("input", (e) => {
      this.searchReceiverName = e.target.value;
      this.currentPage = 0;
      this.loadOrders();
    });

    $("#searchStatusSelect").on("change", (e) => {
      this.searchStatus = e.target.value;
      this.currentPage = 0;
      this.loadOrders();
    });

    $("#searchPaymentStatusSelect").on("change", (e) => {
      this.searchPaymentStatus = e.target.value;
      this.currentPage = 0;
      this.loadOrders();
    });

    $(document).on("click", ".pagination .page-link", (e) => {
      e.preventDefault();
      const page = $(e.target).data("page");
      if (page !== undefined) {
        this.currentPage = page;
        this.loadOrders();
      }
    });

    $(document).on("click", ".btn-soft-delete-order", (e) => {
      e.preventDefault();
      const orderId = $(e.target)
        .closest(".btn-soft-delete-order")
        .data("order-id");
      this.softDeleteOrder(orderId);
    });

    $(document).on("click", ".btn-restore-order", (e) => {
      e.preventDefault();
      const orderId = $(e.target)
        .closest(".btn-restore-order")
        .data("order-id");
      this.restoreOrder(orderId);
    });

    $(document).on("click", ".btn-open-update-status", (e) => {
      e.preventDefault();
      const orderId = $(e.target)
        .closest(".btn-open-update-status")
        .data("order-id");
      this.openUpdateStatusModal(orderId);
    });
  }

  loadOrders() {
    const params = new URLSearchParams({
      page: this.currentPage,
      size: this.pageSize,
    });
    if (this.searchOrderCode)
      params.append("searchOrderCode", this.searchOrderCode);
    if (this.searchStatus) params.append("searchStatus", this.searchStatus);
    if (this.searchPaymentStatus)
      params.append("searchPaymentStatus", this.searchPaymentStatus);
    if (this.searchReceiverName)
      params.append("searchReceiverName", this.searchReceiverName);

    $.ajax({
      url: "/api/orders?" + params.toString(),
      method: "GET",
      success: (response) => {
        this.renderOrders(response);
        this.renderPagination(response);
        this.updateUrl();
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi tải danh sách đơn hàng", "error");
      },
    });
  }

  renderOrders(data) {
    const tbody = $(".table tbody");
    tbody.empty();
    const orders = data.orders || [];
    if (orders.length > 0) {
      orders.forEach((order, index) => {
        const statusBadge = this.getStatusBadge(order.status);
        const paymentStatusBadge = this.getPaymentStatusBadge(
          order.paymentStatus
        );
        const row = `
          <tr>
            <td>${data.currentPage * data.size + index + 1}</td>
            <td>${order.orderCode || ""}</td>
            <td>${order.receiverName || ""}</td>
            <td>${order.receiverPhone || ""}</td>
            <td>${this.formatPrice(order.totalAmount || order.finalPrice)}</td>
            <td>${statusBadge}</td>
            <td>${paymentStatusBadge}</td>
            <td>${this.formatDate(order.createdAt)}</td>
            <td>
              <div class="d-flex gap-2">
                <button class="btn btn-sm btn-primary" onclick="orderHandler.viewOrder(${
                  order.id
                })">
                  <i class="bi bi-eye"></i>
                </button>
                <button class="btn btn-sm btn-info btn-open-update-status" data-order-id="${
                  order.id
                }">
                  <i class="bi bi-gear"></i>
                </button>
                <button class="btn btn-sm btn-danger btn-soft-delete-order" data-order-id="${
                  order.id
                }">
                  <i class="bi bi-trash3"></i>
                </button>
              </div>
            </td>
          </tr>
        `;
        tbody.append(row);
      });
    } else {
      tbody.append(`
        <tr>
          <td colspan="9" class="text-center text-danger fw-bold">Không có đơn hàng</td>
        </tr>
      `);
    }
  }

  renderPagination(data) {
    const paginationContainer = $(".pagination-container");
    if (data.totalPages > 0) {
      let paginationHtml = `
        <div class="d-flex justify-content-between align-items-center">
          <div>
            Bạn đang xem trang ${data.currentPage + 1} trên ${
        data.totalPages
      } trang
          </div>
          <nav aria-label="Page navigation">
            <ul class="pagination justify-content-end">
      `;
      paginationHtml += `
        <li class="page-item ${data.currentPage === 0 ? "disabled" : ""}">
          <a class="page-link" href="#" data-page="${
            data.currentPage - 1
          }">Trước</a>
        </li>
      `;
      for (let i = 1; i <= data.totalPages; i++) {
        paginationHtml += `
          <li class="page-item ${data.currentPage + 1 === i ? "active" : ""}">
            <a class="page-link" href="#" data-page="${i - 1}">${i}</a>
          </li>
        `;
      }
      paginationHtml += `
        <li class="page-item ${
          data.currentPage + 1 === data.totalPages ? "disabled" : ""
        }">
          <a class="page-link" href="#" data-page="${
            data.currentPage + 1
          }">Sau</a>
        </li>
      `;
      paginationHtml += `
            </ul>
          </nav>
        </div>
      `;
      paginationContainer.html(paginationHtml);
    } else {
      paginationContainer.empty();
    }
  }

  updateUrl() {
    const params = new URLSearchParams();
    if (this.currentPage > 0) params.append("page", this.currentPage + 1);
    if (this.pageSize !== 10) params.append("size", this.pageSize);
    if (this.searchOrderCode)
      params.append("searchOrderCode", this.searchOrderCode);
    if (this.searchStatus) params.append("searchStatus", this.searchStatus);
    if (this.searchPaymentStatus)
      params.append("searchPaymentStatus", this.searchPaymentStatus);
    if (this.searchReceiverName)
      params.append("searchReceiverName", this.searchReceiverName);
    const newUrl =
      window.location.pathname +
      (params.toString() ? "?" + params.toString() : "");
    window.history.pushState({}, "", newUrl);
  }

  softDeleteOrder(orderId) {
    if (confirm("Bạn có chắc chắn muốn xóa đơn hàng này?")) {
      $.ajax({
        url: `/api/orders/${orderId}`,
        method: "DELETE",
        success: (response) => {
          if (response.success) {
            this.showToast(response.message, "success");
            this.loadOrders();
          } else {
            this.showToast(response.message, "error");
          }
        },
        error: (xhr, status, error) => {
          this.showToast("Lỗi khi xóa đơn hàng", "error");
        },
      });
    }
  }

  restoreOrder(orderId) {
    if (confirm("Bạn có chắc chắn muốn khôi phục đơn hàng này?")) {
      $.ajax({
        url: `/api/orders/${orderId}/restore`,
        method: "PUT",
        success: (response) => {
          if (response.success) {
            this.showToast("Khôi phục đơn hàng thành công", "success");
            this.loadOrders();
          } else {
            this.showToast(response.message, "error");
          }
        },
        error: (xhr, status, error) => {
          this.showToast("Lỗi khi khôi phục đơn hàng", "error");
        },
      });
    }
  }

  viewOrder(orderId) {
    $.ajax({
      url: `/api/orders/${orderId}`,
      method: "GET",
      success: (response) => {
        this.populateViewModal(response);
        $("#viewOrderModal").modal("show");
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi tải thông tin đơn hàng", "error");
      },
    });
  }

  populateViewModal(order) {
    // TODO: Điền dữ liệu vào modal chi tiết đơn hàng
    // Ví dụ:
    $("#view_orderCode").text(order.orderCode || "");
    $("#view_receiverName").text(order.receiverName || "");
    $("#view_receiverPhone").text(order.receiverPhone || "");
    $("#view_receiverEmail").text(order.receiverEmail || "");
    $("#view_shippingAddress").text(
      order.shippingAddress || order.receiverAddress || ""
    );
    $("#view_createdAt").text(this.formatDate(order.createdAt));
    $("#view_totalPrice").text(this.formatPrice(order.totalAmount));
    $("#view_shippingFee").text(this.formatPrice(order.shippingFee));
    $("#view_discountAmount").text(this.formatPrice(order.discountAmount));
    $("#view_finalPrice").text(this.formatPrice(order.finalPrice));
    $("#view_paymentMethod").text(order.paymentMethod || "");
    $("#view_note").text(order.note || "");
    // Badge
    $("#view_status").html(this.getStatusBadge(order.status));
    $("#view_paymentStatus").html(
      this.getPaymentStatusBadge(order.paymentStatus)
    );
    // Chi tiết sản phẩm
    const orderDetailsTbody = $("#view_orderDetails tbody");
    orderDetailsTbody.empty();
    if (order.orderDetails && order.orderDetails.length > 0) {
      order.orderDetails.forEach((detail, idx) => {
        const row = `
          <tr>
            <td>${idx + 1}</td>
            <td>${detail.productName || ""}</td>
            <td class="text-center">${detail.quantity || 0}</td>
            <td class="text-end">${this.formatPrice(detail.price)}</td>
            <td class="text-end">${this.formatPrice(
              (detail.price || 0) * (detail.quantity || 0)
            )}</td>
          </tr>
        `;
        orderDetailsTbody.append(row);
      });
    } else {
      orderDetailsTbody.html(
        '<tr><td colspan="5" class="text-center text-muted">Không có chi tiết sản phẩm</td></tr>'
      );
    }
  }

  serializeForm(form) {
    const formData = {};
    form.serializeArray().forEach((item) => {
      formData[item.name] = item.value;
    });
    return formData;
  }

  formatPrice(price) {
    if (!price) return "0 ₫";
    return new Intl.NumberFormat("vi-VN", {
      style: "currency",
      currency: "VND",
    }).format(price);
  }

  formatDate(dateString) {
    if (!dateString) return "";
    const date = new Date(dateString);
    return date.toLocaleDateString("vi-VN");
  }

  getStatusBadge(status) {
    const statusMap = {
      PENDING: '<span class="badge bg-warning">Chờ xử lý</span>',
      CONFIRMED: '<span class="badge bg-info">Đã xác nhận</span>',
      PROCESSING: '<span class="badge bg-primary">Đang xử lý</span>',
      SHIPPING: '<span class="badge bg-info">Đang giao hàng</span>',
      DELIVERED: '<span class="badge bg-success">Đã giao hàng</span>',
      CANCELLED: '<span class="badge bg-danger">Đã hủy</span>',
      RETURNED: '<span class="badge bg-secondary">Đã trả hàng</span>',
    };
    return (
      statusMap[status] || `<span class="badge bg-secondary">${status}</span>`
    );
  }

  getPaymentStatusBadge(paymentStatus) {
    const paymentStatusMap = {
      PENDING: '<span class="badge bg-warning">Chờ thanh toán</span>',
      PAID: '<span class="badge bg-success">Đã thanh toán</span>',
      FAILED: '<span class="badge bg-danger">Thanh toán thất bại</span>',
      REFUNDED: '<span class="badge bg-info">Đã hoàn tiền</span>',
    };
    return (
      paymentStatusMap[paymentStatus] ||
      `<span class="badge bg-secondary">${paymentStatus}</span>`
    );
  }

  showToast(message, type = "info") {
    const toastClass =
      type === "success"
        ? "bg-success"
        : type === "error"
        ? "bg-danger"
        : "bg-info";
    const toast = `
      <div class="toast align-items-center text-white ${toastClass} border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
          <div class="toast-body">${message}</div>
          <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
      </div>
    `;
    $(".toast-container").append(toast);
    $(".toast").toast("show");
  }

  openUpdateStatusModal(orderId) {
    // Gọi API lấy thông tin đơn hàng
    $.ajax({
      url: `/api/orders/${orderId}`,
      method: "GET",
      success: (order) => {
        // Điền dữ liệu vào modal cập nhật trạng thái
        $("#update_orderId").val(order.id);
        $("#update_orderCode").text(order.orderCode || "");
        $("#update_receiverName").text(order.receiverName || "");
        $("#update_status").val(order.status || "");
        $("#update_paymentStatus").val(order.paymentStatus || "");
        $("#update_note").val(order.note || "");
        // Hiển thị modal
        $("#updateStatusModal").modal("show");
      },
      error: () => {
        this.showToast("Lỗi khi tải thông tin đơn hàng", "error");
      },
    });
  }

  submitStatusUpdate() {
    const orderId = $("#update_orderId").val();
    const status = $("#update_status").val();
    const paymentStatus = $("#update_paymentStatus").val();
    const note = $("#update_note").val();

    // Gửi cập nhật trạng thái đơn hàng
    $.ajax({
      url: `/api/orders/${orderId}/status`,
      method: "PUT",
      contentType: "application/json",
      data: JSON.stringify({
        status,
        paymentStatus,
        note,
      }),
      success: (response) => {
        if (response.message) {
          this.showToast(response.message, "success");
          $("#updateStatusModal").modal("hide");
          this.loadOrders();
        } else {
          this.showToast("Cập nhật trạng thái đơn hàng thành công", "success");
          $("#updateStatusModal").modal("hide");
          this.loadOrders();
        }
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi cập nhật trạng thái đơn hàng", "error");
      },
    });
  }
}

// Initialize when document is ready
$(document).ready(function () {
  window.orderHandler = new OrderAjaxHandler();
});
