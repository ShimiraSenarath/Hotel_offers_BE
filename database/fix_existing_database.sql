-- Fix script for existing database
-- This adds missing columns and updates existing data

-- 1. Add is_active column to banks table if it doesn't exist
DECLARE
    column_exists NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO column_exists 
    FROM user_tab_columns 
    WHERE table_name = 'BANKS' AND column_name = 'IS_ACTIVE';
    
    IF column_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE banks ADD is_active NUMBER(1) DEFAULT 1';
        EXECUTE IMMEDIATE 'UPDATE banks SET is_active = 1 WHERE is_active IS NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE banks MODIFY is_active NOT NULL';
        DBMS_OUTPUT.PUT_LINE('Added is_active column to banks table');
    ELSE
        DBMS_OUTPUT.PUT_LINE('is_active column already exists in banks table');
    END IF;
END;
/

-- 2. Update existing banks to ensure is_active is set
UPDATE banks SET is_active = 1 WHERE is_active IS NULL OR is_active = 0;

-- 3. Verify user exists (should already exist)
DECLARE
    user_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO user_count 
    FROM users 
    WHERE email = 'admin@hotelsoffers.com';
    
    IF user_count = 0 THEN
        INSERT INTO users (id, email, name, password, role, is_active) VALUES (
            SEQ_USERS.NEXTVAL, 
            'admin@hotelsoffers.com', 
            'Admin User', 
            '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
            'ADMIN',
            1
        );
        DBMS_OUTPUT.PUT_LINE('Created admin user');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Admin user already exists');
    END IF;
END;
/

-- 4. Insert hotel offers if they don't exist
DECLARE
    offer_count NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO offer_count FROM hotel_offers;
    
    IF offer_count = 0 THEN
        -- Insert sample hotel offers
        INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
            SEQ_HOTEL_OFFERS.NEXTVAL,
            'Cinnamon Grand Colombo',
            'Luxury 5-star hotel in the heart of Colombo with world-class amenities and dining options.',
            'Sri Lanka',
            'Western Province',
            'Colombo',
            'Colombo 03',
            1,
            'CREDIT',
            25,
            DATE '2024-01-01',
            DATE '2025-12-31',
            'Minimum 2 nights stay required. Subject to availability.',
            '/images/hotels/cinnamon-grand.jpg',
            1
        );

        INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
            SEQ_HOTEL_OFFERS.NEXTVAL,
            'Shangri-La Colombo',
            'Premium waterfront hotel offering stunning ocean views and exceptional service.',
            'Sri Lanka',
            'Western Province',
            'Colombo',
            'Colombo 01',
            2,
            'DEBIT',
            20,
            DATE '2024-02-01',
            DATE '2025-11-30',
            'Valid for weekend stays only. Cannot be combined with other offers.',
            '/images/hotels/shangri-la.jpg',
            1
        );

        INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
            SEQ_HOTEL_OFFERS.NEXTVAL,
            'Heritance Kandalama',
            'Eco-luxury hotel nestled in nature, designed by Geoffrey Bawa, with breathtaking views.',
            'Sri Lanka',
            'Central Province',
            'Matale',
            'Dambulla',
            3,
            'CREDIT',
            30,
            DATE '2024-01-01',
            DATE '2025-12-31',
            'Book 3 nights and get 1 night free. Advance booking required.',
            '/images/hotels/heritance-kandalama.jpg',
            1
        );

        INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
            SEQ_HOTEL_OFFERS.NEXTVAL,
            'Jetwing Lighthouse',
            'Stunning beachfront hotel in Galle with colonial charm and modern luxury.',
            'Sri Lanka',
            'Southern Province',
            'Galle',
            'Galle',
            4,
            'CREDIT',
            35,
            DATE '2024-03-01',
            DATE '2025-10-31',
            'Includes breakfast buffet. Peak season surcharge may apply.',
            '/images/hotels/jetwing-lighthouse.jpg',
            1
        );

        INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
            SEQ_HOTEL_OFFERS.NEXTVAL,
            'Anantara Peace Haven',
            'Tranquil beach resort in Tangalle with spa, pools, and fine dining.',
            'Sri Lanka',
            'Southern Province',
            'Hambantota',
            'Tangalle',
            5,
            'DEBIT',
            28,
            DATE '2024-04-01',
            DATE '2025-09-30',
            'Minimum 3 nights stay. Complimentary airport transfer included.',
            '/images/hotels/anantara-tangalle.jpg',
            1
        );

        INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
            SEQ_HOTEL_OFFERS.NEXTVAL,
            'Amaya Hills Kandy',
            'Hillside hotel overlooking Kandy city with traditional architecture and modern comfort.',
            'Sri Lanka',
            'Central Province',
            'Kandy',
            'Kandy',
            6,
            'CREDIT',
            22,
            DATE '2024-01-15',
            DATE '2025-12-15',
            'Early bird discount available. Free city tour included.',
            '/images/hotels/amaya-hills.jpg',
            1
        );
        
        DBMS_OUTPUT.PUT_LINE('Inserted sample hotel offers');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Hotel offers already exist (' || offer_count || ' found)');
    END IF;
END;
/

COMMIT;

-- Show current data counts
SET SERVEROUTPUT ON;
DECLARE
    bank_count NUMBER;
    user_count NUMBER;
    offer_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO bank_count FROM banks;
    SELECT COUNT(*) INTO user_count FROM users;
    SELECT COUNT(*) INTO offer_count FROM hotel_offers;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Database Status:');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Banks: ' || bank_count);
    DBMS_OUTPUT.PUT_LINE('Users: ' || user_count);
    DBMS_OUTPUT.PUT_LINE('Hotel Offers: ' || offer_count);
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/

-- Show sample data
SELECT 'BANKS:' AS info FROM dual;
SELECT id, name, is_active FROM banks ORDER BY id;

SELECT 'USERS:' AS info FROM dual;
SELECT id, email, name, role FROM users ORDER BY id;

SELECT 'HOTEL OFFERS:' AS info FROM dual;
SELECT id, hotel_name, city, discount, card_type FROM hotel_offers ORDER BY id;

