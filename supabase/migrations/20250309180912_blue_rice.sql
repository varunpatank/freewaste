/*
  # Update schema for NextAuth.js integration

  1. Changes to Users Table
    - Add password field
    - Remove clerk_id
    - Keep existing fields (email, name, etc.)

  2. New Tables
    - account: OAuth account connections
    - session: User sessions
    - verificationToken: Email verification

  3. Security
    - Enable RLS on all tables
    - Add appropriate policies
*/

-- Modify users table
ALTER TABLE users DROP COLUMN IF EXISTS clerk_id;
ALTER TABLE users ADD COLUMN IF NOT EXISTS password VARCHAR(255);

-- Create account table
CREATE TABLE IF NOT EXISTS account (
  id SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(255) NOT NULL,
  provider VARCHAR(255) NOT NULL,
  "providerAccountId" VARCHAR(255) NOT NULL,
  refresh_token TEXT,
  access_token TEXT,
  expires_at INTEGER,
  token_type VARCHAR(255),
  scope VARCHAR(255),
  id_token TEXT,
  session_state VARCHAR(255),
  UNIQUE("provider", "providerAccountId")
);

-- Create session table
CREATE TABLE IF NOT EXISTS session (
  id SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  expires TIMESTAMP WITH TIME ZONE NOT NULL,
  "sessionToken" VARCHAR(255) NOT NULL UNIQUE
);

-- Create verification token table
CREATE TABLE IF NOT EXISTS verification_token (
  token VARCHAR(255) NOT NULL,
  identifier VARCHAR(255) NOT NULL,
  expires TIMESTAMP WITH TIME ZONE NOT NULL,
  UNIQUE(identifier, token)
);

-- Enable RLS
ALTER TABLE account ENABLE ROW LEVEL SECURITY;
ALTER TABLE session ENABLE ROW LEVEL SECURITY;
ALTER TABLE verification_token ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can read their own accounts"
  ON account FOR SELECT
  USING ("userId" = (SELECT id FROM users WHERE email = current_user));

CREATE POLICY "Users can manage their own sessions"
  ON session FOR ALL
  USING ("userId" = (SELECT id FROM users WHERE email = current_user));

CREATE POLICY "Allow access to verification tokens"
  ON verification_token FOR ALL
  TO PUBLIC;