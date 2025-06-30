<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Add User Modal -->
<div
  class="modal fade"
  id="addUserModal"
  tabindex="-1"
  aria-labelledby="addUserModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addUserModalLabel">Thêm người dùng mới</h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <form id="addUserForm">
        <div class="modal-body">
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Họ và tên</label>
            <div class="col-sm-10">
              <input
                type="text"
                class="form-control"
                name="fullname"
                required
              />
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-10">
              <input type="email" class="form-control" name="email" required />
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Mật khẩu</label>
            <div class="col-sm-10">
              <input
                type="password"
                class="form-control"
                name="password"
                required
              />
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Số điện thoại</label>
            <div class="col-sm-10">
              <input type="tel" class="form-control" name="userPhone" />
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Địa chỉ</label>
            <div class="col-sm-10">
              <textarea class="form-control" name="address" rows="2"></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Vai trò</label>
            <div class="col-sm-10">
              <select class="form-select" name="role" required>
                <option value="USER">Người dùng</option>
                <option value="EDITOR">Biên tập viên</option>
                <option value="ADMIN">Quản trị viên</option>
              </select>
            </div>
          </div>
          <div class="row mb-3">
            <label class="col-sm-2 col-form-label">Trạng thái</label>
            <div class="col-sm-10">
              <select class="form-select" name="status" required>
                <option value="ACTIVE">Hoạt động</option>
                <option value="INACTIVE">Không hoạt động</option>
              </select>
            </div>
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
          <button type="submit" class="btn btn-primary">Thêm</button>
        </div>
      </form>
    </div>
  </div>
</div>
