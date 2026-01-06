package com.hotelsoffers.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "cities")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class City {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cities")
    @SequenceGenerator(name = "seq_cities", sequenceName = "SEQ_CITIES", allocationSize = 1)
    private Long id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "district_id", nullable = false)
    private District district;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
}