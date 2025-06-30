<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div
  class="modal fade"
  id="addProductModal"
  tabindex="-1"
  aria-labelledby="addProductModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <form id="createProductForm">
        <div class="modal-header">
          <h5 class="modal-title" id="addProductModalLabel">
            Thêm sản phẩm mới
          </h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Đóng"
          ></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="name" class="form-label">Tên sản phẩm</label>
            <input
              id="name"
              type="text"
              class="form-control"
              name="name"
              required
            />
          </div>
          <div class="mb-3">
            <label for="categoryId" class="form-label">Danh mục</label>
            <select class="form-control" id="categoryId" name="categoryId">
              <option value="">Chọn danh mục</option>
              <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}">${cat.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label for="factory" class="form-label">Thương hiệu</label>
            <input
              type="text"
              class="form-control"
              id="factory"
              name="factory"
              required
            />
          </div>
          <div class="mb-3">
            <label for="quantity" class="form-label">Số lượng</label>
            <input
              type="number"
              class="form-control"
              id="quantity"
              name="quantity"
              min="0"
              value="0"
              required
            />
          </div>
          <div class="mb-3">
            <label for="sold" class="form-label">Đã bán</label>
            <input
              type="number"
              class="form-control"
              id="sold"
              name="sold"
              min="0"
              value="0"
            />
          </div>
          <div class="mb-3">
            <label for="price" class="form-label">Giá (VND)</label>
            <input
              type="number"
              class="form-control"
              id="price"
              name="price"
              min="0"
              step="0.01"
              required
            />
          </div>
          <div class="mb-3">
            <label for="shortDesc" class="form-label">Mô tả ngắn</label>
            <textarea
              class="form-control"
              id="shortDesc"
              name="shortDesc"
              rows="2"
            ></textarea>
          </div>
          <div class="mb-3">
            <label for="detailDesc" class="form-label">Mô tả chi tiết</label>
            <textarea
              class="form-control"
              id="detailDesc"
              name="detailDesc"
              rows="5"
            ></textarea>
          </div>
          <div class="mb-3">
            <label for="image" class="form-label">Hình ảnh</label>
            <input
              type="text"
              class="form-control"
              id="image"
              name="image"
              placeholder="Nhập URL hình ảnh"
            />
          </div>
          <div class="mb-3">
            <label for="target" class="form-label">Đối tượng</label>
            <input
              type="text"
              class="form-control"
              id="target"
              name="target"
              placeholder="Ví dụ: Sinh viên, Văn phòng"
            />
          </div>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal"
          >
            Đóng
          </button>
          <button type="submit" class="btn btn-primary">Lưu</button>
        </div>
      </form>
    </div>
  </div>
</div>
