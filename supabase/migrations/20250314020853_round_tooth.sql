/*
  # Update Schema for Auth0 Integration

  1. Changes
    - Remove NextAuth.js related tables
    - Update users table structure
    - Add new fields to rewards table
    - Update transactions table

  2. Security
    - Enable RLS on all tables
    - Add appropriate policies
*/

-- Drop NextAuth.js related tables
DROP TABLE IF EXISTS "account" CASCADE;
DROP TABLE IF EXISTS "session" CASCADE;
DROP TABLE IF EXISTS "verification_token" CASCADE;

-- Update users table
ALTER TABLE users DROP COLUMN IF EXISTS password;
ALTER TABLE users ADD COLUMN IF NOT EXISTS total_points integer NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN IF NOT EXISTS total_waste numeric(10, 2) NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN IF NOT EXISTS total_reports integer NOT NULL DEFAULT 0;

-- Update rewards table
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS level integer NOT NULL DEFAULT 1;
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS name varchar(255) NOT NULL;
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS description text;
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS collection_info text NOT NULL;
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS website varchar(255);
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS code varchar(50);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE waste_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE impact ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can read their own data"
  ON users
  FOR SELECT
  TO authenticated
  USING (auth.uid()::text = id::text);

CREATE POLICY "Users can read all rewards"
  ON rewards
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can manage their own rewards"
  ON rewards
  FOR ALL
  TO authenticated
  USING (user_id = auth.uid()::integer);

CREATE POLICY "Users can read their own transactions"
  ON transactions
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid()::integer);

CREATE POLICY "Users can create their own transactions"
  ON transactions
  FOR INSERT
  TO authenticated
  WITH CHECK (user_id = auth.uid()::integer);

CREATE POLICY "Users can read their own notifications"
  ON notifications
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid()::integer);

CREATE POLICY "Users can update their own notifications"
  ON notifications
  FOR UPDATE
  TO authenticated
  USING (user_id = auth.uid()::integer);

CREATE POLICY "Anyone can read waste locations"
  ON waste_locations
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can update assigned waste locations"
  ON waste_locations
  FOR UPDATE
  TO authenticated
  USING (assigned_to = auth.uid()::integer);

CREATE POLICY "Anyone can read impact data"
  ON impact
  FOR SELECT
  TO authenticated
  USING (true);