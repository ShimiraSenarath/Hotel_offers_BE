package com.hotelsoffers.repository;

import com.hotelsoffers.entity.Province;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProvinceRepository extends JpaRepository<Province, Long> {
    List<Province> findByIsActiveTrue();
    List<Province> findByCountryIdAndIsActiveTrue(Long countryId);
}