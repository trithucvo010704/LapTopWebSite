<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Modal Update Status -->
<div class="modal fade" id="updateStatusModal_${order.id}" tabindex="-1" aria-labelledby="updateStatusModalLabel_${order.id}" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateStatusModalLabel_${order.id}">Cập nhật trạng thái đơn hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/admin/order/update-status" method="post">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <div class="mb-3">
                        <label for="status_${order.id}" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status_${order.id}" name="status">
                            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="PROCESSING" ${order.status == 'PROCESSING' ? 'selected' : ''}>Đang xử lý</option>
                            <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>Đang giao hàng</option>
                            <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Đã giao hàng</option>
                            <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div> 