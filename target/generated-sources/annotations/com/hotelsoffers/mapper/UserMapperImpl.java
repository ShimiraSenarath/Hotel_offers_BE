package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.UserDto;
import com.hotelsoffers.entity.User;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-12-15T23:23:50+0530",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 17.0.12 (Oracle Corporation)"
)
@Component
public class UserMapperImpl implements UserMapper {

    @Override
    public UserDto toDto(User entity) {
        if ( entity == null ) {
            return null;
        }

        UserDto userDto = new UserDto();

        userDto.setId( entity.getId() );
        userDto.setEmail( entity.getEmail() );
        userDto.setName( entity.getName() );
        userDto.setRole( entity.getRole() );
        userDto.setIsActive( entity.getIsActive() );
        userDto.setCreatedAt( entity.getCreatedAt() );
        userDto.setUpdatedAt( entity.getUpdatedAt() );

        return userDto;
    }
}
