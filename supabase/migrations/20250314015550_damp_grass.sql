/*
  # Update Schema for Auth0 Integration and Data Models

  1. Changes
    - Remove NextAuth.js tables (account, session, verificationToken)
    - Update users table structure
    - Update rewards and transactions tables
    - Add proper RLS policies

  2. Security
    - Enable RLS on all tables
    - Add appropriate policies for Auth0 integration
*/

-- Drop NextAuth.js tables if they exist
DROP TABLE IF EXISTS "account" CASCADE;
DROP TABLE IF EXISTS "session" CASCADE;
DROP TABLE IF EXISTS "verification_token" CASCADE;

-- Update users table
ALTER TABLE users DROP COLUMN IF EXISTS password;
ALTER TABLE users ADD COLUMN IF NOT EXISTS total_points integer NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN IF NOT EXISTS total_waste numeric(10, 2) NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN IF NOT EXISTS total_reports integer NOT NULL DEFAULT 0;

-- Update rewards table
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS name varchar(255) NOT NULL DEFAULT 'Reward';
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS collection_info text NOT NULL DEFAULT 'Standard reward';
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS website varchar(255);
ALTER TABLE rewards ADD COLUMN IF NOT EXISTS code varchar(50);

-- Update transactions table
ALTER TABLE transactions DROP COLUMN IF EXISTS date;
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS created_at timestamptz NOT NULL DEFAULT now();

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

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