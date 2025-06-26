<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Modal View Order -->
<div
  class="modal fade"
  id="viewOrderModal_${order.id}"
  tabindex="-1"
  aria-labelledby="viewOrderModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewOrderModalLabel_${order.id}">
          Chi tiết đơn hàng
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Đóng"
        ></button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <th scope="row">Mã đơn hàng</th>
              <td>${order.id}</td>
            </tr>
            <tr>
              <th scope="row">Khách hàng</th>
              <td>${order.user.fullname}</td>
            </tr>
            <tr>
              <th scope="row">Số điện thoại</th>
              <td>${order.phone}</td>
            </tr>
            <tr>
              <th scope="row">Địa chỉ</th>
              <td>${order.address}</td>
            </tr>
            <tr>
              <th scope="row">Ngày đặt</th>
              <td>
                <fmt:formatDate
                  value="${order.date}"
                  pattern="dd/MM/yyyy HH:mm"
                />
              </td>
            </tr>
            <tr>
              <th scope="row">Số lượng sản phẩm</th>
              <td>${order.quality_product}</td>
            </tr>
            <tr>
              <th scope="row">Tổng tiền</th>
              <td>
                <fmt:formatNumber
                  value="${order.totalPrice}"
                  type="currency"
                  currencySymbol="₫"
                />
              </td>
            </tr>
            <tr>
              <th scope="row">Trạng thái</th>
              <td>
                <span
                  class="badge bg-${order.status == 'PENDING' ? 'warning' : order.status == 'PROCESSING' ? 'info' : order.status == 'SHIPPED' ? 'primary' : order.status == 'DELIVERED' ? 'success' : 'danger'}"
                >
                  ${order.status == 'PENDING' ? 'Chờ xử lý' : order.status ==
                  'PROCESSING' ? 'Đang xử lý' : order.status == 'SHIPPED' ?
                  'Đang giao hàng' : order.status == 'DELIVERED' ? 'Đã giao
                  hàng' : 'Đã hủy'}
                </span>
              </td>
            </tr>
            <tr>
              <th scope="row">Chi tiết sản phẩm</th>
              <td>
                <table class="table table-sm">
                  <thead>
                    <tr>
                      <th>Sản phẩm</th>
                      <th>Số lượng</th>
                      <th>Đơn giá</th>
                      <th>Thành tiền</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="detail" items="${order.orderDetails}">
                      <tr>
                        <td>${detail.product.productName}</td>
                        <td>${detail.quantity}</td>
                        <td>
                          <fmt:formatNumber
                            value="${detail.price}"
                            type="currency"
                            currencySymbol="₫"
                            pattern="#,##0"
                          />
                        </td>
                        <td>
                          <fmt:formatNumber
                            value="${detail.price * detail.quantity}"
                            type="currency"
                            currencySymbol="₫"
                            pattern="#,##0"
                          />
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Đóng
        </button>
      </div>
    </div>
  </div>
</div>
