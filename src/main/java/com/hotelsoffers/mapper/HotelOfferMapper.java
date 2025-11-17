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
        dto.setCreatedAt(entity.getCreatedAt());
        dto.setUpdatedAt(entity.getUpdatedAt());
        
        // Map location
        LocationDto location = new LocationDto();
        location.setCountry(entity.getCountry());
        location.setProvince(entity.getProvince());
        location.setDistrict(entity.getDistrict());
        location.setCity(entity.getCity());
        dto.setLocation(location);
        
        // Map bank using BankMapper
        if (entity.getBank() != null) {
            dto.setBank(bankMapper.toDto(entity.getBank()));
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
        entity.setCardType(dto.getCardType());
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
        entity.setCardType(dto.getCardType());
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
