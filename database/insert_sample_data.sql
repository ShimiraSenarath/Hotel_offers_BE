-- Sample Data Insertion Script
-- Run this script to populate your database with initial data
-- Connect as: sqlplus hotelsoffers/520520@localhost:1521/freepdb1

-- Clear existing data (optional - comment out if you want to keep existing data)
-- DELETE FROM hotel_offers;
-- DELETE FROM users;
-- DELETE FROM banks;

-- Reset sequences (optional)
-- DROP SEQUENCE SEQ_BANKS;
-- DROP SEQUENCE SEQ_HOTEL_OFFERS;
-- DROP SEQUENCE SEQ_USERS;
-- CREATE SEQUENCE SEQ_BANKS START WITH 1 INCREMENT BY 1;
-- CREATE SEQUENCE SEQ_HOTEL_OFFERS START WITH 1 INCREMENT BY 1;
-- CREATE SEQUENCE SEQ_USERS START WITH 1 INCREMENT BY 1;

-- Insert Banks
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'Commercial Bank', '/images/banks/commercial-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'Peoples Bank', '/images/banks/peoples-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'Sampath Bank', '/images/banks/sampath-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'HNB', '/images/banks/hnb.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'DFCC Bank', '/images/banks/dfcc-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'NTB', '/images/banks/ntb.png', 1);

-- Insert Admin User (password: admin123)
-- Password is BCrypt hashed
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hotelsoffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN',
    1
);

-- Insert Sample User (password: user123)
INSERT INTO users (id, email, name, password, role, is_active) VALUES (
    SEQ_USERS.NEXTVAL, 
    'user@hotelsoffers.com', 
    'Test User', 
    '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 
    'USER',
    1
);

-- Insert Hotel Offers
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

INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
    SEQ_HOTEL_OFFERS.NEXTVAL,
    'Kingsbury Hotel',
    'Prime waterfront location in Colombo with rooftop pool and multiple dining venues.',
    'Sri Lanka',
    'Western Province',
    'Colombo',
    'Colombo 01',
    1,
    'DEBIT',
    18,
    DATE '2024-05-01',
    DATE '2025-08-31',
    'Valid for stays Sunday to Thursday. Subject to room availability.',
    '/images/hotels/kingsbury.jpg',
    1
);

INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
    SEQ_HOTEL_OFFERS.NEXTVAL,
    'Centara Ceysands Resort',
    'Beachfront resort in Bentota with water sports, spa, and family-friendly amenities.',
    'Sri Lanka',
    'Western Province',
    'Kalutara',
    'Bentota',
    2,
    'CREDIT',
    32,
    DATE '2024-02-01',
    DATE '2025-11-30',
    'All-inclusive package available. Kids stay free.',
    '/images/hotels/centara-bentota.jpg',
    1
);

INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
    SEQ_HOTEL_OFFERS.NEXTVAL,
    'Earl''s Regency Hotel',
    'Boutique hotel in Kandy with lush gardens and personalized service.',
    'Sri Lanka',
    'Central Province',
    'Kandy',
    'Kandy',
    3,
    'DEBIT',
    26,
    DATE '2024-03-15',
    DATE '2025-10-15',
    'Complimentary cultural show tickets. Late checkout available.',
    '/images/hotels/earls-regency.jpg',
    1
);

INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url, is_active) VALUES (
    SEQ_HOTEL_OFFERS.NEXTVAL,
    'Hilton Colombo',
    'Iconic 5-star hotel in the heart of Colombo with executive lounge and conference facilities.',
    'Sri Lanka',
    'Western Province',
    'Colombo',
    'Colombo 02',
    4,
    'CREDIT',
    24,
    DATE '2024-01-01',
    DATE '2025-12-31',
    'Business traveler special. Complimentary Wi-Fi and breakfast.',
    '/images/hotels/hilton-colombo.jpg',
    1
);

COMMIT;

-- Verify data insertion
SELECT 'Banks:' AS table_name, COUNT(*) AS count FROM banks
UNION ALL
SELECT 'Users:', COUNT(*) FROM users
UNION ALL
SELECT 'Hotel Offers:', COUNT(*) FROM hotel_offers;

-- Show sample data
SELECT * FROM banks;
SELECT email, name, role FROM users;
SELECT hotel_name, city, discount, card_type FROM hotel_offers;

