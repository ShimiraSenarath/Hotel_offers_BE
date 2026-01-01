package com.hotelsoffers.dto;

import com.hotelsoffers.entity.HotelOffer;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HotelOfferDto {
    private Long id;
    private String hotelName;
    private String description;
    private LocationDto location;
    private List<BankDto> banks;
    private List<HotelOffer.CardType> cardTypes;
    // Keep old fields for backward compatibility
    private BankDto bank;
    private HotelOffer.CardType cardType;
    private Integer discount;
    private LocalDate validFrom;
    private LocalDate validTo;
    private String terms;
    private String imageUrl;
    private Boolean isActive;
    private Boolean isDeleted;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
