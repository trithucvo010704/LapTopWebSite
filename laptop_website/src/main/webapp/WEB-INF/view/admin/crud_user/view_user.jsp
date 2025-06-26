<!-- View User Modal -->
<div
  class="modal fade"
  id="viewUserModal_${user.id}"
  tabindex="-1"
  aria-labelledby="viewUserModalLabel_${user.id}"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="viewUserModalLabel_${user.id}">
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
            <p class="form-control-plaintext">${user.fullname}</p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Email:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext">${user.email}</p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Số điện thoại:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext">${user.userPhone}</p>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Vai trò:</label>
          <div class="col-sm-9">
            <span class="badge bg-${user.role == 'ADMIN' ? 'danger' : 'info'}"
              >${user.role}</span
            >
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Trạng thái:</label>
          <div class="col-sm-9">
            <span
              class="badge bg-${user.status == 'ACTIVE' ? 'success' : 'danger'}"
            >
              ${user.status == 'ACTIVE' ? 'Hoạt động' : 'Khóa'}
            </span>
          </div>
        </div>
        <div class="row mb-3">
          <label class="col-sm-3 col-form-label fw-bold">Ngày tạo:</label>
          <div class="col-sm-9">
            <p class="form-control-plaintext">
              <fmt:formatDate
                value="${user.createdDate}"
                pattern="dd/MM/yyyy HH:mm"
              />
            </p>
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
