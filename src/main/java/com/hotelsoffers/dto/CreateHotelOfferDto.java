package com.hotelsoffers.dto;

import com.hotelsoffers.entity.HotelOffer;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateHotelOfferDto {
    
    @NotBlank(message = "Hotel name is required")
    @Size(max = 255, message = "Hotel name must not exceed 255 characters")
    private String hotelName;
    
    @NotBlank(message = "Description is required")
    private String description;
    
    @Valid
    @NotNull(message = "Location is required")
    private LocationDto location;
    
    @NotNull(message = "Bank is required")
    private Long bankId;
    
    @NotNull(message = "Card type is required")
    private HotelOffer.CardType cardType;
    
    @NotNull(message = "Discount is required")
    @Min(value = 1, message = "Discount must be at least 1%")
    @Max(value = 100, message = "Discount must not exceed 100%")
    private Integer discount;
    
    @NotNull(message = "Valid from date is required")
    @Future(message = "Valid from date must be in the future")
    private LocalDate validFrom;
    
    @NotNull(message = "Valid to date is required")
    private LocalDate validTo;
    
    @NotBlank(message = "Terms are required")
    private String terms;
    
    @Size(max = 500, message = "Image URL must not exceed 500 characters")
    private String imageUrl;
    
    private Boolean isActive = true;
}
