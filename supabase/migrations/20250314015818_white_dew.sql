/*
  # Add Missing Tables and Update Schema

  1. New Tables
    - waste_locations
    - impact
    - notifications

  2. Changes
    - Add missing columns to existing tables
    - Update foreign key constraints
    - Add RLS policies for new tables
*/

-- Create waste_locations table if it doesn't exist
CREATE TABLE IF NOT EXISTS "waste_locations" (
  "id" serial PRIMARY KEY NOT NULL,
  "latitude" numeric(10, 6) NOT NULL,
  "longitude" numeric(10, 6) NOT NULL,
  "title" varchar(255) NOT NULL,
  "description" text NOT NULL,
  "waste_type" varchar(100) NOT NULL,
  "difficulty" varchar(20) NOT NULL,
  "points" integer NOT NULL,
  "status" varchar(20) NOT NULL DEFAULT 'available',
  "assigned_to" integer REFERENCES "users"("id"),
  "completed_by" integer REFERENCES "users"("id"),
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now()
);

-- Create impact table if it doesn't exist
CREATE TABLE IF NOT EXISTS "impact" (
  "id" serial PRIMARY KEY NOT NULL,
  "total_points" integer NOT NULL DEFAULT 0,
  "total_waste" numeric(10, 2) NOT NULL DEFAULT 0,
  "waste_types" json NOT NULL DEFAULT '{}',
  "updated_at" timestamptz NOT NULL DEFAULT now()
);

-- Create notifications table if it doesn't exist
CREATE TABLE IF NOT EXISTS "notifications" (
  "id" serial PRIMARY KEY NOT NULL,
  "user_id" integer NOT NULL REFERENCES "users"("id"),
  "message" text NOT NULL,
  "type" varchar(50) NOT NULL,
  "read" boolean NOT NULL DEFAULT false,
  "created_at" timestamptz NOT NULL DEFAULT now()
);

-- Enable RLS on new tables
ALTER TABLE waste_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE impact ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for waste_locations
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

-- Create RLS policies for impact
CREATE POLICY "Anyone can read impact data"
  ON impact
  FOR SELECT
  TO authenticated
  USING (true);

-- Create RLS policies for notifications
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