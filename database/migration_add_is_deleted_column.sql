-- Add is_deleted flag to hotel_offers to support soft deletes

ALTER TABLE hotel_offers
  ADD (is_deleted NUMBER(1) DEFAULT 0 NOT NULL);

-- Optional: ensure existing rows are marked as not deleted
UPDATE hotel_offers SET is_deleted = 0 WHERE is_deleted IS NULL;


