package com.votrithuc.laptop_website.repositories;

import com.votrithuc.laptop_website.domain.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {

    // Tìm đơn hàng chưa bị xóa
    List<Order> findByIsDeletedFalse();

    // Tìm đơn hàng theo mã đơn hàng
    Optional<Order> findByOrderCodeAndIsDeletedFalse(String orderCode);

    // Tìm đơn hàng theo trạng thái
    List<Order> findByStatusAndIsDeletedFalse(Order.OrderStatus status);

    // Tìm đơn hàng theo trạng thái thanh toán
    List<Order> findByPaymentStatusAndIsDeletedFalse(Order.PaymentStatus paymentStatus);

    // Tìm đơn hàng theo user
    List<Order> findByUserAndIsDeletedFalse(com.votrithuc.laptop_website.domain.entity.User user);

    // Tìm đơn hàng theo receiver name
    List<Order> findByReceiverNameContainingIgnoreCaseAndIsDeletedFalse(String receiverName);

    // Tìm đơn hàng theo receiver phone
    List<Order> findByReceiverPhoneContainingAndIsDeletedFalse(String receiverPhone);

    // Tìm đơn hàng theo receiver email
    List<Order> findByReceiverEmailContainingIgnoreCaseAndIsDeletedFalse(String receiverEmail);

    // Soft delete
    @Modifying
    @Query("UPDATE Order o SET o.isDeleted = true WHERE o.id = :id")
    void softDeleteById(@Param("id") Long id);

    // Restore
    @Modifying
    @Query("UPDATE Order o SET o.isDeleted = false WHERE o.id = :id")
    void restoreById(@Param("id") Long id);

    // Đếm đơn hàng theo trạng thái
    @Query("SELECT COUNT(o) FROM Order o WHERE o.status = :status AND o.isDeleted = false")
    Long countByStatus(@Param("status") Order.OrderStatus status);

    // Đếm đơn hàng theo trạng thái thanh toán
    @Query("SELECT COUNT(o) FROM Order o WHERE o.paymentStatus = :paymentStatus AND o.isDeleted = false")
    Long countByPaymentStatus(@Param("paymentStatus") Order.PaymentStatus paymentStatus);

    // Tổng doanh thu theo tháng
    @Query("SELECT SUM(o.finalPrice) FROM Order o WHERE o.status = 'DELIVERED' AND o.paymentStatus = 'PAID' AND o.isDeleted = false AND YEAR(o.createdAt) = :year AND MONTH(o.createdAt) = :month")
    Double getTotalRevenueByMonth(@Param("year") int year, @Param("month") int month);

    // Đếm tổng số đơn hàng chưa bị xóa
    @Query("SELECT COUNT(o) FROM Order o WHERE o.isDeleted = false")
    long countByIsDeletedFalse();

    // Tổng doanh thu
    @Query("SELECT SUM(o.finalPrice) FROM Order o WHERE o.status = 'DELIVERED' AND o.paymentStatus = 'PAID' AND o.isDeleted = false")
    Double getTotalRevenue();

    // Doanh thu theo trạng thái đơn hàng
    @Query("SELECT o.status, SUM(o.finalPrice), COUNT(o) FROM Order o WHERE o.paymentStatus = 'PAID' AND o.isDeleted = false GROUP BY o.status")
    List<Object[]> getRevenueByOrderStatus();
}