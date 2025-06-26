<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="editProductModal_${product.id}" tabindex="-1" aria-labelledby="editProductModalLabel_${product.id}" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProductModalLabel_${product.id}">Chỉnh sửa sản phẩm: ${product.productName}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/admin/product/update" method="post">
                    <input type="hidden" name="id" value="${product.id}">
                    <div class="mb-3">
                        <label for="productName_${product.id}" class="form-label">Tên sản phẩm</label>
                        <input type="text" class="form-control" id="productName_${product.id}" name="productName" value="${product.productName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryName_${product.id}" class="form-label">Danh mục</label>
                        <input type="text" class="form-control" id="categoryName_${product.id}" name="categoryName" value="${product.categoryName}">
                    </div>
                    <div class="mb-3">
                        <label for="branchName_${product.id}" class="form-label">Thương hiệu</label>
                        <input type="text" class="form-control" id="branchName_${product.id}" name="branchName" value="${product.branchName}">
                    </div>
                    <div class="mb-3">
                        <label for="quantity_${product.id}" class="form-label">Số lượng</label>
                        <input type="number" class="form-control" id="quantity_${product.id}" name="quantity" value="${product.quantity}" min="0">
                    </div>
                    <div class="mb-3">
                        <label for="sold_${product.id}" class="form-label">Đã bán</label>
                        <input type="number" class="form-control" id="sold_${product.id}" name="sold" value="${product.sold}" min="0">
                    </div>
                    <div class="mb-3">
                        <label for="price_${product.id}" class="form-label">Giá (VND)</label>
                        <input type="number" class="form-control" id="price_${product.id}" name="price" value="${product.price}" min="0" step="0.01">
                    </div>
                    <div class="mb-3">
                        <label for="detailsDesc_${product.id}" class="form-label">Mô tả chi tiết</label>
                        <textarea class="form-control" id="detailsDesc_${product.id}" name="detailsDesc" rows="4">${product.detailsDesc}</textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>