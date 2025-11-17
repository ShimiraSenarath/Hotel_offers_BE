-- Reset database - WARNING: This will delete all data!
-- Use this only if you want to start fresh

PROMPT ========================================
PROMPT WARNING: This will delete ALL data!
PROMPT Press Ctrl+C to cancel
PROMPT ========================================

-- Drop tables (this will also drop foreign key constraints)
DROP TABLE hotel_offers CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE banks CASCADE CONSTRAINTS;

-- Drop sequences
DROP SEQUENCE SEQ_BANKS;
DROP SEQUENCE SEQ_HOTEL_OFFERS;
DROP SEQUENCE SEQ_USERS;

PROMPT
PROMPT All tables and sequences dropped.
PROMPT Now run schema.sql to recreate:
PROMPT @database/schema.sql
PROMPT

