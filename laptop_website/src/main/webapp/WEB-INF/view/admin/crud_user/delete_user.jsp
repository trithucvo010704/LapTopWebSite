<!-- Delete User Modal -->
<div
  class="modal fade"
  id="deleteUserModal_${user.id}"
  tabindex="-1"
  aria-labelledby="deleteUserModalLabel_${user.id}"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteUserModalLabel_${user.id}">
          Xác nhận xóa
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <p>
          Bạn có chắc chắn muốn xóa người dùng
          <strong>${user.fullname}</strong>?
        </p>
        <p class="text-danger">Lưu ý: Hành động này không thể hoàn tác.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Hủy
        </button>
        <form
          action="${pageContext.request.contextPath}/admin/user/delete"
          method="post"
          class="d-inline"
        >
          <input type="hidden" name="userId" value="${user.id}" />
          <button type="submit" class="btn btn-danger">Xóa</button>
        </form>
      </div>
    </div>
  </div>
</div>
