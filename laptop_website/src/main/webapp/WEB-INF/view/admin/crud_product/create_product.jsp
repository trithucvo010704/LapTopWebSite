<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <form action="/admin/product/add" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm mới mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="productName" class="form-label">Tên sản phẩm</label>
                        <input id="productName" type="text" class="form-control" name="productName" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Danh mục</label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                    </div>
                    <div class="mb-3">
                        <label for="branchName" class="form-label">Thương hiệu</label>
                        <input type="text" class="form-control" id="branchName" name="branchName" required>
                    </div>
                    <div class="mb-3">
                        <label for="quantity" class="form-label">Số lượng</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" required>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Giá</label>
                        <input type="number" class="form-control" id="price" name="price" required>
                    </div>
                    <div class="mb-3">
                        <label for="detailsDesc" class="form-label">Mô tả</label>
                        <textarea type="text" class="form-control" id="detailsDesc" name="detailsDesc" rows="5" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="imageLinks" class="form-label">Link ảnh sản phẩm</label>
                        <div id="imageLinksContainer">
                            <div class="input-group mb-2">
                                <input type="url" class="form-control" name="imageLinks[]" placeholder="Nhập link ảnh" required>
                                <button type="button" class="btn btn-danger remove-image-link">Xóa</button>
                            </div>
                        </div>
                        <button type="button" class="btn btn-secondary" id="addImageLink">+ Thêm link ảnh</button>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>

                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.querySelector("#addProductModal form");
        const requiredFields = form.querySelectorAll("input[required]");
        const imageLinksContainer = document.getElementById("imageLinksContainer");
        const addImageLinkBtn = document.getElementById("addImageLink");

        // Add new image link input
        addImageLinkBtn.addEventListener("click", function() {
            const newInputGroup = document.createElement("div");
            newInputGroup.className = "input-group mb-2";
            newInputGroup.innerHTML = `
                <input type="url" class="form-control" name="imageLinks[]" placeholder="Nhập link ảnh" required>
                <button type="button" class="btn btn-danger remove-image-link">Xóa</button>
            `;
            imageLinksContainer.appendChild(newInputGroup);
        });

        // Remove image link input
        imageLinksContainer.addEventListener("click", function(e) {
            if (e.target.classList.contains("remove-image-link")) {
                const inputGroup = e.target.closest(".input-group");
                if (imageLinksContainer.children.length > 1) {
                    inputGroup.remove();
                } else {
                    inputGroup.querySelector("input").value = "";
                }
            }
        });

        form.addEventListener("submit", function (e) {
            let isValid = true;
            let message = "Vui lòng nhập đầy đủ thông tin:\n";

            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    const label = form.querySelector(`label[for="${field.id}"]`);
                    const fieldName = label ? label.innerText : field.name;
                    message += `- ${fieldName}\n`;
                }
            });

            if (!isValid) {
                e.preventDefault();
                alert(message);
            }
        });
    });
</script>
