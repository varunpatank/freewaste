/*
  # Update Schema for Auth0 Integration and Rewards

  1. Changes
    - Update transactions table to use created_at instead of date
    - Add website and code fields to rewards table
    - Add name field as required for rewards
    - Add collection_info field as required for rewards

  2. Security
    - Enable RLS on all tables
    - Add appropriate policies
*/

-- Update transactions table
ALTER TABLE transactions DROP COLUMN IF EXISTS date;
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS created_at timestamptz NOT NULL DEFAULT now();

-- Update rewards table
ALTER TABLE rewards 
ADD COLUMN IF NOT EXISTS name varchar(255) NOT NULL,
ADD COLUMN IF NOT EXISTS collection_info text NOT NULL,
ADD COLUMN IF NOT EXISTS website varchar(255),
ADD COLUMN IF NOT EXISTS code varchar(50);

-- Enable RLS
ALTER TABLE rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

-- Create policies
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