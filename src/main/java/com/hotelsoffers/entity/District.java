package com.hotelsoffers.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "districts")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class District {
    
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_districts")
    @SequenceGenerator(name = "seq_districts", sequenceName = "SEQ_DISTRICTS", allocationSize = 1)
    private Long id;
    
    @Column(name = "name", nullable = false, length = 100)
    private String name;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id", nullable = false)
    private Province province;
    
    @Column(name = "is_active", nullable = false)
    private Boolean isActive = true;
}