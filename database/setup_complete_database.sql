-- Complete database setup script
-- This creates all tables and populates them with data

-- First, run the location data script
@create_location_data.sql

-- Verify all data is inserted
SELECT 'DATABASE SETUP COMPLETE' AS status FROM dual;

-- Show counts
SELECT 'COUNTRIES:' AS table_name, COUNT(*) AS count FROM countries
UNION ALL
SELECT 'PROVINCES:', COUNT(*) FROM provinces
UNION ALL
SELECT 'DISTRICTS:', COUNT(*) FROM districts
UNION ALL
SELECT 'CITIES:', COUNT(*) FROM cities
UNION ALL
SELECT 'BANKS:', COUNT(*) FROM banks
UNION ALL
SELECT 'USERS:', COUNT(*) FROM users
UNION ALL
SELECT 'HOTEL_OFFERS:', COUNT(*) FROM hotel_offers;

-- Show sample data
SELECT 'SAMPLE COUNTRIES:' AS info FROM dual;
SELECT id, name, code FROM countries ORDER BY name;

SELECT 'SAMPLE PROVINCES:' AS info FROM dual;
SELECT p.id, p.name, c.name as country FROM provinces p 
JOIN countries c ON p.country_id = c.id 
ORDER BY c.name, p.name;

SELECT 'SAMPLE DISTRICTS:' AS info FROM dual;
SELECT d.id, d.name, p.name as province FROM districts d 
JOIN provinces p ON d.province_id = p.id 
ORDER BY p.name, d.name;

SELECT 'SAMPLE CITIES:' AS info FROM dual;
SELECT ci.id, ci.name, d.name as district FROM cities ci 
JOIN districts d ON ci.district_id = d.id 
ORDER BY d.name, ci.name;

SELECT 'SAMPLE BANKS:' AS info FROM dual;
SELECT id, name, logo_url FROM banks ORDER BY name;

SELECT 'SAMPLE USERS:' AS info FROM dual;
SELECT id, email, name, role FROM users ORDER BY role, name;

SELECT 'SAMPLE HOTEL OFFERS:' AS info FROM dual;
SELECT id, hotel_name, city, discount, card_type FROM hotel_offers ORDER BY hotel_name;
