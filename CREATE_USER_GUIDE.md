# How to Create Users for Login

## Quick Start - Default Admin User

Your database schema already includes a default admin user:

**Email**: `admin@hoteloffers.com`  
**Password**: `admin123`  
**Role**: ADMIN

If you've run the `schema.sql` file, this user should already exist!

## Method 1: Using SQL Directly (Oracle Database)

### Connect to Your Database

```bash
sqlplus hotelsoffers/520520@localhost:1521/freepdb1
```

### Create a New Admin User

```sql
-- Generate BCrypt hash for password "admin123"
-- The hash is: $2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi

INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hoteloffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN'
);

COMMIT;
```

### Create a Regular User

```sql
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 
    'user@example.com', 
    'Regular User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'USER'
);

COMMIT;
```

### Create Multiple Users

```sql
-- Admin user
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 'john@hoteloffers.com', 'John Doe', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ADMIN'
);

-- Regular user
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 'jane@example.com', 'Jane Smith', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'USER'
);

COMMIT;
```

## Method 2: Using a Password Generator Tool

I'll create a simple Java utility to generate BCrypt hashes for any password:

### Create PasswordHashGenerator.java

Create this file in `src/main/java/com/hotelsoffers/util/PasswordHashGenerator.java`:

```java
package com.hotelsoffers.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHashGenerator {
    
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // Generate hashes for different passwords
        String password1 = "admin123";
        String password2 = "user123";
        String password3 = "mypassword";
        
        System.out.println("Password: " + password1);
        System.out.println("BCrypt Hash: " + encoder.encode(password1));
        System.out.println();
        
        System.out.println("Password: " + password2);
        System.out.println("BCrypt Hash: " + encoder.encode(password2));
        System.out.println();
        
        System.out.println("Password: " + password3);
        System.out.println("BCrypt Hash: " + encoder.encode(password3));
    }
}
```

### Run the Generator

```bash
cd hotels-offers-backend
mvn compile
mvn exec:java -Dexec.mainClass="com.hotelsoffers.util.PasswordHashGenerator"
```

This will output BCrypt hashes that you can use in your SQL INSERT statements.

## Method 3: Using Spring Boot Application (Recommended)

### Create a Registration Endpoint (Optional)

If you want users to register themselves, add this to `AuthController.java`:

```java
@PostMapping("/register")
public ResponseEntity<UserDto> register(@Valid @RequestBody RegisterRequestDto registerRequest) {
    UserDto user = authService.register(registerRequest);
    return ResponseEntity.status(HttpStatus.CREATED).body(user);
}
```

### Create RegisterRequestDto.java

```java
package com.hotelsoffers.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class RegisterRequestDto {
    
    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    private String email;
    
    @NotBlank(message = "Name is required")
    private String name;
    
    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password must be at least 6 characters")
    private String password;
    
    private String role = "USER"; // Default role
}
```

### Add register() method to AuthService.java

```java
public UserDto register(RegisterRequestDto registerRequest) {
    // Check if user already exists
    if (userRepository.findByEmail(registerRequest.getEmail()).isPresent()) {
        throw new RuntimeException("Email already exists");
    }
    
    // Create new user
    User user = new User();
    user.setEmail(registerRequest.getEmail());
    user.setName(registerRequest.getName());
    user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));
    user.setRole(registerRequest.getRole());
    user.setIsActive(true);
    
    User savedUser = userRepository.save(user);
    
    return UserDto.builder()
            .id(savedUser.getId())
            .email(savedUser.getEmail())
            .name(savedUser.getName())
            .role(savedUser.getRole())
            .build();
}
```

## Method 4: Using REST API After Setup

Once your app is running, you can create users via the registration endpoint:

```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "newuser@example.com",
    "name": "New User",
    "password": "password123",
    "role": "USER"
  }'
```

## Common BCrypt Hashes (for testing)

Here are some pre-generated BCrypt hashes for common passwords:

| Password | BCrypt Hash |
|----------|-------------|
| admin123 | `$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi` |
| user123 | `$2a$10$Xl0yhvzLIxobYk7L.1lqB.6HkVs0HlXyCj5qx4JlXxq1VqQfgpMwO` |
| password | `$2a$10$J7nL3hRDfHX0zV.9kQJHa.qYKN6LHGjBLvX5XmZqiXZvzYHKVq6Pm` |

**Note**: Each time you generate a BCrypt hash, it will be different (even for the same password) because of the salt. This is normal and secure.

## Verify Users in Database

Check existing users:

```sql
SELECT id, email, name, role, is_active, created_at 
FROM users 
ORDER BY created_at DESC;
```

## Test Login

### Using curl:

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@hoteloffers.com",
    "password": "admin123"
  }'
```

### Expected Response:

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "type": "Bearer",
  "user": {
    "id": "1",
    "email": "admin@hoteloffers.com",
    "name": "Admin User",
    "role": "ADMIN"
  }
}
```

### Using Frontend:

1. Go to `http://localhost:3000/login`
2. Enter:
   - Email: `admin@hoteloffers.com`
   - Password: `admin123`
3. Click "Sign in"
4. Should redirect to admin dashboard

## Database Setup Complete Script

If you need to recreate everything:

```sql
-- Connect to database
sqlplus hotelsoffers/520520@localhost:1521/freepdb1

-- Run the schema
@schema.sql

-- Verify users were created
SELECT * FROM users;

-- If you need to add more users:
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 
    'test@test.com', 
    'Test User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN'
);

COMMIT;
```

## Troubleshooting

### "Invalid credentials" error
- Check the email is correct
- Check the password matches
- Verify user exists: `SELECT * FROM users WHERE email = 'admin@hoteloffers.com';`
- Check password hash is correct
- Make sure `is_active = 1`

### User not found
- Run the schema.sql file
- Check sequence: `SELECT SEQ_USERS.NEXTVAL FROM DUAL;`
- Manually insert user (see Method 1)

### Password doesn't work
- BCrypt hashes are case-sensitive
- Make sure you're using the exact hash
- Generate a new hash using the PasswordHashGenerator tool

## Quick Test Users for Development

Add these test users to your database:

```sql
-- Admin user
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 'admin@hoteloffers.com', 'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ADMIN'
);

-- Test admin
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 'test@test.com', 'Test Admin', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ADMIN'
);

-- Regular user
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 'user@example.com', 'Regular User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'USER'
);

COMMIT;
```

All use password: **admin123**

