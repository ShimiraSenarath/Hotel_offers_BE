-- Clean up duplicate admin users and fix password issues
-- This script will remove duplicates and ensure correct password hash

-- Show all users first
SELECT 'BEFORE CLEANUP:' AS status FROM dual;
SELECT id, email, name, role, is_active, LENGTH(password) as pwd_length FROM users ORDER BY id;

-- Delete the duplicate user (keep the one with correct email)
DELETE FROM users WHERE email = 'admin@hoteloffers.com';

-- Update the remaining admin user to ensure correct password hash
UPDATE users 
SET password = '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi',
    is_active = 1
WHERE email = 'admin@hotelsoffers.com';

-- If no user exists, create one
DECLARE
    user_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO user_count FROM users WHERE email = 'admin@hotelsoffers.com';
    
    IF user_count = 0 THEN
        INSERT INTO users (id, email, name, password, role, is_active) VALUES (
            SEQ_USERS.NEXTVAL, 
            'admin@hotelsoffers.com', 
            'Admin User', 
            '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
            'ADMIN',
            1
        );
        DBMS_OUTPUT.PUT_LINE('Created new admin user');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Updated existing admin user');
    END IF;
END;
/

COMMIT;

-- Show final result
SELECT 'AFTER CLEANUP:' AS status FROM dual;
SELECT id, email, name, role, is_active, LENGTH(password) as pwd_length FROM users ORDER BY id;

-- Test query to verify the user exists and is active
SELECT 'VERIFICATION:' AS status FROM dual;
SELECT 
    CASE 
        WHEN COUNT(*) = 1 THEN 'SUCCESS: Exactly 1 admin user found'
        ELSE 'ERROR: ' || COUNT(*) || ' admin users found'
    END as result
FROM users 
WHERE email = 'admin@hotelsoffers.com' 
AND role = 'ADMIN' 
AND is_active = 1;
