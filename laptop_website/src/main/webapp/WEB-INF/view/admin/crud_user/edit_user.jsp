<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!-- Edit User Modal (chuẩn hóa, chỉ 1 modal duy nhất) -->
    <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="editUserModalLabel">
              Sửa thông tin người dùng
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form id="editUserForm" class="edit-user-form">
            <input type="hidden" name="id" id="edit_id" />
            <div class="modal-body">
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Họ và tên</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="edit_fullname" name="fullname" required />
                </div>
              </div>
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Tên đăng nhập (email)</label>
                <div class="col-sm-10">
                  <input type="text" class="form-control" id="edit_username" name="username" required />
                </div>
              </div>
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Số điện thoại</label>
                <div class="col-sm-10">
                  <input type="tel" class="form-control" id="edit_userPhone" name="userPhone" />
                </div>
              </div>
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Địa chỉ</label>
                <div class="col-sm-10">
                  <textarea class="form-control" id="edit_address" name="address" rows="2"></textarea>
                </div>
              </div>
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Vai trò</label>
                <div class="col-sm-10">
                  <select class="form-select" id="edit_role" name="role" required>
                    <option value="USER">Người dùng</option>
                    <option value="EDITOR">Biên tập viên</option>
                    <option value="ADMIN">Quản trị viên</option>
                  </select>
                </div>
              </div>
              <div class="row mb-3">
                <label class="col-sm-2 col-form-label">Trạng thái</label>
                <div class="col-sm-10">
                  <select class="form-select" id="edit_status" name="status" required>
                    <option value="ACTIVE">Hoạt động</option>
                    <option value="LOCKED">Bị khóa</option>
                    <option value="INACTIVE">Không hoạt động</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                Đóng
              </button>
              <button type="submit" class="btn btn-primary">Cập nhật</button>
            </div>
          </form>
        </div>
      </div>
    </div>