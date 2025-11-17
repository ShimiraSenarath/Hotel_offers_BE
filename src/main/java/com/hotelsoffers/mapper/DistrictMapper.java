package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.DistrictDto;
import com.hotelsoffers.entity.District;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class DistrictMapper {
    
    public DistrictDto toDto(District district) {
        if (district == null) {
            return null;
        }
        
        DistrictDto dto = new DistrictDto();
        dto.setId(district.getId());
        dto.setName(district.getName());
        dto.setProvinceId(district.getProvince() != null ? district.getProvince().getId() : null);
        dto.setIsActive(district.getIsActive());
        return dto;
    }
    
    public List<DistrictDto> toDtoList(List<District> districts) {
        if (districts == null) {
            return null;
        }
        
        return districts.stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }
}