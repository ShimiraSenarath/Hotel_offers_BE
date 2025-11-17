-- Verify database setup
SET PAGESIZE 100
SET LINESIZE 200

PROMPT ========================================
PROMPT Checking Tables
PROMPT ========================================
SELECT table_name FROM user_tables ORDER BY table_name;

PROMPT
PROMPT ========================================
PROMPT Checking Sequences
PROMPT ========================================
SELECT sequence_name, last_number FROM user_sequences ORDER BY sequence_name;

PROMPT
PROMPT ========================================
PROMPT Checking Banks (should have 6)
PROMPT ========================================
SELECT id, name FROM banks ORDER BY id;

PROMPT
PROMPT ========================================
PROMPT Checking Users (should have at least 1)
PROMPT ========================================
SELECT id, email, name, role, is_active FROM users ORDER BY id;

PROMPT
PROMPT ========================================
PROMPT Checking Hotel Offers
PROMPT ========================================
SELECT id, hotel_name, discount, bank_id, card_type FROM hotel_offers ORDER BY id;

PROMPT
PROMPT ========================================
PROMPT Database Setup Complete!
PROMPT ========================================
PROMPT
PROMPT You can now login with:
PROMPT Email: admin@hoteloffers.com
PROMPT Password: admin123
PROMPT

