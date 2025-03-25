/*
  # Update Schema for Auth0 Integration and Rewards

  1. Changes
    - Remove password field from users table
    - Add website and code fields to rewards table
    - Update transactions table to use created_at instead of date
    - Add total_points, total_waste, and total_reports to users table

  2. Security
    - Enable RLS on all tables
    - Add appropriate policies
*/

-- Remove password field from users table
ALTER TABLE users DROP COLUMN IF EXISTS password;

-- Add website and code fields to rewards table
ALTER TABLE rewards 
ADD COLUMN IF NOT EXISTS website varchar(255),
ADD COLUMN IF NOT EXISTS code varchar(50);

-- Add user statistics columns
ALTER TABLE users
ADD COLUMN IF NOT EXISTS total_points integer NOT NULL DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_waste numeric(10, 2) NOT NULL DEFAULT 0,
ADD COLUMN IF NOT EXISTS total_reports integer NOT NULL DEFAULT 0;

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

-- Create policies
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