package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.*;
import com.hotelsoffers.entity.HotelOffer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class HotelOfferMapper {
    
    @Autowired
    private BankMapper bankMapper;
    
    public HotelOfferDto toDto(HotelOffer entity) {
        if (entity == null) {
            return null;
        }
        
        HotelOfferDto dto = new HotelOfferDto();
        dto.setId(entity.getId());
        dto.setHotelName(entity.getHotelName());
        dto.setDescription(entity.getDescription());
        dto.setCardType(entity.getCardType());
        dto.setDiscount(entity.getDiscount());
        dto.setValidFrom(entity.getValidFrom());
        dto.setValidTo(entity.getValidTo());
        dto.setTerms(entity.getTerms());
        dto.setImageUrl(entity.getImageUrl());
        dto.setIsActive(entity.getIsActive());
        dto.setIsDeleted(entity.getIsDeleted());
        dto.setCreatedAt(entity.getCreatedAt());
        dto.setUpdatedAt(entity.getUpdatedAt());
        
        // Map location
        LocationDto location = new LocationDto();
        location.setCountry(entity.getCountry());
        location.setProvince(entity.getProvince());
        location.setDistrict(entity.getDistrict());
        location.setCity(entity.getCity());
        dto.setLocation(location);
        
        // Map banks (many-to-many)
        if (entity.getBanks() != null && !entity.getBanks().isEmpty()) {
            dto.setBanks(entity.getBanks().stream()
                .map(bankMapper::toDto)
                .toList());
            // Set first bank for backward compatibility
            dto.setBank(bankMapper.toDto(entity.getBanks().get(0)));
        } else if (entity.getBank() != null) {
            // Fallback to old single bank field for backward compatibility
            dto.setBank(bankMapper.toDto(entity.getBank()));
            dto.setBanks(java.util.List.of(bankMapper.toDto(entity.getBank())));
        }
        
        // Map card types
        if (entity.getCardTypes() != null && !entity.getCardTypes().isEmpty()) {
            dto.setCardTypes(entity.getCardTypes());
            // Set first card type for backward compatibility
            dto.setCardType(entity.getCardTypes().get(0));
        } else if (entity.getCardType() != null) {
            // Fallback to old single card type field for backward compatibility
            dto.setCardType(entity.getCardType());
            dto.setCardTypes(java.util.List.of(entity.getCardType()));
        }
        
        return dto;
    }
    
    public HotelOfferDto toDtoWithLocation(HotelOffer entity) {
        return toDto(entity);
    }
    
    public HotelOffer toEntity(CreateHotelOfferDto dto) {
        if (dto == null) {
            return null;
        }
        
        HotelOffer entity = new HotelOffer();
        entity.setHotelName(dto.getHotelName());
        entity.setDescription(dto.getDescription());
        // cardType will be set in the service for each combination
        entity.setDiscount(dto.getDiscount());
        entity.setValidFrom(dto.getValidFrom());
        entity.setValidTo(dto.getValidTo());
        entity.setTerms(dto.getTerms());
        entity.setImageUrl(dto.getImageUrl());
        if (dto.getIsActive() != null) {
            entity.setIsActive(dto.getIsActive());
        }
        
        // Map location fields
        if (dto.getLocation() != null) {
            entity.setCountry(dto.getLocation().getCountry());
            entity.setProvince(dto.getLocation().getProvince());
            entity.setDistrict(dto.getLocation().getDistrict());
            entity.setCity(dto.getLocation().getCity());
        }
        
        return entity;
    }
    
    public HotelOffer toEntityFromCreateDto(CreateHotelOfferDto dto) {
        return toEntity(dto);
    }
    
    public void updateEntity(UpdateHotelOfferDto dto, HotelOffer entity) {
        if (dto == null || entity == null) {
            return;
        }
        
        entity.setHotelName(dto.getHotelName());
        entity.setDescription(dto.getDescription());
        // cardType will be set in the service for each combination
        entity.setDiscount(dto.getDiscount());
        entity.setValidFrom(dto.getValidFrom());
        entity.setValidTo(dto.getValidTo());
        entity.setTerms(dto.getTerms());
        entity.setImageUrl(dto.getImageUrl());
        entity.setIsActive(dto.getIsActive());
        
        // Map location fields
        if (dto.getLocation() != null) {
            entity.setCountry(dto.getLocation().getCountry());
            entity.setProvince(dto.getLocation().getProvince());
            entity.setDistrict(dto.getLocation().getDistrict());
            entity.setCity(dto.getLocation().getCity());
        }
    }
}
