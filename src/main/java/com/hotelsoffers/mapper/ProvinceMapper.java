package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.ProvinceDto;
import com.hotelsoffers.entity.Province;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class ProvinceMapper {
    
    public ProvinceDto toDto(Province province) {
        if (province == null) {
            return null;
        }
        
        ProvinceDto dto = new ProvinceDto();
        dto.setId(province.getId());
        dto.setName(province.getName());
        dto.setCountryId(province.getCountry() != null ? province.getCountry().getId() : null);
        dto.setIsActive(province.getIsActive());
        return dto;
    }
    
    public List<ProvinceDto> toDtoList(List<Province> provinces) {
        if (provinces == null) {
            return null;
        }
        
        return provinces.stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }
}