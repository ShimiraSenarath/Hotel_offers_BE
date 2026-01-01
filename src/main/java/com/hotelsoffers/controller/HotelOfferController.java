package com.hotelsoffers.controller;

import com.hotelsoffers.dto.*;
import com.hotelsoffers.entity.HotelOffer;
import com.hotelsoffers.service.HotelOfferService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/offers")
@RequiredArgsConstructor
public class HotelOfferController {
    
    private final HotelOfferService hotelOfferService;
    
    @GetMapping
    public ResponseEntity<Page<HotelOfferDto>> getAllOffers(Pageable pageable) {
        Page<HotelOfferDto> offers = hotelOfferService.getAllOffers(pageable);
        return ResponseEntity.ok(offers);
    }
    
    @GetMapping("/search")
    public ResponseEntity<Page<HotelOfferDto>> searchOffers(
            @RequestParam(required = false) String country,
            @RequestParam(required = false) String province,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) List<Long> bankId,
            @RequestParam(required = false) List<HotelOffer.CardType> cardType,
            Pageable pageable) {
        
        Page<HotelOfferDto> offers = hotelOfferService.getOffersWithFilters(
                country, province, district, city, bankId, cardType, pageable);
        return ResponseEntity.ok(offers);
    }
    
    @GetMapping("/current")
    public ResponseEntity<Page<HotelOfferDto>> getCurrentValidOffers(Pageable pageable) {
        // Current valid offers: active and within valid date range
        Page<HotelOfferDto> offers = hotelOfferService.getCurrentValidOffers(pageable);
        return ResponseEntity.ok(offers);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<HotelOfferDto> getOfferById(@PathVariable Long id) {
        HotelOfferDto offer = hotelOfferService.getOfferById(id);
        return ResponseEntity.ok(offer);
    }
    
    @PostMapping
    public ResponseEntity<?> createOffer(@Valid @RequestBody CreateHotelOfferDto createDto) {
        HotelOfferDto offer = hotelOfferService.createOffer(createDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(offer);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<HotelOfferDto> updateOffer(
            @PathVariable Long id, 
            @Valid @RequestBody UpdateHotelOfferDto updateDto) {
        HotelOfferDto offer = hotelOfferService.updateOffer(id, updateDto);
        return ResponseEntity.ok(offer);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOffer(@PathVariable Long id) {
        hotelOfferService.deleteOffer(id);
        return ResponseEntity.noContent().build();
    }
}
