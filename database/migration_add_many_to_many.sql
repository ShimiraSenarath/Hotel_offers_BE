-- Migration script to support multiple banks and card types per hotel offer
-- Run this script to update the database schema

-- Step 1: Create junction tables
CREATE TABLE hotel_offer_banks (
    offer_id NUMBER(19) NOT NULL,
    bank_id NUMBER(19) NOT NULL,
    PRIMARY KEY (offer_id, bank_id),
    CONSTRAINT fk_hob_offer FOREIGN KEY (offer_id) REFERENCES hotel_offers(id) ON DELETE CASCADE,
    CONSTRAINT fk_hob_bank FOREIGN KEY (bank_id) REFERENCES banks(id) ON DELETE CASCADE
);

CREATE TABLE hotel_offer_card_types (
    offer_id NUMBER(19) NOT NULL,
    card_type VARCHAR2(20) NOT NULL CHECK (card_type IN ('CREDIT', 'DEBIT')),
    PRIMARY KEY (offer_id, card_type),
    CONSTRAINT fk_hoct_offer FOREIGN KEY (offer_id) REFERENCES hotel_offers(id) ON DELETE CASCADE
);

-- Step 2: Migrate existing data
-- For each existing offer, create entries in junction tables
INSERT INTO hotel_offer_banks (offer_id, bank_id)
SELECT id, bank_id FROM hotel_offers;

INSERT INTO hotel_offer_card_types (offer_id, card_type)
SELECT id, card_type FROM hotel_offers;

-- Step 3: Create indexes for performance
CREATE INDEX idx_hob_offer ON hotel_offer_banks(offer_id);
CREATE INDEX idx_hob_bank ON hotel_offer_banks(bank_id);
CREATE INDEX idx_hoct_offer ON hotel_offer_card_types(offer_id);

-- Step 4: Make old columns nullable (we'll remove them later after verifying everything works)
-- Note: We keep bank_id and card_type for backward compatibility during migration
-- ALTER TABLE hotel_offers MODIFY bank_id NULL;
-- ALTER TABLE hotel_offers MODIFY card_type NULL;

COMMIT;

