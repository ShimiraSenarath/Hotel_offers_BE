-- Quick script to add users to the database
-- Password for all users: admin123
-- BCrypt hash: $2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi

-- Check if users table exists
SELECT COUNT(*) FROM user_tables WHERE table_name = 'USERS';

-- Delete existing users (optional - comment out if you want to keep them)
-- DELETE FROM users;

-- Add Admin User
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hoteloffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN',
    1
);

-- Add Test Admin User
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'test@test.com', 
    'Test Admin', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN',
    1
);

-- Add Regular User
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'user@example.com', 
    'Regular User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'USER',
    1
);

COMMIT;

-- Verify users were created
SELECT id, email, name, role, is_active, created_at 
FROM users 
ORDER BY created_at DESC;

-- Display user count
SELECT role, COUNT(*) as count 
FROM users 
GROUP BY role;

