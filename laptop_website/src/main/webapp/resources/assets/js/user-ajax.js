// User AJAX Handler
class UserAjaxHandler {
  constructor() {
    this.currentPage = 0;
    this.pageSize = 5;
    this.searchName = "";
    this.searchRole = "";
    this.searchStatus = "";
    this.sortBy = "";
    this.sortDir = "desc";
    this.init();
  }

  init() {
    this.loadUsers();
    this.bindEvents();
  }

  bindEvents() {
    // Bind search input
    $("#searchNameInput").on("input", (e) => {
      this.searchName = e.target.value;
      this.currentPage = 0;
      this.loadUsers();
    });

    // Bind filter selects
    $("#searchRoleSelect").on("change", (e) => {
      this.searchRole = e.target.value;
      this.currentPage = 0;
      this.loadUsers();
    });

    $("#searchStatusSelect").on("change", (e) => {
      this.searchStatus = e.target.value;
      this.currentPage = 0;
      this.loadUsers();
    });

    // Bind pagination
    $(document).on("click", ".pagination .page-link", (e) => {
      e.preventDefault();
      const page = $(e.target).data("page");
      if (page !== undefined) {
        this.currentPage = page;
        this.loadUsers();
      }
    });

    // Bind delete buttons
    $(document).on("click", ".btn-delete-user", (e) => {
      e.preventDefault();
      const userId = $(e.target).closest(".btn-delete-user").data("user-id");
      this.deleteUser(userId);
    });

    // Bind toggle status buttons
    $(document).on("click", ".btn-toggle-status", (e) => {
      e.preventDefault();
      const userId = $(e.target).closest(".btn-toggle-status").data("user-id");
      this.toggleUserStatus(userId);
    });

    // Bind edit form submit
    $(document).on("submit", "#editUserForm", (e) => {
      e.preventDefault();
      const form = $(e.target);
      const userId = form.data("user-id");
      this.updateUser(userId, form);
    });

    // Bind create form submit
    $(document).on("submit", "#addUserForm", (e) => {
      e.preventDefault();
      this.createUser($(e.target));
    });

    // Bind sortBy select
    $("#sortBySelect").on("change", (e) => {
      this.sortBy = e.target.value;
      this.currentPage = 0;
      this.loadUsers();
    });

    // Bind size select
    $("#sizeSelect").on("change", (e) => {
      this.pageSize = parseInt(e.target.value);
      this.currentPage = 0;
      this.loadUsers();
    });
  }

  loadUsers() {
    const params = new URLSearchParams({
      page: this.currentPage,
      size: this.pageSize,
      sortBy: this.sortBy || "createdAt",
      sortDir: this.sortDir,
    });

    if (this.searchName) params.append("searchName", this.searchName);
    if (this.searchRole) params.append("searchRole", this.searchRole);
    if (this.searchStatus) params.append("searchStatus", this.searchStatus);

    // Show loading indicator
    $("#loadingIndicator").removeClass("d-none");
    $(".table-responsive").addClass("d-none");

    $.ajax({
      url: "/api/users?" + params.toString(),
      method: "GET",
      success: (response) => {
        this.renderUsers(response);
        this.renderPagination(response);
        this.updateUrl();
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi tải danh sách người dùng", "error");
      },
      complete: () => {
        // Hide loading indicator
        $("#loadingIndicator").addClass("d-none");
        $(".table-responsive").removeClass("d-none");
      },
    });
  }

  renderUsers(data) {
    const tbody = $(".table tbody");
    tbody.empty();

    if (data.users && data.users.length > 0) {
      data.users.forEach((user, index) => {
        const statusBadge =
          user.status === "ACTIVE"
            ? '<span class="badge bg-success">Hoạt động</span>'
            : user.status === "LOCKED"
            ? '<span class="badge bg-danger">Bị khóa</span>'
            : '<span class="badge bg-secondary">Không hoạt động</span>';

        const toggleButtonText = user.status === "ACTIVE" ? "Khóa" : "Mở khóa";
        const toggleButtonClass =
          user.status === "ACTIVE" ? "btn-warning" : "btn-success";

        const row = `
                    <tr>
                        <td>${data.currentPage * data.size + index + 1}</td>
                        <td>${user.fullname || ""}</td>
                        <td>${user.username || ""}</td>
                        <td>${user.phone || ""}</td>
                        <td>${this.getRoleDisplayName(user.role)}</td>
                        <td>${statusBadge}</td>
                        <td>${this.formatDate(user.createdAt)}</td>
                        <td>
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-primary" onclick="userHandler.viewUser(${
                                  user.id
                                })">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <button class="btn btn-sm btn-warning" onclick="userHandler.editUser(${
                                  user.id
                                })">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="btn btn-sm ${toggleButtonClass} btn-toggle-status" data-user-id="${
          user.id
        }">
                                    ${toggleButtonText}
                                </button>
                                <button class="btn btn-sm btn-danger btn-delete-user" data-user-id="${
                                  user.id
                                }">
                                    <i class="bi bi-trash3"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                `;
        tbody.append(row);
      });
    } else {
      tbody.append(`
                <tr>
                    <td colspan="8" class="text-center text-danger fw-bold">Không có người dùng</td>
                </tr>
            `);
    }
  }

