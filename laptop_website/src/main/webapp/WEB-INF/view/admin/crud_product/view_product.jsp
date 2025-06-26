<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Modal View Product -->
<div class="modal fade" id="viewProductModal_${product.id}" tabindex="-1" aria-labelledby="viewProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewProductModalLabel_${product.id}">Chi tiết sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">

                <table class="table table-bordered">
                    <tbody>
                    <tr>
                        <th scope="row">ID</th>
                        <td>${product.id}</td>
                    </tr>
                    <tr>
                        <th scope="row">Tên sản phẩm</th>
                        <td>${product.productName}</td>
                    </tr>
                    <tr>
                        <th scope="row">Danh mục</th>
                        <td>${product.categoryName}</td>
                    </tr>
                    <tr>
                        <th scope="row">Thương hiệu</th>
                        <td>${product.branchName}</td>
                    </tr>
                    <tr>
                        <th scope="row">Số lượng</th>
                        <td>${product.quantity}</td>
                    </tr>
                    <tr>
                        <th scope="row">Đã bán</th>
                        <td>${product.sold}</td>
                    </tr>
                    <tr>
                        <th scope="row">Giá</th>
                        <td>${product.price}</td>
                    </tr>
                    <tr>
                        <th scope="row">Mô tả ngắn</th>
                        <td>${product.shortDesc}</td>
                    </tr>
                    <tr>
                        <th scope="row">Mô tả chi tiết</th>
                        <td>${product.detailsDesc}</td>
                    </tr>
                    <tr>
                        <th scope="row">Hình ảnh</th>
                        <td>
                            <c:if test="${not empty product.imageLinks}">
                                <div class="row">
                                    <c:forEach var="image" items="${product.imageLinks}">
                                        <div class="col-md-4 mb-2">
                                            <img src="${image}" class="img-fluid" alt="Product image">
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
