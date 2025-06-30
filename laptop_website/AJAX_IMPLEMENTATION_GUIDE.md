# Hướng dẫn triển khai AJAX cho Spring Boot Web Application

## Tổng quan

Hướng dẫn này mô tả cách triển khai AJAX cho các trang quản lý sản phẩm, người dùng và đơn hàng trong ứng dụng Spring Boot, giúp tránh việc reload toàn bộ trang và cải thiện trải nghiệm người dùng.

## Cấu trúc API Endpoints

### 1. Product Management API

#### Endpoints:

- `GET /api/products` - Lấy danh sách sản phẩm với phân trang và tìm kiếm
- `GET /api/products/{id}` - Lấy thông tin một sản phẩm
- `POST /api/products` - Tạo sản phẩm mới
- `PUT /api/products/{id}` - Cập nhật sản phẩm
- `DELETE /api/products/{id}` - Xóa mềm sản phẩm
- `PATCH /api/products/{id}/restore` - Khôi phục sản phẩm
- `PATCH /api/products/{id}/toggle-status` - Bật/tắt trạng thái sản phẩm
- `GET /api/products/statistics` - Lấy thống kê sản phẩm
- `GET /api/products/categories` - Lấy danh sách danh mục

#### Parameters cho GET /api/products:

- `page` (default: 0) - Số trang
- `size` (default: 10) - Số lượng item trên mỗi trang
- `searchName` - Tìm kiếm theo tên sản phẩm
- `searchCategory` - Lọc theo danh mục
- `searchStatus` - Lọc theo trạng thái
- `sortBy` - Sắp xếp theo trường
- `sortDirection` - Hướng sắp xếp (asc/desc)

### 2. User Management API

#### Endpoints:

- `GET /api/users` - Lấy danh sách người dùng với phân trang và tìm kiếm
- `GET /api/users/{id}` - Lấy thông tin một người dùng
- `POST /api/users` - Tạo người dùng mới
- `PUT /api/users/{id}` - Cập nhật người dùng
- `DELETE /api/users/{id}` - Xóa mềm người dùng
- `PATCH /api/users/{id}/restore` - Khôi phục người dùng
- `PATCH /api/users/{id}/toggle-status` - Bật/tắt trạng thái người dùng
- `GET /api/users/statistics` - Lấy thống kê người dùng
- `GET /api/users/roles` - Lấy danh sách vai trò

#### Parameters cho GET /api/users:

- `page` (default: 0) - Số trang
- `size` (default: 10) - Số lượng item trên mỗi trang
- `searchUsername` - Tìm kiếm theo username
- `searchEmail` - Tìm kiếm theo email
- `searchFullname` - Tìm kiếm theo họ tên
- `searchRole` - Lọc theo vai trò
- `searchStatus` - Lọc theo trạng thái
- `sortBy` - Sắp xếp theo trường
- `sortDirection` - Hướng sắp xếp (asc/desc)

### 3. Order Management API

#### Endpoints:

- `GET /api/orders` - Lấy danh sách đơn hàng với phân trang và tìm kiếm
- `GET /api/orders/{id}` - Lấy thông tin một đơn hàng
- `GET /api/orders/code/{orderCode}` - Lấy đơn hàng theo mã đơn hàng
- `POST /api/orders` - Tạo đơn hàng mới
- `PUT /api/orders/{id}` - Cập nhật đơn hàng
- `DELETE /api/orders/{id}` - Xóa mềm đơn hàng
- `PATCH /api/orders/{id}/restore` - Khôi phục đơn hàng
- `PATCH /api/orders/{id}/status` - Cập nhật trạng thái đơn hàng
- `PATCH /api/orders/{id}/payment-status` - Cập nhật trạng thái thanh toán
- `GET /api/orders/statistics` - Lấy thống kê đơn hàng
- `GET /api/orders/statuses` - Lấy danh sách trạng thái đơn hàng
- `GET /api/orders/payment-statuses` - Lấy danh sách trạng thái thanh toán
- `GET /api/orders/generate-code` - Tạo mã đơn hàng mới
- `GET /api/orders/export` - Xuất file Excel

