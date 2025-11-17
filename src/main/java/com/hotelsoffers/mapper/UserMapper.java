package com.hotelsoffers.mapper;

import com.hotelsoffers.dto.UserDto;
import com.hotelsoffers.entity.User;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDto toDto(User entity);
}