  renderPagination(data) {
    const paginationContainer = $(".pagination-container");
    if (data.totalPages > 0) {
      let paginationHtml = `
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        Bạn đang xem trang ${data.currentPage + 1} trên ${
        data.totalPages
      } trang
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-end">
            `;

      // Previous button
      paginationHtml += `
                <li class="page-item ${
                  data.currentPage === 0 ? "disabled" : ""
                }">
                    <a class="page-link" href="#" data-page="${
                      data.currentPage - 1
                    }">Trước</a>
                </li>
            `;

      // Page numbers
      for (let i = 1; i <= data.totalPages; i++) {
        paginationHtml += `
                    <li class="page-item ${
                      data.currentPage + 1 === i ? "active" : ""
                    }">
                        <a class="page-link" href="#" data-page="${
                          i - 1
                        }">${i}</a>
                    </li>
                `;
      }

      // Next button
      paginationHtml += `
                <li class="page-item ${
                  data.currentPage + 1 === data.totalPages ? "disabled" : ""
                }">
                    <a class="page-link" href="#" data-page="${
                      data.currentPage + 1
                    }">Sau</a>
                </li>
            `;

      paginationHtml += `
                        </ul>
                    </nav>
                </div>
            `;

      paginationContainer.html(paginationHtml);
    } else {
      paginationContainer.empty();
    }
  }

  updateUrl() {
    const params = new URLSearchParams();
    if (this.currentPage > 0) params.append("page", this.currentPage + 1);
    if (this.pageSize !== 10) params.append("size", this.pageSize);
    if (this.searchName) params.append("searchName", this.searchName);
    if (this.searchRole) params.append("searchRole", this.searchRole);
    if (this.searchStatus) params.append("searchStatus", this.searchStatus);

    const newUrl =
      window.location.pathname +
      (params.toString() ? "?" + params.toString() : "");
    window.history.pushState({}, "", newUrl);
  }

  createUser(form) {
    const formData = this.serializeForm(form);

    $.ajax({
      url: "/api/users",
      method: "POST",
      contentType: "application/json",
      data: JSON.stringify(formData),
      success: (response) => {
        if (response.success) {
          this.showToast(response.message, "success");
          $("#addUserModal").modal("hide");
          this.loadUsers();
        } else {
          this.showToast(response.message, "error");
        }
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi tạo người dùng", "error");
      },
    });
  }

  updateUser(userId, form) {
    const formData = this.serializeForm(form);

    $.ajax({
      url: `/api/users/${userId}`,
      method: "PUT",
      contentType: "application/json",
      data: JSON.stringify(formData),
      success: (response) => {
        if (response.success) {
          this.showToast(response.message, "success");
          $(`#editUserModal_${userId}`).modal("hide");
          this.loadUsers();
        } else {
          this.showToast(response.message, "error");
        }
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi cập nhật người dùng", "error");
      },
    });
  }