#### Parameters cho GET /api/orders:

- `page` (default: 0) - Số trang
- `size` (default: 10) - Số lượng item trên mỗi trang
- `searchOrderCode` - Tìm kiếm theo mã đơn hàng
- `searchStatus` - Lọc theo trạng thái đơn hàng
- `searchPaymentStatus` - Lọc theo trạng thái thanh toán
- `searchReceiverName` - Tìm kiếm theo tên người nhận

## Cập nhật Entity

### 1. Product Entity

```java
@Entity
@Table(name = "products")
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private Double price;

    @Column(name = "stock_quantity")
    private Integer stockQuantity;

    @Column(name = "category")
    private String category;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted = false;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Enums và methods...
}
```

### 2. User Entity

```java
@Entity
@Table(name = "users")
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String email;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role = UserRole.USER;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserStatus status = UserStatus.ACTIVE;

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted = false;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Enums và methods...
}
```

### 3. Order Entity

```java
@Entity
@Table(name = "orders")
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "order_code", unique = true, nullable = false)
    private String orderCode;

    @Column(name = "total_price", nullable = false)
    private Double totalPrice;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderStatus status = OrderStatus.PENDING;

    @Column(name = "payment_method")
    private String paymentMethod;

    @Column(name = "payment_status")
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;

    @Column(name = "shipping_address", columnDefinition = "TEXT")
    private String shippingAddress;

    @Column(name = "receiver_name")
    private String receiverName;

    @Column(name = "receiver_phone")
    private String receiverPhone;

    @Column(name = "receiver_email")
    private String receiverEmail;

    @Column(name = "shipping_fee")
    private Double shippingFee = 0.0;

    @Column(name = "discount_amount")
    private Double discountAmount = 0.0;

    @Column(name = "final_price")
    private Double finalPrice;

    @Column(name = "note", columnDefinition = "TEXT")
    private String note;

    @Column(name = "is_deleted", nullable = false)
    private Boolean isDeleted = false;

    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderDetail> orderDetails;

    // Enums và methods...
}
```

## Service Layer

### 1. ProductService

```java
public interface ProductService {
    Page<Product> findProductsWithFilters(String searchName, String searchCategory,
                                        String searchStatus, Pageable pageable);
    Product findById(Long id);
    Product save(Product product);
    void softDeleteById(Long id);
    void restoreById(Long id);
    Product toggleStatus(Long id);
    Map<String, Object> getProductStatistics();
    List<String> getAllCategories();
}
```

### 2. UserService

```java
public interface UserService {
    Page<User> findUsersWithFilters(String searchUsername, String searchEmail,
                                   String searchFullname, String searchRole,
                                   String searchStatus, Pageable pageable);
    User findById(Long id);
    User save(User user);
    void softDeleteById(Long id);
    void restoreById(Long id);
    User toggleStatus(Long id);
    Map<String, Object> getUserStatistics();
    List<String> getAllRoles();
}
```

### 3. OrderService

```java
public interface OrderService {
    Page<Order> findOrdersWithFilters(String searchOrderCode, String searchStatus,
                                     String searchPaymentStatus, String searchReceiverName,
                                     Pageable pageable);
    Order findById(Long id);
    Order findByOrderCode(String orderCode);
    Order save(Order order);
    void softDeleteById(Long id);
    void restoreById(Long id);
    Order updateStatus(Long id, String status);
    Order updatePaymentStatus(Long id, String paymentStatus);
    Map<String, Object> getOrderStatistics();
    List<String> getAllOrderStatuses();
    List<String> getAllPaymentStatuses();
    String generateOrderCode();
}
```

## Repository Layer

### 1. ProductRepository

