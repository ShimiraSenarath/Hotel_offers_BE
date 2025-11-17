package com.hotelsoffers.controller;

import com.hotelsoffers.dto.*;
import com.hotelsoffers.service.LocationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/locations")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class LocationController {
    
    private final LocationService locationService;
    
    // Countries
    @GetMapping("/countries")
    public ResponseEntity<List<CountryDto>> getAllCountries() {
        List<CountryDto> countries = locationService.getAllCountries();
        return ResponseEntity.ok(countries);
    }
    
    // Provinces
    @GetMapping("/provinces")
    public ResponseEntity<List<ProvinceDto>> getAllProvinces() {
        List<ProvinceDto> provinces = locationService.getAllProvinces();
        return ResponseEntity.ok(provinces);
    }
    
    @GetMapping("/provinces/country/{countryId}")
    public ResponseEntity<List<ProvinceDto>> getProvincesByCountry(@PathVariable Long countryId) {
        List<ProvinceDto> provinces = locationService.getProvincesByCountry(countryId);
        return ResponseEntity.ok(provinces);
    }
    
    // Districts
    @GetMapping("/districts")
    public ResponseEntity<List<DistrictDto>> getAllDistricts() {
        List<DistrictDto> districts = locationService.getAllDistricts();
        return ResponseEntity.ok(districts);
    }
    
    @GetMapping("/districts/province/{provinceId}")
    public ResponseEntity<List<DistrictDto>> getDistrictsByProvince(@PathVariable Long provinceId) {
        List<DistrictDto> districts = locationService.getDistrictsByProvince(provinceId);
        return ResponseEntity.ok(districts);
    }
    
    // Cities
    @GetMapping("/cities")
    public ResponseEntity<List<CityDto>> getAllCities() {
        List<CityDto> cities = locationService.getAllCities();
        return ResponseEntity.ok(cities);
    }
    
    @GetMapping("/cities/district/{districtId}")
    public ResponseEntity<List<CityDto>> getCitiesByDistrict(@PathVariable Long districtId) {
        List<CityDto> cities = locationService.getCitiesByDistrict(districtId);
        return ResponseEntity.ok(cities);
    }
}