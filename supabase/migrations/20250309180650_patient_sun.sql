/*
  # Add authentication tables and update users table

  1. Changes
    - Remove clerkId from users table
    - Add password field to users table
    - Add NextAuth.js required tables (account, session, verificationToken)

  2. New Tables
    - account: For OAuth account linking
    - session: For managing user sessions
    - verificationToken: For email verification

  3. Security
    - Enable RLS on all new tables
    - Add appropriate policies
*/

-- Remove clerkId and add password to users table
ALTER TABLE users DROP COLUMN IF EXISTS clerk_id;
ALTER TABLE users ADD COLUMN IF NOT EXISTS password VARCHAR(255);

-- Create account table
CREATE TABLE IF NOT EXISTS account (
  id SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
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
  FOREIGN KEY ("userId") REFERENCES users(id) ON DELETE CASCADE
);

-- Create session table
CREATE TABLE IF NOT EXISTS session (
  id SERIAL PRIMARY KEY,
  "userId" INTEGER NOT NULL,
  expires TIMESTAMP NOT NULL,
  "sessionToken" VARCHAR(255) NOT NULL UNIQUE,
  FOREIGN KEY ("userId") REFERENCES users(id) ON DELETE CASCADE
);

-- Create verification token table
CREATE TABLE IF NOT EXISTS "verificationToken" (
  identifier VARCHAR(255) NOT NULL,
  token VARCHAR(255) NOT NULL,
  expires TIMESTAMP NOT NULL,
  UNIQUE(identifier, token)
);

-- Enable RLS and add policies
ALTER TABLE account ENABLE ROW LEVEL SECURITY;
ALTER TABLE session ENABLE ROW LEVEL SECURITY;
ALTER TABLE "verificationToken" ENABLE ROW LEVEL SECURITY;

-- Policies for account table
CREATE POLICY "Users can manage their own accounts"
  ON account
  FOR ALL
  TO authenticated
  USING ("userId" = current_user_id());

-- Policies for session table
CREATE POLICY "Users can manage their own sessions"
  ON session
  FOR ALL
  TO authenticated
  USING ("userId" = current_user_id());

-- Policies for verification tokens
CREATE POLICY "Users can manage their verification tokens"
  ON "verificationToken"
  FOR ALL
  TO authenticated
  USING (identifier = current_user);