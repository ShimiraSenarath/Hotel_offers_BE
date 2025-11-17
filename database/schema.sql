-- Hotels Offers Database Schema
-- Oracle Database

-- Create sequence for IDs
CREATE SEQUENCE SEQ_BANKS START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_HOTEL_OFFERS START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_USERS START WITH 1 INCREMENT BY 1;

-- Banks table
CREATE TABLE banks (
    id NUMBER(19) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    logo_url VARCHAR2(500),
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users table
CREATE TABLE users (
    id NUMBER(19) PRIMARY KEY,
    email VARCHAR2(255) UNIQUE NOT NULL,
    name VARCHAR2(255) NOT NULL,
    password VARCHAR2(255) NOT NULL,
    role VARCHAR2(20) DEFAULT 'USER' CHECK (role IN ('ADMIN', 'USER')),
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hotel offers table
CREATE TABLE hotel_offers (
    id NUMBER(19) PRIMARY KEY,
    hotel_name VARCHAR2(255) NOT NULL,
    description CLOB,
    country VARCHAR2(100) NOT NULL,
    province VARCHAR2(100) NOT NULL,
    district VARCHAR2(100) NOT NULL,
    city VARCHAR2(100) NOT NULL,
    bank_id NUMBER(19) NOT NULL,
    card_type VARCHAR2(20) NOT NULL CHECK (card_type IN ('CREDIT', 'DEBIT')),
    discount NUMBER(3) NOT NULL CHECK (discount >= 1 AND discount <= 100),
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    terms CLOB,
    image_url VARCHAR2(500),
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hotel_offers_bank FOREIGN KEY (bank_id) REFERENCES banks(id)
);

-- Create indexes for better performance
CREATE INDEX idx_hotel_offers_location ON hotel_offers(country, province, district, city);
CREATE INDEX idx_hotel_offers_bank ON hotel_offers(bank_id);
CREATE INDEX idx_hotel_offers_card_type ON hotel_offers(card_type);
CREATE INDEX idx_hotel_offers_active ON hotel_offers(is_active);
CREATE INDEX idx_hotel_offers_dates ON hotel_offers(valid_from, valid_to);

-- Insert sample banks
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'Commercial Bank', '/images/banks/commercial-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'Peoples Bank', '/images/banks/peoples-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'Sampath Bank', '/images/banks/sampath-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'HNB', '/images/banks/hnb.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'DFCC Bank', '/images/banks/dfcc-bank.png', 1);
INSERT INTO banks (id, name, logo_url, is_active) VALUES (SEQ_BANKS.NEXTVAL, 'NTB', '/images/banks/ntb.png', 1);

-- Insert sample admin user (password: admin123)
INSERT INTO users (id, email, name, password, role) VALUES (
    SEQ_USERS.NEXTVAL, 
    'admin@hotelsoffers.com', 
    'Admin User', 
    '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 
    'ADMIN'
);

-- Insert sample hotel offers
INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url) VALUES (
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
    DATE '2024-12-31',
    'Minimum 2 nights stay required. Subject to availability.',
    '/images/hotels/cinnamon-grand.jpg'
);

INSERT INTO hotel_offers (id, hotel_name, description, country, province, district, city, bank_id, card_type, discount, valid_from, valid_to, terms, image_url) VALUES (
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
    DATE '2024-11-30',
    'Valid for weekend stays only. Cannot be combined with other offers.',
    '/images/hotels/shangri-la.jpg'
);

COMMIT;
