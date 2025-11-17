package com.hotelsoffers.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Scanner;

/**
 * Utility class to generate BCrypt password hashes
 * 
 * Usage:
 * mvn compile
 * mvn exec:java -Dexec.mainClass="com.hotelsoffers.util.PasswordHashGenerator"
 */
public class PasswordHashGenerator {
    
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("=".repeat(60));
        System.out.println("BCrypt Password Hash Generator");
        System.out.println("=".repeat(60));
        System.out.println();
        
        while (true) {
            System.out.print("Enter password (or 'exit' to quit): ");
            String password = scanner.nextLine().trim();
            
            if (password.equalsIgnoreCase("exit") || password.equalsIgnoreCase("quit")) {
                System.out.println("Goodbye!");
                break;
            }
            
            if (password.isEmpty()) {
                System.out.println("Password cannot be empty!");
                continue;
            }
            
            String hash = encoder.encode(password);
            
            System.out.println();
            System.out.println("Password: " + password);
            System.out.println("BCrypt Hash: " + hash);
            System.out.println();
            System.out.println("SQL INSERT Statement:");
            System.out.println("-".repeat(60));
            System.out.println("INSERT INTO users (id, email, name, password, role) VALUES (");
            System.out.println("    SEQ_USERS.NEXTVAL,");
            System.out.println("    'user@example.com',  -- Change this");
            System.out.println("    'User Name',          -- Change this");
            System.out.println("    '" + hash + "',");
            System.out.println("    'USER'                -- Or 'ADMIN'");
            System.out.println(");");
            System.out.println("COMMIT;");
            System.out.println("-".repeat(60));
            System.out.println();
        }
        
        scanner.close();
    }
}

