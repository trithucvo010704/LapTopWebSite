// Product AJAX Handler
class ProductAjaxHandler {
  constructor() {
    this.currentPage = 0;
    this.pageSize = 10;
    this.searchName = "";
    this.brand = "";
    this.category = "";
    this.sortBy = "";
    this.init();
  }

  init() {
    this.loadProducts();
    this.bindEvents();
  }

  bindEvents() {
    // Bind search input
    $("#searchInput").on("input", (e) => {
      this.searchName = e.target.value;
      this.currentPage = 0;
      this.loadProducts();
    });

    // Bind filter selects
    $('select[name="brand"]').on("change", (e) => {
      this.brand = e.target.value;
      this.currentPage = 0;
      this.loadProducts();
    });

    $('select[name="category"]').on("change", (e) => {
      this.category = e.target.value;
      this.currentPage = 0;
      this.loadProducts();
    });

    $('select[name="sortBy"]').on("change", (e) => {
      this.sortBy = e.target.value;
      this.currentPage = 0;
      this.loadProducts();
    });

    $('select[name="size"]').on("change", (e) => {
      this.pageSize = parseInt(e.target.value);
      this.currentPage = 0;
      this.loadProducts();
    });

    // Bind pagination
    $(document).on("click", ".pagination .page-link", (e) => {
      e.preventDefault();
      const href = $(e.target).attr("href");
      if (href) {
        const urlParams = new URLSearchParams(href.split("?")[1]);
        this.currentPage = parseInt(urlParams.get("page")) - 1;
        this.loadProducts();
      }
    });

    // Bind delete buttons
    $(document).on("click", ".btn-delete-product", (e) => {
      e.preventDefault();
      const productId = $(e.target).data("product-id");
      this.deleteProduct(productId);
    });

    // Bind edit form submit
    $(document).on("submit", ".edit-product-form", (e) => {
      e.preventDefault();
      const form = $(e.target);
      const productId = form.data("product-id");
      this.updateProduct(productId, form);
    });

    // Bind create form submit
    $(document).on("submit", "#createProductForm", (e) => {
      e.preventDefault();
      this.createProduct($(e.target));
    });
  }

  loadProducts() {
    const params = new URLSearchParams({
      page: this.currentPage,
      size: this.pageSize,
    });

    if (this.searchName) params.append("searchName", this.searchName);
    if (this.brand) params.append("brand", this.brand);
    if (this.category) params.append("category", this.category);
    if (this.sortBy) params.append("sortBy", this.sortBy);

    $.ajax({
      url: "/api/products?" + params.toString(),
      method: "GET",
      success: (response) => {
        this.renderProducts(response);
        this.renderPagination(response);
        this.updateUrl();
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi tải danh sách sản phẩm", "error");
      },
    });
  }

  renderProducts(data) {
    const tbody = $(".table tbody");
    tbody.empty();

    if (data.products && data.products.length > 0) {
      data.products.forEach((product, index) => {
        const row = `
                    <tr>
                        <td>${data.currentPage * data.size + index + 1}</td>
                        <td>${product.name || ""}</td>
                        <td>${
                          product.category && product.category.name
                            ? product.category.name
                            : ""
                        }</td>
                        <td>${product.factory || ""}</td>
                        <td>${product.quantity || 0}</td>
                        <td>${product.sold || 0}</td>
                        <td>${this.formatPrice(product.price)}</td>
                        <td>
                            <div class="d-flex gap-2">
                                <button class="btn btn-sm btn-primary" onclick="productHandler.viewProduct(${
                                  product.id
                                })">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <button class="btn btn-sm btn-warning" onclick="productHandler.editProduct(${
                                  product.id
                                })">
                                    <i class="bi bi-pencil-fill"></i>
                                </button>
                                <button class="btn btn-sm btn-danger btn-delete-product" data-product-id="${
                                  product.id
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
                    <td colspan="8" class="text-center text-danger fw-bold">Không có sản phẩm</td>
                </tr>
            `);
    }
  }

  renderPagination(data) {
    const paginationContainer = $(".pagination").parent();
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
    if (this.brand) params.append("brand", this.brand);
    if (this.category) params.append("category", this.category);
    if (this.sortBy) params.append("sortBy", this.sortBy);

    const newUrl =
      window.location.pathname +
      (params.toString() ? "?" + params.toString() : "");
    window.history.pushState({}, "", newUrl);
  }

  createProduct(form) {
    const formData = this.serializeForm(form);

    $.ajax({
      url: "/api/products",
      method: "POST",
      contentType: "application/json",
      data: JSON.stringify(formData),
      success: (response) => {
        if (response.success) {
          this.showToast(response.message, "success");
          $("#addProductModal").modal("hide");
          form[0].reset();
          this.loadProducts();
        } else {
          this.showToast(response.message, "error");
        }
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi tạo sản phẩm", "error");
      },
    });
  }

  updateProduct(productId, form) {
    const formData = this.serializeForm(form);

    $.ajax({
      url: `/api/products/${productId}`,
      method: "PUT",
      contentType: "application/json",
      data: JSON.stringify(formData),
      success: (response) => {
        if (response.success) {
          this.showToast(response.message, "success");
          $(`#editProductModal_${productId}`).modal("hide");
          this.loadProducts();
        } else {
          this.showToast(response.message, "error");
        }
      },
      error: (xhr, status, error) => {
        this.showToast("Lỗi khi cập nhật sản phẩm", "error");
      },
    });
  }

  deleteProduct(productId) {
    if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
      $.ajax({
        url: `/api/products/${productId}`,
        method: "DELETE",
        success: (response) => {
          if (response.success) {
            this.showToast(response.message, "success");
            this.loadProducts();
          } else {
            this.showToast(response.message, "error");
          }
        },
        error: (xhr, status, error) => {
          this.showToast("Lỗi khi xóa sản phẩm", "error");
        },
      });
    }
  }