```java
@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    List<Product> findByIsDeletedFalse();
    Optional<Product> findByIdAndIsDeletedFalse(Long id);
    List<Product> findByCategoryAndIsDeletedFalse(String category);
    List<Product> findByIsActiveAndIsDeletedFalse(Boolean isActive);

    @Modifying
    @Query("UPDATE Product p SET p.isDeleted = true WHERE p.id = :id")
    void softDeleteById(@Param("id") Long id);

    @Modifying
    @Query("UPDATE Product p SET p.isDeleted = false WHERE p.id = :id")
    void restoreById(@Param("id") Long id);

    @Query("SELECT COUNT(p) FROM Product p WHERE p.isActive = :isActive AND p.isDeleted = false")
    Long countByStatus(@Param("isActive") Boolean isActive);
}
```

### 2. UserRepository

```java
@Repository
public interface UserRepository extends JpaRepository<User, Long>, JpaSpecificationExecutor<User> {
    List<User> findByIsDeletedFalse();
    Optional<User> findByIdAndIsDeletedFalse(Long id);
    Optional<User> findByUsernameAndIsDeletedFalse(String username);
    Optional<User> findByEmailAndIsDeletedFalse(String email);
    List<User> findByRoleAndIsDeletedFalse(User.UserRole role);
    List<User> findByStatusAndIsDeletedFalse(User.UserStatus status);

    @Modifying
    @Query("UPDATE User u SET u.isDeleted = true WHERE u.id = :id")
    void softDeleteById(@Param("id") Long id);

    @Modifying
    @Query("UPDATE User u SET u.isDeleted = false WHERE u.id = :id")
    void restoreById(@Param("id") Long id);

    @Query("SELECT COUNT(u) FROM User u WHERE u.status = :status AND u.isDeleted = false")
    Long countByStatus(@Param("status") User.UserStatus status);
}
```

### 3. OrderRepository

```java
@Repository
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    List<Order> findByIsDeletedFalse();
    Optional<Order> findByOrderCodeAndIsDeletedFalse(String orderCode);
    List<Order> findByStatusAndIsDeletedFalse(Order.OrderStatus status);
    List<Order> findByPaymentStatusAndIsDeletedFalse(Order.PaymentStatus paymentStatus);
    List<Order> findByUserAndIsDeletedFalse(User user);
    List<Order> findByReceiverNameContainingIgnoreCaseAndIsDeletedFalse(String receiverName);

    @Modifying
    @Query("UPDATE Order o SET o.isDeleted = true WHERE o.id = :id")
    void softDeleteById(@Param("id") Long id);

    @Modifying
    @Query("UPDATE Order o SET o.isDeleted = false WHERE o.id = :id")
    void restoreById(@Param("id") Long id);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = :status AND o.isDeleted = false")
    Long countByStatus(@Param("status") Order.OrderStatus status);

    @Query("SELECT SUM(o.finalPrice) FROM Order o WHERE o.status = 'DELIVERED' AND o.paymentStatus = 'PAID' AND o.isDeleted = false AND YEAR(o.createdAt) = :year AND MONTH(o.createdAt) = :month")
    Double getTotalRevenueByMonth(@Param("year") int year, @Param("month") int month);
}
```

## Frontend JavaScript

### 1. Product AJAX Handler (product-ajax.js)

```javascript
class ProductAjaxHandler {
  constructor() {
    this.currentPage = 0;
    this.pageSize = 10;
    this.searchName = "";
    this.searchCategory = "";
    this.searchStatus = "";
    this.sortBy = "";
    this.sortDirection = "asc";
    this.init();
  }

  // Methods for CRUD operations, filtering, pagination...
}
```

### 2. User AJAX Handler (user-ajax.js)

```javascript
class UserAjaxHandler {
  constructor() {
    this.currentPage = 0;
    this.pageSize = 10;
    this.searchUsername = "";
    this.searchEmail = "";
    this.searchFullname = "";
    this.searchRole = "";
    this.searchStatus = "";
    this.sortBy = "";
    this.sortDirection = "asc";
    this.init();
  }

  // Methods for CRUD operations, filtering, pagination...
}
```

