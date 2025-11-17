-- Check user details in database
SET LINESIZE 200
SET PAGESIZE 100

PROMPT ========================================
PROMPT Checking User Details
PROMPT ========================================

SELECT 
    id,
    email,
    name,
    role,
    is_active,
    LENGTH(password) as password_length,
    SUBSTR(password, 1, 20) as password_start,
    created_at
FROM users
WHERE email = 'admin@hoteloffers.com';

PROMPT
PROMPT ========================================
PROMPT Checking All Users
PROMPT ========================================

SELECT 
    id,
    email,
    name,
    role,
    is_active
FROM users
ORDER BY id;