  deleteUser(userId) {
    if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
      $.ajax({
        url: `/api/users/${userId}`,
        method: "DELETE",
        success: (response) => {
          if (response.success) {
            this.showToast(response.message, "success");
            this.loadUsers();
          } else {
            this.showToast(response.message, "error");
          }
        },
        error: (xhr, status, error) => {
          this.showToast("Lỗi khi xóa người dùng", "error");
        },
      });
    }
  }

  toggleUserStatus(userId) {
    $.ajax({
      url: `/api/users/${userId}/toggle-status`,
      method: "PATCH",
      success: (response) => {
        if (response.success) {
          this.showToast(response.message, "success");
          this.loadUsers();
        } else {
          this.showToast(response.message, "error");
        }
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi thay đổi trạng thái người dùng", "error");
      },
    });
  }

  viewUser(userId) {
    console.log("Click xem user, id:", userId);
    $.ajax({
      url: `/api/users/${userId}`,
      method: "GET",
      success: (response) => {
        console.log("Response xem user:", response);
        this.populateViewModal(response);
        $("#viewUserModal").modal("show");
        console.log("Đã show modal xem user: #viewUserModal");
      },
      error: (xhr, status, error) => {
        console.error("Lỗi khi tải thông tin user", xhr, status, error);
        this.showToast("Lỗi khi tải thông tin user", "error");
      },
    });
  }

  editUser(userId) {
    console.log("Click sửa user, id:", userId);
    $.ajax({
      url: `/api/users/${userId}`,
      method: "GET",
      success: (response) => {
        console.log("Response sửa user:", response);
        this.populateEditModal(response);
        $("#editUserForm").data("user-id", userId);
        $("#editUserModal").modal("show");
      },
      error: (xhr, status, error) => {
        console.error("Lỗi khi tải thông tin user (edit)", xhr, status, error);
        this.showToast("Lỗi khi tải thông tin user", "error");
      },
    });
  }

  populateViewModal(user) {
    console.log("Populate view modal với:", user);
    $("#view_fullname").text(user.fullname || "");
    $("#view_email").text(user.username || "");
    $("#view_userPhone").text(user.phone || "");
    $("#view_address").text(user.address || "");
    // Vai trò
    let roleText = "";
    let roleClass = "bg-info";
    if (user.role === "ADMIN") {
      roleText = "Quản trị viên";
      roleClass = "bg-danger";
    } else if (user.role === "EDITOR") {
      roleText = "Biên tập viên";
      roleClass = "bg-warning";
    } else {
      roleText = "Người dùng";
      roleClass = "bg-info";
    }
    $("#view_role")
      .text(roleText)
      .attr("class", "badge " + roleClass);
    // Trạng thái
    let statusText = "";
    let statusClass = "bg-secondary";
    if (user.status === "ACTIVE") {
      statusText = "Hoạt động";
      statusClass = "bg-success";
    } else if (user.status === "LOCKED") {
      statusText = "Bị khóa";
      statusClass = "bg-danger";
    } else {
      statusText = "Không hoạt động";
      statusClass = "bg-secondary";
    }
    $("#view_status")
      .text(statusText)
      .attr("class", "badge " + statusClass);
    // Ngày tạo, cập nhật
    $("#view_createdAt").text(this.formatDate(user.createdAt));
    $("#view_updatedAt").text(this.formatDate(user.updatedAt));
    console.log("Đã populate xong view modal user");
  }

  populateEditModal(user) {
    console.log("Populate edit modal với:", user);
    $("#edit_id").val(user.id);
    $("#edit_fullname").val(user.fullname || "");
    $("#edit_username").val(user.username || "");
    $("#edit_email").val(user.email || "");
    $("#edit_userPhone").val(user.phone || "");
    $("#edit_address").val(user.address || "");
    $("#edit_role").val(user.role || "USER");
    $("#edit_status").val(user.status || "ACTIVE");
    console.log("Đã populate xong edit modal user");
  }

  serializeForm(form) {
    const formData = {};
    form.serializeArray().forEach((item) => {
      formData[item.name] = item.value;
    });
    return formData;
  }

  formatDate(dateString) {
    if (!dateString) return "";
    const date = new Date(dateString);
    return date.toLocaleDateString("vi-VN");
  }

  getRoleDisplayName(role) {
    const roleMap = {
      ADMIN: "Quản trị viên",
      EDITOR: "Biên tập viên",
      USER: "Người dùng",
    };
    return roleMap[role] || role;
  }

  showToast(message, type = "info") {
    const toastClass =
      type === "success"
        ? "bg-success"
        : type === "error"
        ? "bg-danger"
        : "bg-info";

    const toast = `
            <div class="toast align-items-center text-white ${toastClass} border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">${message}</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        `;

    $(".toast-container").append(toast);
    $(".toast").toast("show");
  }
}

// Initialize when document is ready
$(document).ready(function () {
  window.userHandler = new UserAjaxHandler();
  $("#addUserModal").on("hidden.bs.modal", function () {
    $("#addUserForm")[0].reset();
  });
});
