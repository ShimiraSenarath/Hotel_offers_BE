package com.hotelsoffers.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "hotel_offers")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class HotelOffer {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "hotel_offer_seq")
    @SequenceGenerator(name = "hotel_offer_seq", sequenceName = "SEQ_HOTEL_OFFERS", allocationSize = 1)
    private Long id;
    
    @Column(name = "hotel_name", nullable = false, length = 255)
    private String hotelName;
    
    @Column(name = "description", columnDefinition = "CLOB")
    private String description;
    
    @Column(name = "country", nullable = false, length = 100)
    private String country;
    
    @Column(name = "province", nullable = false, length = 100)
    private String province;
    
    @Column(name = "district", nullable = false, length = 100)
    private String district;
    
    @Column(name = "city", nullable = false, length = 100)
    private String city;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bank_id", nullable = false)
    private Bank bank;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "card_type", nullable = false, length = 20)
    private CardType cardType;
    
    @Column(name = "discount", nullable = false)
    private Integer discount;
    
    @Column(name = "valid_from", nullable = false)
    private LocalDate validFrom;
    
    @Column(name = "valid_to", nullable = false)
    private LocalDate validTo;
    
    @Column(name = "terms", columnDefinition = "CLOB")
    private String terms;
    
    @Column(name = "image_url", length = 500)
    private String imageUrl;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
    
    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public enum CardType {
        CREDIT, DEBIT
    }
}
