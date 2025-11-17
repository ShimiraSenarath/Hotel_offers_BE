-- Create location tables and insert sample data
-- This script creates countries, provinces, districts, and cities tables with sample data

-- Create sequences
CREATE SEQUENCE SEQ_COUNTRIES START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_PROVINCES START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_DISTRICTS START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_CITIES START WITH 1 INCREMENT BY 1;

-- Create countries table
CREATE TABLE countries (
    id NUMBER(19) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    code VARCHAR2(3) NOT NULL,
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create provinces table
CREATE TABLE provinces (
    id NUMBER(19) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    country_id NUMBER(19) NOT NULL,
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

-- Create districts table
CREATE TABLE districts (
    id NUMBER(19) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    province_id NUMBER(19) NOT NULL,
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (province_id) REFERENCES provinces(id)
);

-- Create cities table
CREATE TABLE cities (
    id NUMBER(19) PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    district_id NUMBER(19) NOT NULL,
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (district_id) REFERENCES districts(id)
);

-- Create indexes
CREATE INDEX idx_provinces_country ON provinces(country_id);
CREATE INDEX idx_districts_province ON districts(province_id);
CREATE INDEX idx_cities_district ON cities(district_id);

-- Insert countries
INSERT INTO countries (id, name, code, is_active) VALUES (SEQ_COUNTRIES.NEXTVAL, 'Sri Lanka', 'LKA', 1);
INSERT INTO countries (id, name, code, is_active) VALUES (SEQ_COUNTRIES.NEXTVAL, 'India', 'IND', 1);
INSERT INTO countries (id, name, code, is_active) VALUES (SEQ_COUNTRIES.NEXTVAL, 'Maldives', 'MDV', 1);
INSERT INTO countries (id, name, code, is_active) VALUES (SEQ_COUNTRIES.NEXTVAL, 'Thailand', 'THA', 1);

-- Insert provinces for Sri Lanka
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Western Province', 1, 1);
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Central Province', 1, 1);
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Southern Province', 1, 1);
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Northern Province', 1, 1);
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Eastern Province', 1, 1);

-- Insert provinces for India
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Tamil Nadu', 2, 1);
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Kerala', 2, 1);
INSERT INTO provinces (id, name, country_id, is_active) VALUES (SEQ_PROVINCES.NEXTVAL, 'Karnataka', 2, 1);

-- Insert districts for Western Province
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Colombo', 1, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Gampaha', 1, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Kalutara', 1, 1);

-- Insert districts for Central Province
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Kandy', 2, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Matale', 2, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Nuwara Eliya', 2, 1);

-- Insert districts for Southern Province
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Galle', 3, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Matara', 3, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Hambantota', 3, 1);

-- Insert districts for Tamil Nadu
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Chennai', 6, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Coimbatore', 6, 1);
INSERT INTO districts (id, name, province_id, is_active) VALUES (SEQ_DISTRICTS.NEXTVAL, 'Madurai', 6, 1);

-- Insert cities for Colombo District
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Colombo', 1, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Dehiwala', 1, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Mount Lavinia', 1, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Moratuwa', 1, 1);

-- Insert cities for Gampaha District
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Negombo', 2, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Katunayake', 2, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Wattala', 2, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Ja-Ela', 2, 1);

-- Insert cities for Kalutara District
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Kalutara', 3, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Panadura', 3, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Horana', 3, 1);

-- Insert cities for Kandy District
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Kandy', 4, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Peradeniya', 4, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Kadugannawa', 4, 1);

-- Insert cities for Galle District
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Galle', 7, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Unawatuna', 7, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Hikkaduwa', 7, 1);

-- Insert cities for Chennai District
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Chennai', 10, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Tambaram', 10, 1);
INSERT INTO cities (id, name, district_id, is_active) VALUES (SEQ_CITIES.NEXTVAL, 'Sriperumbudur', 10, 1);

-- Commit the transaction
COMMIT;

-- Display summary
SELECT 'Location data setup complete!' AS status FROM dual;
SELECT 'COUNTRIES: ' || COUNT(*) AS count FROM countries;
SELECT 'PROVINCES: ' || COUNT(*) AS count FROM provinces;
SELECT 'DISTRICTS: ' || COUNT(*) AS count FROM districts;
SELECT 'CITIES: ' || COUNT(*) AS count FROM cities;