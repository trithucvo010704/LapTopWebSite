<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Modal Update Order Status -->
<div
  class="modal fade"
  id="updateStatusModal"
  tabindex="-1"
  aria-labelledby="updateStatusModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateStatusModalLabel">
          Cập nhật trạng thái đơn hàng
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Đóng"
        ></button>
      </div>
      <div class="modal-body">
        <form id="updateStatusForm">
          <input type="hidden" id="update_orderId" name="orderId" />

          <!-- Thông tin đơn hàng -->
          <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-bold">Mã đơn hàng:</label>
            <div class="col-sm-8">
              <p class="form-control-plaintext" id="update_orderCode"></p>
            </div>
          </div>

          <div class="row mb-3">
            <label class="col-sm-4 col-form-label fw-bold">Khách hàng:</label>
            <div class="col-sm-8">
              <p class="form-control-plaintext" id="update_receiverName"></p>
            </div>
          </div>

          <!-- Trạng thái đơn hàng -->
          <div class="row mb-3">
            <label for="update_status" class="col-sm-4 col-form-label fw-bold">
              Trạng thái đơn hàng <span class="text-danger">*</span>
            </label>
            <div class="col-sm-8">
              <select
                class="form-select"
                id="update_status"
                name="status"
                required
              >
                <option value="">Chọn trạng thái</option>
                <option value="PENDING">Chờ xử lý</option>
                <option value="CONFIRMED">Đã xác nhận</option>
                <option value="PROCESSING">Đang xử lý</option>
                <option value="SHIPPING">Đang giao hàng</option>
                <option value="DELIVERED">Đã giao hàng</option>
                <option value="CANCELLED">Đã hủy</option>
                <option value="RETURNED">Đã trả hàng</option>
              </select>
              <div class="invalid-feedback">
                Vui lòng chọn trạng thái đơn hàng
              </div>
            </div>
          </div>

          <!-- Trạng thái thanh toán -->
          <div class="row mb-3">
            <label
              for="update_paymentStatus"
              class="col-sm-4 col-form-label fw-bold"
            >
              Trạng thái thanh toán <span class="text-danger">*</span>
            </label>
            <div class="col-sm-8">
              <select
                class="form-select"
                id="update_paymentStatus"
                name="paymentStatus"
                required
              >
                <option value="">Chọn trạng thái thanh toán</option>
                <option value="PENDING">Chờ thanh toán</option>
                <option value="PAID">Đã thanh toán</option>
                <option value="FAILED">Thanh toán thất bại</option>
                <option value="REFUNDED">Đã hoàn tiền</option>
              </select>
              <div class="invalid-feedback">
                Vui lòng chọn trạng thái thanh toán
              </div>
            </div>
          </div>

          <!-- Ghi chú -->
          <div class="row mb-3">
            <label for="update_note" class="col-sm-4 col-form-label fw-bold">
              Ghi chú
            </label>
            <div class="col-sm-8">
              <textarea
                class="form-control"
                id="update_note"
                name="note"
                rows="3"
                placeholder="Nhập ghi chú (nếu có)..."
              ></textarea>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Hủy
        </button>
        <button
          type="button"
          class="btn btn-primary"
          onclick="orderHandler.submitStatusUpdate()"
        >
          <i class="bi bi-check-circle me-1"></i> Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>
