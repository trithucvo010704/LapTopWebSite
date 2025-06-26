<!-- Modal Xóa Sản Phẩm -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="deleteProductModal_${product.id}" tabindex="-1" role="dialog" aria-labelledby="deleteProductModalLabel_${product.id}" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteProductModalLabel_${product.id}">Xác nhận xóa sản phẩm</h5>
<%--                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Đóng">--%>
<%--                    <span aria-hidden="true">&times;</span>--%>
<%--                </button>--%>
            </div>

            <div class="modal-body">
                Bạn có chắc chắn muốn xóa sản phẩm <strong>${product.productName}</strong> (ID: ${product.id}) không?
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form action="/admin/product/delete" method="post">
                    <input type="hidden" name="productId" value="${product.id}" />
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>

        </div>
    </div>
</div>
