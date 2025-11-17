package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.CountryDto;
import com.hotelsoffers.entity.Country;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CountryMapper {
    
    public CountryDto toDto(Country country) {
        if (country == null) {
            return null;
        }
        
        CountryDto dto = new CountryDto();
        dto.setId(country.getId());
        dto.setName(country.getName());
        dto.setCode(country.getCode());
        dto.setIsActive(country.getIsActive());
        return dto;
    }
    
    public List<CountryDto> toDtoList(List<Country> countries) {
        if (countries == null) {
            return null;
        }
        
        return countries.stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }
}