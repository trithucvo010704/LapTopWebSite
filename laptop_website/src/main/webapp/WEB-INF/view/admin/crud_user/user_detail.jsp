<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
        taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Modal View User (chuẩn hóa, chỉ 1 modal duy nhất) -->
<div
  class="modal fade"
  id="viewUserModal"
  tabindex="-1"
  aria-labelledby="viewUserModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewUserModalLabel">
          Thông tin chi tiết người dùng
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Họ và tên:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_fullname"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Email:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_email"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Số điện thoại:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_userPhone"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Địa chỉ:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_address"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Vai trò:</label>
          <div class="col-sm-9">
            <span class="badge" id="view_role"></span>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Trạng thái:</label>
          <div class="col-sm-9">
            <span class="badge" id="view_status"></span>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Ngày tạo:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_createdAt"></p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Ngày cập nhật:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext" id="view_updatedAt"></p>
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
