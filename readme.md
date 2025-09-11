### Laptop Website — Spring Boot 3, JPA, JSP, REST API

Ứng dụng quản trị bán laptop (JSP admin) với REST API trên Spring Boot 3, JPA/Hibernate, MySQL. Hỗ trợ phân trang, lọc, sắp xếp cho Sản phẩm, Người dùng, Đơn hàng.

## Công nghệ

- **Java** 17, **Spring Boot** 3.5.x (Web, Data JPA, Validation, Security)
- **MySQL** 8, **Hibernate** (MySQL8Dialect, auditing)
- **JSP/JSTL** cho giao diện quản trị
- **Maven** (kèm `mvnw`, `mvnw.cmd`), **Lombok**

## Cấu trúc chính

```text
src/main/java/com/votrithuc/laptop_website/
  ├─ LaptopWebsiteApplication.java
  ├─ config/ (Security, WebConfig)
  ├─ controllers/
  │  ├─ api/ (Product, User, Order REST)
  │  └─ view/ (AdminViewController)
  ├─ domain/ (entity, DTO)
  ├─ mapper/ (MapStruct/tự viết)
  ├─ repositories/ (Spring Data JPA)
  └─ services/ (interface + impl)
src/main/webapp/
  └─ WEB-INF/view/admin/ (JSP quản trị)
```

## Yêu cầu

- JDK 17+, MySQL 8.x
- Maven 3.9+ (khuyên dùng `mvnw`/`mvnw.cmd`)

## Cấu hình nhanh

Chỉnh `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/laptop_website?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=123456
spring.jpa.hibernate.ddl-auto=update
server.port=8080
```

Tạo database `laptop_website` (có thể tham khảo `laptop_website/database_setup.sql`).

## Chạy nhanh

Windows:

```bash
./mvnw.cmd spring-boot:run
```

macOS/Linux:

```bash
./mvnw spring-boot:run
```

Mặc định: `http://localhost:8080/`

## API chính (tóm tắt)

- **Products** `/api/products`
  - GET danh sách: `page`, `size`, `searchName`, `brand`, `category`, `sortBy`
  - GET chi tiết: `/api/products/{id}`
  - POST tạo, PUT cập nhật, DELETE xóa
- **Users** `/api/users`
  - GET danh sách: `page`, `size`, `searchName`, `searchRole`, `searchStatus`, `sortBy`, `sortDir`
  - GET chi tiết, POST, PUT, DELETE, PATCH `/toggle-status`, GET `/count`
- **Orders** `/api/orders`
  - GET danh sách: `page`, `size`, bộ lọc trạng thái/thanhtoán, sắp xếp
  - GET chi tiết, PUT `/status`, PUT `/payment-status`, DELETE (soft), GET `/statistics`

## Build & chạy JAR

```bash
./mvnw clean package -DskipTests
java -jar target/laptop_website-0.0.1-SNAPSHOT.jar --server.port=8080
```

## Ghi chú bảo mật (dev → prod)

- Cấu hình hiện `permitAll`, tắt CSRF cho mục đích dev. Khi triển khai cần bật xác thực/CSRF và phân quyền theo vai trò.
- Không dùng tài khoản `root` MySQL ở production. Dùng biến môi trường/profiles cho thông tin nhạy cảm.

## Troubleshooting nhanh

- Không kết nối DB: kiểm tra URL/user/pass và MySQL đã chạy.
- Lỗi Lombok: bật Annotation Processing trong IDE.
- JSP 404: đảm bảo view nằm đúng `src/main/webapp/WEB-INF/view/...` và tên khớp controller.