### 3. Order AJAX Handler (order-ajax.js)

```javascript
class OrderAjaxHandler {
  constructor() {
    this.currentPage = 0;
    this.pageSize = 10;
    this.searchOrderCode = "";
    this.searchStatus = "";
    this.searchPaymentStatus = "";
    this.searchReceiverName = "";
    this.init();
  }

  // Methods for CRUD operations, filtering, pagination...
}
```

## Cập nhật JSP Pages

### 1. product.jsp

- Thay thế form submit bằng AJAX calls
- Thêm loading indicators
- Thêm toast notifications
- Thêm dynamic pagination
- Thêm real-time filtering

### 2. user.jsp

- Thay thế form submit bằng AJAX calls
- Thêm loading indicators
- Thêm toast notifications
- Thêm dynamic pagination
- Thêm real-time filtering

### 3. order.jsp

- Thay thế form submit bằng AJAX calls
- Thêm loading indicators
- Thêm toast notifications
- Thêm dynamic pagination
- Thêm real-time filtering
- Thêm statistics cards
- Thêm modals cho view/edit

## Cấu hình cần thiết

### 1. application.properties

```properties
# Database configuration
spring.datasource.url=jdbc:mysql://localhost:3306/your_database
spring.datasource.username=your_username
spring.datasource.password=your_password

# JPA configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Enable JPA auditing
spring.data.jpa.repositories.enabled=true
```

### 2. Main Application Class

```java
@SpringBootApplication
@EnableJpaAuditing
public class LaptopWebsiteApplication {
    public static void main(String[] args) {
        SpringApplication.run(LaptopWebsiteApplication.class, args);
    }
}
```

## Tính năng chính

### 1. Soft Delete

- Tất cả entities đều có trường `isDeleted` để thực hiện soft delete
- API endpoints hỗ trợ restore deleted items
- Repository methods chỉ trả về items chưa bị xóa

### 2. Real-time Filtering

- Tìm kiếm theo nhiều tiêu chí
- Lọc theo trạng thái, danh mục, vai trò
- Sắp xếp theo nhiều trường
- Phân trang động

### 3. Statistics Dashboard

- Hiển thị thống kê real-time
- Cập nhật tự động khi có thay đổi
- Charts và metrics

### 4. Toast Notifications

- Thông báo thành công/lỗi
- Auto-dismiss sau 3 giây
- Styled với Bootstrap

### 5. Loading Indicators

- Spinner khi tải dữ liệu
- Disable buttons khi đang xử lý
- Progress feedback

### 6. Modal Dialogs

- Create/Edit forms
- View details
- Confirmation dialogs

## Lợi ích

1. **Performance**: Không reload toàn bộ trang
2. **UX**: Phản hồi nhanh, smooth interactions
3. **Scalability**: API endpoints có thể được sử dụng bởi mobile apps
4. **Maintainability**: Code được tổ chức tốt, dễ bảo trì
5. **Flexibility**: Dễ dàng thêm tính năng mới

## Hướng dẫn sử dụng

1. **Khởi động ứng dụng**: Chạy `LaptopWebsiteApplication`
2. **Truy cập admin**: Navigate đến `/admin/product`, `/admin/user`, `/admin/order`
3. **Test AJAX**: Thử các tính năng tìm kiếm, lọc, phân trang
4. **CRUD operations**: Tạo, sửa, xóa items
5. **Statistics**: Xem dashboard statistics

## Troubleshooting

1. **CORS errors**: Đảm bảo `@CrossOrigin` được cấu hình đúng
2. **404 errors**: Kiểm tra URL mapping trong controllers
3. **500 errors**: Kiểm tra database connection và entity mapping
4. **JavaScript errors**: Kiểm tra browser console và network tab

Khi bạn dùng Facebook trên điện thoại:

- App điện thoại → Gọi API → Server Facebook → Trả về dữ liệu → Hiển thị
- Không phải load toàn bộ trang web, chỉ lấy dữ liệu cần thiết
