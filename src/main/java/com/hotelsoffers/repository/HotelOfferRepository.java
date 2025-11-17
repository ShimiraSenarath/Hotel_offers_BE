package com.hotelsoffers.repository;

import com.hotelsoffers.entity.HotelOffer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface HotelOfferRepository extends JpaRepository<HotelOffer, Long> {
    
    Page<HotelOffer> findByIsActiveTrue(Pageable pageable);
    
    @Query("SELECT h FROM HotelOffer h WHERE h.isActive = true " +
           "AND (:country IS NULL OR h.country = :country) " +
           "AND (:province IS NULL OR h.province = :province) " +
           "AND (:district IS NULL OR h.district = :district) " +
           "AND (:city IS NULL OR h.city = :city) " +
           "AND (:bankId IS NULL OR h.bank.id = :bankId) " +
           "AND (:cardType IS NULL OR h.cardType = :cardType) " +
           "AND h.validFrom <= :currentDate AND h.validTo >= :currentDate")
    Page<HotelOffer> findActiveOffersWithFilters(
            @Param("country") String country,
            @Param("province") String province,
            @Param("district") String district,
            @Param("city") String city,
            @Param("bankId") Long bankId,
            @Param("cardType") HotelOffer.CardType cardType,
            @Param("currentDate") LocalDate currentDate,
            Pageable pageable);
    
    List<HotelOffer> findByIsActiveTrueAndValidFromLessThanEqualAndValidToGreaterThanEqual(
            LocalDate validFrom, LocalDate validTo);
}
