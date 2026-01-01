package com.hotelsoffers.service;

import com.hotelsoffers.dto.*;
import com.hotelsoffers.entity.Bank;
import com.hotelsoffers.entity.HotelOffer;
import com.hotelsoffers.mapper.HotelOfferMapper;
import com.hotelsoffers.repository.BankRepository;
import com.hotelsoffers.repository.HotelOfferRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

@Service
@RequiredArgsConstructor
@Transactional
public class HotelOfferService {
    
    private final HotelOfferRepository hotelOfferRepository;
    private final BankRepository bankRepository;
    private final HotelOfferMapper hotelOfferMapper;
    
    @Transactional(readOnly = true)
    public Page<HotelOfferDto> getAllOffers(Pageable pageable) {
        // Admin view & general listing: include all offers (active, inactive, deleted)
        return hotelOfferRepository.findAll(pageable)
                .map(hotelOfferMapper::toDtoWithLocation);
    }
    
    @Transactional(readOnly = true)
    public Page<HotelOfferDto> getOffersWithFilters(
            String country, String province, String district, String city,
            List<Long> bankIds, List<HotelOffer.CardType> cardTypes, Pageable pageable) {
        
        // Convert single values to lists for backward compatibility, or use empty list if null
        List<Long> finalBankIds = (bankIds != null && !bankIds.isEmpty()) ? bankIds : null;
        List<HotelOffer.CardType> finalCardTypes = (cardTypes != null && !cardTypes.isEmpty()) ? cardTypes : null;
        
        // Convert CardType enum list to String list for native query
        List<String> cardTypeStrings = null;
        if (finalCardTypes != null) {
            cardTypeStrings = finalCardTypes.stream()
                .map(Enum::name)
                .toList();
        }
        
        // Use empty list instead of null to avoid SQL issues, and pass flags
        List<Long> bankIdsForQuery = (finalBankIds != null) ? finalBankIds : java.util.Collections.emptyList();
        List<String> cardTypesForQuery = (cardTypeStrings != null) ? cardTypeStrings : java.util.Collections.emptyList();
        int hasBankFilter = (finalBankIds != null) ? 1 : 0;
        int hasCardTypeFilter = (cardTypeStrings != null) ? 1 : 0;
        
        return hotelOfferRepository.findActiveOffersWithFilters(
                country, province, district, city, bankIdsForQuery, cardTypesForQuery, 
                hasBankFilter, hasCardTypeFilter, pageable)
                .map(hotelOfferMapper::toDtoWithLocation);
    }
    
    @Transactional(readOnly = true)
    public HotelOfferDto getOfferById(Long id) {
        HotelOffer offer = hotelOfferRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel offer not found with id: " + id));
        return hotelOfferMapper.toDtoWithLocation(offer);
    }
    
    public HotelOfferDto createOffer(CreateHotelOfferDto createDto) {
        // Create a single offer with multiple banks and card types
        HotelOffer offer = hotelOfferMapper.toEntityFromCreateDto(createDto);
        
        // Fetch all banks
        List<Bank> banks = new ArrayList<>(
            createDto.getBankIds().stream()
                .map(bankId -> bankRepository.findById(bankId)
                    .orElseThrow(() -> new RuntimeException("Bank not found with id: " + bankId)))
                .toList()
        );
        
        offer.setBanks(banks);
        offer.setCardTypes(new ArrayList<>(createDto.getCardTypes()));
        
        // Set first bank and card type for backward compatibility
        if (!banks.isEmpty()) {
            offer.setBank(banks.get(0));
        }
        if (!createDto.getCardTypes().isEmpty()) {
            offer.setCardType(createDto.getCardTypes().get(0));
        }
        
        HotelOffer savedOffer = hotelOfferRepository.save(offer);
        return hotelOfferMapper.toDtoWithLocation(savedOffer);
    }
    
    public HotelOfferDto updateOffer(Long id, UpdateHotelOfferDto updateDto) {
        HotelOffer existingOffer = hotelOfferRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel offer not found with id: " + id));
        
        hotelOfferMapper.updateEntity(updateDto, existingOffer);
        
        // Update banks
        List<Bank> banks = new ArrayList<>(
            updateDto.getBankIds().stream()
                .map(bankId -> bankRepository.findById(bankId)
                    .orElseThrow(() -> new RuntimeException("Bank not found with id: " + bankId)))
                .toList()
        );
        
        existingOffer.setBanks(banks);
        existingOffer.setCardTypes(new ArrayList<>(updateDto.getCardTypes()));
        
        // Set first bank and card type for backward compatibility
        if (!banks.isEmpty()) {
            existingOffer.setBank(banks.get(0));
        }
        if (!updateDto.getCardTypes().isEmpty()) {
            existingOffer.setCardType(updateDto.getCardTypes().get(0));
        }
        
        HotelOffer savedOffer = hotelOfferRepository.save(existingOffer);
        return hotelOfferMapper.toDtoWithLocation(savedOffer);
    }
    
    private CreateHotelOfferDto createDtoFromUpdateDto(UpdateHotelOfferDto updateDto) {
        CreateHotelOfferDto createDto = new CreateHotelOfferDto();
        createDto.setHotelName(updateDto.getHotelName());
        createDto.setDescription(updateDto.getDescription());
        createDto.setLocation(updateDto.getLocation());
        createDto.setDiscount(updateDto.getDiscount());
        createDto.setValidFrom(updateDto.getValidFrom());
        createDto.setValidTo(updateDto.getValidTo());
        createDto.setTerms(updateDto.getTerms());
        createDto.setImageUrl(updateDto.getImageUrl());
        createDto.setIsActive(updateDto.getIsActive());
        return createDto;
    }
    
    public void deleteOffer(Long id) {
        HotelOffer offer = hotelOfferRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel offer not found with id: " + id));
        
        offer.setIsActive(false);
        offer.setIsDeleted(true);
        hotelOfferRepository.save(offer);
    }
    
    @Transactional(readOnly = true)
    public Page<HotelOfferDto> getCurrentValidOffers(Pageable pageable) {
        LocalDate today = LocalDate.now();
        return hotelOfferRepository
                .findByIsDeletedFalseAndIsActiveTrueAndValidFromLessThanEqualAndValidToGreaterThanEqual(
                        today, today, pageable)
                .map(hotelOfferMapper::toDtoWithLocation);
    }
}
