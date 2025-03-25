/*
  # Initial Schema Setup

  1. New Tables
    - users
      - id (serial, primary key)
      - email (varchar, unique)
      - name (varchar)
      - created_at (timestamp)
    
    - waste_locations
      - id (serial, primary key)
      - latitude (decimal)
      - longitude (decimal)
      - title (varchar)
      - description (text)
      - waste_type (varchar)
      - difficulty (varchar)
      - points (integer)
      - status (varchar)
      - assigned_to (integer, foreign key)
      - completed_by (integer, foreign key)
      - created_at (timestamp)
      - updated_at (timestamp)
    
    - rewards
      - id (serial, primary key)
      - user_id (integer, foreign key)
      - points (integer)
      - created_at (timestamp)
    
    - notifications
      - id (serial, primary key)
      - user_id (integer, foreign key)
      - message (text)
      - type (varchar)
      - read (boolean)
      - created_at (timestamp)
    
    - transactions
      - id (serial, primary key)
      - user_id (integer, foreign key)
      - type (varchar)
      - amount (integer)
      - description (text)
      - created_at (timestamp)

  2. Indexes
    - Added indexes on frequently queried columns
    - Added foreign key constraints for referential integrity
*/

-- Create users table
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create waste_locations table
CREATE TABLE IF NOT EXISTS waste_locations (
  id SERIAL PRIMARY KEY,
  latitude DECIMAL(10,6) NOT NULL,
  longitude DECIMAL(10,6) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  waste_type VARCHAR(100) NOT NULL,
  difficulty VARCHAR(20) NOT NULL,
  points INTEGER NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'available',
  assigned_to INTEGER REFERENCES users(id),
  completed_by INTEGER REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create rewards table
CREATE TABLE IF NOT EXISTS rewards (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  points INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create notifications table
CREATE TABLE IF NOT EXISTS notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  message TEXT NOT NULL,
  type VARCHAR(50) NOT NULL,
  read BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create transactions table
CREATE TABLE IF NOT EXISTS transactions (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  type VARCHAR(50) NOT NULL,
  amount INTEGER NOT NULL,
  description TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_waste_locations_status ON waste_locations(status);
CREATE INDEX IF NOT EXISTS idx_notifications_user_unread ON notifications(user_id) WHERE NOT read;
CREATE INDEX IF NOT EXISTS idx_transactions_user_type ON transactions(user_id, type);
CREATE INDEX IF NOT EXISTS idx_rewards_user_date ON rewards(user_id, created_at DESC);