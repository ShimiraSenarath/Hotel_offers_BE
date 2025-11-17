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
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class HotelOfferService {
    
    private final HotelOfferRepository hotelOfferRepository;
    private final BankRepository bankRepository;
    private final HotelOfferMapper hotelOfferMapper;
    
    @Transactional(readOnly = true)
    public Page<HotelOfferDto> getAllOffers(Pageable pageable) {
        return hotelOfferRepository.findByIsActiveTrue(pageable)
                .map(hotelOfferMapper::toDtoWithLocation);
    }
    
    @Transactional(readOnly = true)
    public Page<HotelOfferDto> getOffersWithFilters(
            String country, String province, String district, String city,
            Long bankId, HotelOffer.CardType cardType, Pageable pageable) {
        
        return hotelOfferRepository.findActiveOffersWithFilters(
                country, province, district, city, bankId, cardType, LocalDate.now(), pageable)
                .map(hotelOfferMapper::toDtoWithLocation);
    }
    
    @Transactional(readOnly = true)
    public HotelOfferDto getOfferById(Long id) {
        HotelOffer offer = hotelOfferRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel offer not found with id: " + id));
        return hotelOfferMapper.toDtoWithLocation(offer);
    }
    
    public HotelOfferDto createOffer(CreateHotelOfferDto createDto) {
        Bank bank = bankRepository.findById(createDto.getBankId())
                .orElseThrow(() -> new RuntimeException("Bank not found with id: " + createDto.getBankId()));
        
        HotelOffer offer = hotelOfferMapper.toEntityFromCreateDto(createDto);
        offer.setBank(bank);
        
        HotelOffer savedOffer = hotelOfferRepository.save(offer);
        return hotelOfferMapper.toDtoWithLocation(savedOffer);
    }
    
    public HotelOfferDto updateOffer(Long id, UpdateHotelOfferDto updateDto) {
        HotelOffer offer = hotelOfferRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel offer not found with id: " + id));
        
        Bank bank = bankRepository.findById(updateDto.getBankId())
                .orElseThrow(() -> new RuntimeException("Bank not found with id: " + updateDto.getBankId()));
        
        hotelOfferMapper.updateEntity(updateDto, offer);
        offer.setBank(bank);
        
        HotelOffer savedOffer = hotelOfferRepository.save(offer);
        return hotelOfferMapper.toDtoWithLocation(savedOffer);
    }
    
    public void deleteOffer(Long id) {
        HotelOffer offer = hotelOfferRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Hotel offer not found with id: " + id));
        
        offer.setIsActive(false);
        hotelOfferRepository.save(offer);
    }
    
    @Transactional(readOnly = true)
    public List<HotelOfferDto> getCurrentValidOffers() {
        LocalDate today = LocalDate.now();
        return hotelOfferRepository.findByIsActiveTrueAndValidFromLessThanEqualAndValidToGreaterThanEqual(today, today)
                .stream()
                .map(hotelOfferMapper::toDtoWithLocation)
                .toList();
    }
}
