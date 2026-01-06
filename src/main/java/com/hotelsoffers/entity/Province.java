package com.hotelsoffers.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "provinces")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Province {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_provinces")
    @SequenceGenerator(name = "seq_provinces", sequenceName = "SEQ_PROVINCES", allocationSize = 1)
    private Long id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
}