  viewProduct(productId) {
    console.log("Click xem sản phẩm, id:", productId);
    $.ajax({
      url: `/api/products/${productId}`,
      method: "GET",
      success: (response) => {
        console.log("Response xem sản phẩm:", response);
        this.populateViewModal(response);
        $("#viewProductModal").modal("show");
        console.log("Đã show modal xem sản phẩm: #viewProductModal");
      },
      error: (xhr, status, error) => {
        console.error("Lỗi khi tải thông tin sản phẩm", xhr, status, error);
        this.showToast("Lỗi khi tải thông tin sản phẩm", "error");
      },
    });
  }

  populateViewModal(product) {
    console.log("Populate view modal với:", product);
    $("#view_id").text(product.id);
    $("#view_name").text(product.name || "");
    $("#view_category").text(
      product.category && product.category.name ? product.category.name : ""
    );
    $("#view_factory").text(product.factory || "");
    $("#view_quantity").text(product.quantity || 0);
    $("#view_sold").text(product.sold || 0);
    $("#view_price").text(this.formatPrice(product.price));
    $("#view_shortDesc").text(product.shortDesc || "");
    $("#view_detailDesc").text(product.detailDesc || "");
    // Handle image
    const imageElement = $("#view_image");
    if (product.image) {
      imageElement.html(
        `<img src="${product.image}" class="img-fluid" alt="Product image" style="max-width: 200px;">`
      );
    } else {
      imageElement.text("Không có hình ảnh");
    }
    console.log("Đã populate xong view modal");
  }

  editProduct(productId) {
    console.log("Click sửa sản phẩm, id:", productId);
    $.ajax({
      url: `/api/products/${productId}`,
      method: "GET",
      success: (response) => {
        console.log("Response sửa sản phẩm:", response);
        this.populateEditModal(response);
        $("#editProductModal").modal("show");
        console.log("Đã show modal sửa sản phẩm: #editProductModal");
      },
      error: (xhr, status, error) => {
        console.error(
          "Lỗi khi tải thông tin sản phẩm (edit)",
          xhr,
          status,
          error
        );
        this.showToast("Lỗi khi tải thông tin sản phẩm", "error");
      },
    });
  }

  populateEditModal(product) {
    console.log("Populate edit modal với:", product);
    $("#edit_id").val(product.id);
    $("#edit_name").val(product.name || "");
    $("#edit_factory").val(product.factory || "");
    $("#edit_quantity").val(product.quantity || 0);
    $("#edit_sold").val(product.sold || 0);
    $("#edit_price").val(product.price || 0);
    $("#edit_shortDesc").val(product.shortDesc || "");
    $("#edit_detailDesc").val(product.detailDesc || "");
    $("#edit_image").val(product.image || "");
    // Set category
    if (product.category && product.category.id) {
      $("#edit_category_id").val(product.category.id);
    } else {
      $("#edit_category_id").val("");
    }
    console.log("Đã populate xong edit modal");
  }

  serializeForm(form) {
    const formData = {};
    form.serializeArray().forEach((item) => {
      formData[item.name] = item.value;
    });
    return formData;
  }

  formatPrice(price) {
    if (!price) return "0 ₫";
    return new Intl.NumberFormat("vi-VN", {
      style: "currency",
      currency: "VND",
    }).format(price);
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
  window.productHandler = new ProductAjaxHandler();
});
