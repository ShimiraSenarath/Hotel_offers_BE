package com.hotelsoffers.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "countries")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Country {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_countries")
    @SequenceGenerator(name = "seq_countries", sequenceName = "SEQ_COUNTRIES", allocationSize = 1)
    private Long id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @Column(name = "code", nullable = false, length = 3)
    private String code;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
}