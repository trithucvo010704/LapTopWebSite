<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Modal View Product (chuẩn hóa, chỉ 1 modal duy nhất, layout đẹp như user_detail) -->
<div
  class="modal fade"
  id="viewProductModal"
  tabindex="-1"
  aria-labelledby="viewProductModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewProductModalLabel">
          Thông tin chi tiết sản phẩm
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Đóng"
        ></button>
      </div>
      <div class="modal-body">
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">ID:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_id"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Tên sản phẩm:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_name"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Danh mục:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_category"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Thương hiệu:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_factory"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Số lượng:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_quantity"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Đã bán:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_sold"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Giá:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_price"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Mô tả ngắn:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_shortDesc"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Mô tả chi tiết:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_detailDesc"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Hình ảnh:</label>
          <div class="col-sm-9" id="view_image"></div>
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
