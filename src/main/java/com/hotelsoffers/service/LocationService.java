package com.hotelsoffers.service;

import com.hotelsoffers.dto.*;
import com.hotelsoffers.mapper.*;
import com.hotelsoffers.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LocationService {
    
    private final CountryRepository countryRepository;
    private final ProvinceRepository provinceRepository;
    private final DistrictRepository districtRepository;
    private final CityRepository cityRepository;
    
    private final CountryMapper countryMapper;
    private final ProvinceMapper provinceMapper;
    private final DistrictMapper districtMapper;
    private final CityMapper cityMapper;
    
    // Countries
    public List<CountryDto> getAllCountries() {
        return countryMapper.toDtoList(countryRepository.findByIsActiveTrue());
    }
    
    // Provinces
    public List<ProvinceDto> getAllProvinces() {
        return provinceMapper.toDtoList(provinceRepository.findByIsActiveTrue());
    }
    
    public List<ProvinceDto> getProvincesByCountry(Long countryId) {
        return provinceMapper.toDtoList(provinceRepository.findByCountryIdAndIsActiveTrue(countryId));
    }
    
    // Districts
    public List<DistrictDto> getAllDistricts() {
        return districtMapper.toDtoList(districtRepository.findByIsActiveTrue());
    }
    
    public List<DistrictDto> getDistrictsByProvince(Long provinceId) {
        return districtMapper.toDtoList(districtRepository.findByProvinceIdAndIsActiveTrue(provinceId));
    }
    
    // Cities
    public List<CityDto> getAllCities() {
        return cityMapper.toDtoList(cityRepository.findByIsActiveTrue());
    }
    
    public List<CityDto> getCitiesByDistrict(Long districtId) {
        return cityMapper.toDtoList(cityRepository.findByDistrictIdAndIsActiveTrue(districtId));
    }
}