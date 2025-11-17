package com.hotelsoffers.service;

import com.hotelsoffers.dto.BankDto;
import com.hotelsoffers.mapper.BankMapper;
import com.hotelsoffers.repository.BankRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BankService {
    
    private final BankRepository bankRepository;
    private final BankMapper bankMapper;
    
    public List<BankDto> getAllBanks() {
        return bankRepository.findByIsActiveTrue()
                .stream()
                .map(bankMapper::toDto)
                .toList();
    }
    
    public BankDto getBankById(Long id) {
        return bankRepository.findById(id)
                .map(bankMapper::toDto)
                .orElseThrow(() -> new RuntimeException("Bank not found with id: " + id));
    }
}
