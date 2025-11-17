package com.hotelsoffers.controller;

import com.hotelsoffers.dto.BankDto;
import com.hotelsoffers.service.BankService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/banks")
@RequiredArgsConstructor
public class BankController {
    
    private final BankService bankService;
    
    @GetMapping
    public ResponseEntity<List<BankDto>> getAllBanks() {
        List<BankDto> banks = bankService.getAllBanks();
        return ResponseEntity.ok(banks);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<BankDto> getBankById(@PathVariable Long id) {
        BankDto bank = bankService.getBankById(id);
        return ResponseEntity.ok(bank);
    }
}
