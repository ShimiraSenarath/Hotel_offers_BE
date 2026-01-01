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
    
    Page<HotelOffer> findByIsDeletedFalse(Pageable pageable);
    
    @Query(value = "SELECT ho.* FROM hotel_offers ho " +
           "WHERE ho.id IN (" +
           "  SELECT DISTINCT ho2.id FROM hotel_offers ho2 " +
           "  WHERE ho2.is_active = 1 " +
           "  AND (:country IS NULL OR ho2.country = :country) " +
           "  AND (:province IS NULL OR ho2.province = :province) " +
           "  AND (:district IS NULL OR ho2.district = :district) " +
           "  AND (:city IS NULL OR ho2.city = :city) " +
           "  AND (CASE WHEN :hasBankFilter = 0 THEN 1 " +
           "            WHEN ho2.id IN (SELECT hob.offer_id FROM hotel_offer_banks hob WHERE hob.bank_id IN (:bankIds)) THEN 1 " +
           "            WHEN ho2.bank_id IS NOT NULL AND ho2.bank_id IN (:bankIds) THEN 1 " +
           "            ELSE 0 END = 1) " +
           "  AND (CASE WHEN :hasCardTypeFilter = 0 THEN 1 " +
           "            WHEN ho2.id IN (SELECT hoct.offer_id FROM hotel_offer_card_types hoct WHERE hoct.card_type IN (:cardTypes)) THEN 1 " +
           "            WHEN ho2.card_type IS NOT NULL AND ho2.card_type IN (:cardTypes) THEN 1 " +
           "            ELSE 0 END = 1)" +
           ")",
           nativeQuery = true,
           countQuery = "SELECT COUNT(DISTINCT ho.id) FROM hotel_offers ho " +
           "WHERE ho.is_active = 1 " +
           "AND (:country IS NULL OR ho.country = :country) " +
           "AND (:province IS NULL OR ho.province = :province) " +
           "AND (:district IS NULL OR ho.district = :district) " +
           "AND (:city IS NULL OR ho.city = :city) " +
           "AND (CASE WHEN :hasBankFilter = 0 THEN 1 " +
           "          WHEN ho.id IN (SELECT hob.offer_id FROM hotel_offer_banks hob WHERE hob.bank_id IN (:bankIds)) THEN 1 " +
           "          WHEN ho.bank_id IS NOT NULL AND ho.bank_id IN (:bankIds) THEN 1 " +
           "          ELSE 0 END = 1) " +
           "AND (CASE WHEN :hasCardTypeFilter = 0 THEN 1 " +
           "          WHEN ho.id IN (SELECT hoct.offer_id FROM hotel_offer_card_types hoct WHERE hoct.card_type IN (:cardTypes)) THEN 1 " +
           "          WHEN ho.card_type IS NOT NULL AND ho.card_type IN (:cardTypes) THEN 1 " +
           "          ELSE 0 END = 1)")
    Page<HotelOffer> findActiveOffersWithFilters(
            @Param("country") String country,
            @Param("province") String province,
            @Param("district") String district,
            @Param("city") String city,
            @Param("bankIds") List<Long> bankIds,
            @Param("cardTypes") List<String> cardTypes,
            @Param("hasBankFilter") int hasBankFilter,
            @Param("hasCardTypeFilter") int hasCardTypeFilter,
            Pageable pageable);
    
    Page<HotelOffer> findByIsDeletedFalseAndIsActiveTrueAndValidFromLessThanEqualAndValidToGreaterThanEqual(
            LocalDate validFrom, LocalDate validTo, Pageable pageable);
}
