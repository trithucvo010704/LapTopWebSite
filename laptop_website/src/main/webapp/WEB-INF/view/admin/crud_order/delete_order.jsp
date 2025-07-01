<!-- Modal Xóa Đơn Hàng -->
<div
  class="modal fade"
  id="deleteOrderModal"
  tabindex="-1"
  aria-labelledby="deleteOrderModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="deleteOrderModalLabel">
          Xác nhận xóa đơn hàng
        </h5>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Đóng"
        ></button>
      </div>
      <div class="modal-body">
        Bạn có chắc chắn muốn xóa đơn hàng này không?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Hủy
        </button>
        <button type="button" class="btn btn-danger" id="confirmDeleteOrderBtn">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>
