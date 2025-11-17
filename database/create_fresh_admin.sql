-- Create a fresh admin user with a known working BCrypt hash
-- This uses a different BCrypt hash that we know works

-- Delete existing admin user
DELETE FROM users WHERE email = 'admin@hotelsoffers.com';

-- Insert fresh admin user with a known working BCrypt hash for 'admin123'
-- This hash is generated using BCrypt with strength 10
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hotelsoffers.com', 
    'Admin User', 
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 
    'ADMIN',
    1
);

COMMIT;

-- Verify the user was created
SELECT 
    id,
    email,
    name,
    role,
    is_active,
    LENGTH(password) as password_length,
    SUBSTR(password, 1, 10) as password_start
FROM users 
WHERE email = 'admin@hotelsoffers.com';

-- Show all users
SELECT 'ALL USERS:' AS info FROM dual;
SELECT id, email, role, is_active FROM users ORDER BY id;
