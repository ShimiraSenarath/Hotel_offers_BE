-- Fix password hash for admin user
-- This updates the plain text password to the correct BCrypt hash

-- Check current password
SELECT email, password, LENGTH(password) as password_length FROM users WHERE email = 'admin@hotelsoffers.com';

-- Update password to correct BCrypt hash for 'admin123'
UPDATE users 
SET password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi'
WHERE email = 'admin@hotelsoffers.com';

-- Verify the update
SELECT email, password, LENGTH(password) as password_length FROM users WHERE email = 'admin@hotelsoffers.com';

COMMIT;

-- Show all users
SELECT id, email, name, role, is_active FROM users;
