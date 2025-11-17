package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.BankDto;
import com.hotelsoffers.entity.Bank;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BankMapper {
    BankDto toDto(Bank entity);
}
