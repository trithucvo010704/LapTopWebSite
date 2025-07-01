<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Modal View Order (chuẩn hóa, chỉ 1 modal duy nhất, layout đẹp như user_detail) -->
<div
  class="modal fade"
  id="viewOrderModal"
  tabindex="-1"
  aria-labelledby="viewOrderModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewOrderModalLabel">
          Thông tin chi tiết đơn hàng
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Đóng"
        ></button>
      </div>
      <div class="modal-body">
        <div class="container-fluid">
          <div class="row">
            <!-- Cột trái: Thông tin đơn hàng & khách hàng -->
            <div class="col-md-6">
              <div class="card mb-3 shadow-sm">
                <div class="card-body p-3">
                  <h6 class="text-primary mb-3">Thông tin đơn hàng</h6>
                  <div class="mb-2">
                    <strong>Mã đơn hàng:</strong>
                    <span id="view_orderCode"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Ngày đặt hàng:</strong>
                    <span id="view_createdAt"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Trạng thái đơn hàng:</strong>
                    <span class="badge" id="view_status"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Trạng thái thanh toán:</strong>
                    <span class="badge" id="view_paymentStatus"></span>
                  </div>
                </div>
              </div>
              <div class="card mb-3 shadow-sm">
                <div class="card-body p-3">
                  <h6 class="text-primary mb-3">Thông tin khách hàng</h6>
                  <div class="mb-2">
                    <strong>Họ và tên:</strong>
                    <span id="view_receiverName"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Số điện thoại:</strong>
                    <span id="view_receiverPhone"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Email:</strong>
                    <span id="view_receiverEmail"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Địa chỉ giao hàng:</strong>
                    <span id="view_shippingAddress"></span>
                  </div>
                </div>
              </div>
              <div class="card shadow-sm">
                <div class="card-body p-3">
                  <h6 class="text-primary mb-3">Ghi chú</h6>
                  <div id="view_note"></div>
                </div>
              </div>
            </div>
            <!-- Cột phải: Thông tin thanh toán & sản phẩm -->
            <div class="col-md-6">
              <div class="card mb-3 shadow-sm">
                <div class="card-body p-3">
                  <h6 class="text-primary mb-3">Thông tin thanh toán</h6>
                  <div class="mb-2">
                    <strong>Tổng tiền hàng:</strong>
                    <span id="view_totalPrice"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Phí vận chuyển:</strong>
                    <span id="view_shippingFee"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Giảm giá:</strong>
                    <span id="view_discountAmount"></span>
                  </div>
                  <div class="mb-2">
                    <strong>Tổng thanh toán:</strong>
                    <span
                      class="fw-bold text-primary"
                      id="view_finalPrice"
                    ></span>
                  </div>
                  <div class="mb-2">
                    <strong>Phương thức thanh toán:</strong>
                    <span id="view_paymentMethod"></span>
                  </div>
                </div>
              </div>
              <div class="card shadow-sm">
                <div class="card-body p-3">
                  <h6 class="text-primary mb-3">Chi tiết sản phẩm</h6>
                  <div
                    class="table-responsive"
                    style="max-height: 250px; overflow-y: auto"
                  >
                    <table
                      class="table table-sm table-striped table-hover"
                      id="view_orderDetails"
                    >
                      <thead class="table-light">
                        <tr>
                          <th>STT</th>
                          <th>Sản phẩm</th>
                          <th class="text-center">SL</th>
                          <th class="text-end">Đơn giá</th>
                          <th class="text-end">Thành tiền</th>
                        </tr>
                      </thead>
                      <tbody>
                        <!-- Sẽ được populate bằng JavaScript -->
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
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

<style>
  #viewOrderModal .card {
    border-radius: 10px;
    border: 1px solid #e3e3e3;
  }
  #viewOrderModal .card-body {
    padding: 1rem 1.25rem;
  }
  #viewOrderModal .table-responsive {
    margin-bottom: 0;
  }
  #viewOrderModal .badge {
    font-size: 0.95em;
    padding: 0.4em 0.8em;
  }
</style>
