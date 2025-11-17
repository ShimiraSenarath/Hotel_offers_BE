package com.hotelsoffers;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {
    
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        String rawPassword = "admin123";
        String hashedFromDB = "$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi";
        
        System.out.println("Testing BCrypt Password");
        System.out.println("=======================");
        System.out.println("Raw password: " + rawPassword);
        System.out.println("Hash from DB: " + hashedFromDB);
        System.out.println();
        
        boolean matches = encoder.matches(rawPassword, hashedFromDB);
        System.out.println("Password matches: " + matches);
        
        if (!matches) {
            System.out.println("\nERROR: Password does not match!");
            System.out.println("Generating new hash for 'admin123':");
            String newHash = encoder.encode(rawPassword);
            System.out.println(newHash);
            System.out.println("\nUse this SQL to update:");
            System.out.println("UPDATE users SET password = '" + newHash + "' WHERE email = 'admin@hoteloffers.com';");
            System.out.println("COMMIT;");
        } else {
            System.out.println("\nSUCCESS: Password hash is correct!");
        }
    }
}

