-- Fix admin user login issue
-- This will delete and recreate the admin user with correct credentials

PROMPT ========================================
PROMPT Fixing Admin User
PROMPT ========================================

-- Delete existing admin user
DELETE FROM users WHERE email = 'admin@hoteloffers.com';

-- Create fresh admin user
-- Email: admin@hoteloffers.com
-- Password: admin123
INSERT INTO users (id, email, name, password, role, is_active) 
VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hoteloffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN',
    1
);

COMMIT;

PROMPT
PROMPT ========================================
PROMPT User Created Successfully
PROMPT ========================================

-- Verify the user
SELECT 
    id,
    email,
    name,
    role,
    is_active,
    LENGTH(password) as password_length,
    created_at
FROM users 
WHERE email = 'admin@hoteloffers.com';

PROMPT
PROMPT ========================================
PROMPT You can now login with:
PROMPT Email: admin@hoteloffers.com
PROMPT Password: admin123
PROMPT ========================================

