-- Test password hash and user details
-- This will help debug the authentication issue

-- Show detailed user information
SELECT 
    id,
    email,
    name,
    role,
    is_active,
    LENGTH(password) as password_length,
    SUBSTR(password, 1, 10) as password_start,
    created_at
FROM users 
WHERE email = 'admin@hotelsoffers.com';

-- Test if the password hash looks correct (should start with $2a$)
SELECT 
    CASE 
        WHEN password LIKE '$2a$%' THEN 'CORRECT: Password is BCrypt hashed'
        ELSE 'ERROR: Password is not BCrypt hashed - starts with: ' || SUBSTR(password, 1, 10)
    END as password_check
FROM users 
WHERE email = 'admin@hotelsoffers.com';

-- Show all users to check for duplicates
SELECT 'ALL USERS:' AS info FROM dual;
SELECT id, email, role, is_active FROM users ORDER BY id;

-- Check if there are any inactive users
SELECT 'INACTIVE USERS:' AS info FROM dual;
SELECT id, email, role, is_active FROM users WHERE is_active = 0;
