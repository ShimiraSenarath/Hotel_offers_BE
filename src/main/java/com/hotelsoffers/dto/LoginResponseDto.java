package com.hotelsoffers.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LoginResponseDto {
    private String token;
    private String type = "Bearer";
    
    // Constructor with token and type (user info is now in token)
    public LoginResponseDto(String token, String type) {
        this.token = token;
        this.type = type;
    }
}
