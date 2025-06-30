<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div
  class="modal fade"
  id="editProductModal"
  tabindex="-1"
  aria-labelledby="editProductModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editProductModalLabel">
          Chỉnh sửa sản phẩm
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form class="edit-product-form">
          <input type="hidden" name="id" id="edit_id" />
          <div class="mb-3">
            <label for="edit_name" class="form-label">Tên sản phẩm</label>
            <input
              type="text"
              class="form-control"
              id="edit_name"
              name="name"
              required
            />
          </div>
          <div class="mb-3">
            <label for="edit_category_id" class="form-label">Danh mục</label>
            <select
              class="form-control"
              id="edit_category_id"
              name="categoryId"
            >
              <option value="">Chọn danh mục</option>
              <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}">${cat.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label for="edit_factory" class="form-label">Thương hiệu</label>
            <input
              type="text"
              class="form-control"
              id="edit_factory"
              name="factory"
            />
          </div>
          <div class="mb-3">
            <label for="edit_quantity" class="form-label">Số lượng</label>
            <input
              type="number"
              class="form-control"
              id="edit_quantity"
              name="quantity"
              min="0"
            />
          </div>
          <div class="mb-3">
            <label for="edit_sold" class="form-label">Đã bán</label>
            <input
              type="number"
              class="form-control"
              id="edit_sold"
              name="sold"
              min="0"
            />
          </div>
          <div class="mb-3">
            <label for="edit_price" class="form-label">Giá (VND)</label>
            <input
              type="number"
              class="form-control"
              id="edit_price"
              name="price"
              min="0"
              step="0.01"
            />
          </div>
          <div class="mb-3">
            <label for="edit_shortDesc" class="form-label">Mô tả ngắn</label>
            <textarea
              class="form-control"
              id="edit_shortDesc"
              name="shortDesc"
              rows="2"
            ></textarea>
          </div>
          <div class="mb-3">
            <label for="edit_detailDesc" class="form-label"
              >Mô tả chi tiết</label
            >
            <textarea
              class="form-control"
              id="edit_detailDesc"
              name="detailDesc"
              rows="4"
            ></textarea>
          </div>
          <div class="mb-3">
            <label for="edit_image" class="form-label">Hình ảnh</label>
            <input
              type="text"
              class="form-control"
              id="edit_image"
              name="image"
            />
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Hủy
            </button>
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
