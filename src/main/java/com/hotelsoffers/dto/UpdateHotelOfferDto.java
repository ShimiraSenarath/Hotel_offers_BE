package com.hotelsoffers.dto;

import com.hotelsoffers.entity.HotelOffer;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateHotelOfferDto {
    
    @NotBlank(message = "Hotel name is required")
    @Size(max = 255, message = "Hotel name must not exceed 255 characters")
    private String hotelName;
    
    @NotBlank(message = "Description is required")
    private String description;
    
    @Valid
    @NotNull(message = "Location is required")
    private LocationDto location;
    
    @NotNull(message = "Banks are required")
    @NotEmpty(message = "At least one bank must be selected")
    private List<Long> bankIds;
    
    @NotNull(message = "Card types are required")
    @NotEmpty(message = "At least one card type must be selected")
    private List<HotelOffer.CardType> cardTypes;
    
    @NotNull(message = "Discount is required")
    @Min(value = 1, message = "Discount must be at least 1%")
    @Max(value = 100, message = "Discount must not exceed 100%")
    private Integer discount;
    
    @NotNull(message = "Valid from date is required")
    private LocalDate validFrom;
    
    @NotNull(message = "Valid to date is required")
    private LocalDate validTo;
    
    @NotBlank(message = "Terms are required")
    private String terms;
    
    @Size(max = 500, message = "Image URL must not exceed 500 characters")
    private String imageUrl;
    
    @JsonProperty("isActive")
    private Boolean isActive;
}
