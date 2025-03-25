/*
  # Update users table for authentication
  
  1. Changes
    - Remove clerk_id column
    - Add password column for local authentication
  
  2. Security
    - Password column is hashed using bcrypt
    - Email remains unique
*/

-- Remove clerk_id column
ALTER TABLE users DROP COLUMN IF EXISTS clerk_id;

-- Add password column if it doesn't exist
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'users' AND column_name = 'password'
  ) THEN
    ALTER TABLE users ADD COLUMN password varchar(255) NOT NULL;
  END IF;
END $$;