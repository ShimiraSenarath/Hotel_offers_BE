package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.CityDto;
import com.hotelsoffers.entity.City;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CityMapper {
    
    public CityDto toDto(City city) {
        if (city == null) {
            return null;
        }
        
        CityDto dto = new CityDto();
        dto.setId(city.getId());
        dto.setName(city.getName());
        dto.setDistrictId(city.getDistrict() != null ? city.getDistrict().getId() : null);
        dto.setIsActive(city.getIsActive());
        return dto;
    }
    
    public List<CityDto> toDtoList(List<City> cities) {
        if (cities == null) {
            return null;
        }
        
        return cities.stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }
}