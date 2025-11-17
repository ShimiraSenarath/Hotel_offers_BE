-- Add is_active column to banks table if it doesn't exist
-- Run this script if you've already created the banks table without the is_active column

-- Add the column
ALTER TABLE banks ADD is_active NUMBER(1) DEFAULT 1;

-- Update existing records to set is_active to true
UPDATE banks SET is_active = 1 WHERE is_active IS NULL;

-- Make the column NOT NULL after updating
ALTER TABLE banks MODIFY is_active NOT NULL;

COMMIT;

-- Verify the change
SELECT * FROM banks;

