package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.BankDto;
import com.hotelsoffers.entity.Bank;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-12-15T23:23:50+0530",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 17.0.12 (Oracle Corporation)"
)
@Component
public class BankMapperImpl implements BankMapper {

    @Override
    public BankDto toDto(Bank entity) {
        if ( entity == null ) {
            return null;
        }

        BankDto bankDto = new BankDto();

        bankDto.setId( entity.getId() );
        bankDto.setName( entity.getName() );
        bankDto.setLogoUrl( entity.getLogoUrl() );

        return bankDto;
    }
}
