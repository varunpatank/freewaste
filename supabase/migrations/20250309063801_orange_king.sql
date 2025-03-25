/*
  # Initialize Database Schema

  1. Tables
    - users: Store user information
    - reports: Track waste reports
    - rewards: Manage user rewards
    - collected_wastes: Track waste collection
    - notifications: User notifications
    - transactions: Point transactions
    - waste_locations: Waste collection locations

  2. Security
    - Email uniqueness constraint on users
    - Foreign key constraints for data integrity
*/

-- Drop existing tables if they exist
DROP TABLE IF EXISTS "transactions" CASCADE;
DROP TABLE IF EXISTS "waste_locations" CASCADE;
DROP TABLE IF EXISTS "notifications" CASCADE;
DROP TABLE IF EXISTS "collected_wastes" CASCADE;
DROP TABLE IF EXISTS "rewards" CASCADE;
DROP TABLE IF EXISTS "reports" CASCADE;
DROP TABLE IF EXISTS "users" CASCADE;

-- Create users table
CREATE TABLE IF NOT EXISTS "users" (
  "id" serial PRIMARY KEY NOT NULL,
  "email" varchar(255) NOT NULL UNIQUE,
  "name" varchar(255) NOT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);

-- Create reports table
CREATE TABLE IF NOT EXISTS "reports" (
  "id" serial PRIMARY KEY NOT NULL,
  "user_id" integer NOT NULL REFERENCES "users"("id"),
  "location" text NOT NULL,
  "waste_type" varchar(100) NOT NULL,
  "amount" varchar(100) NOT NULL,
  "image_url" text,
  "verification_result" text,
  "status" varchar(20) DEFAULT 'pending' NOT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL,
  "collector_id" integer REFERENCES "users"("id")
);

-- Create rewards table
CREATE TABLE IF NOT EXISTS "rewards" (
  "id" serial PRIMARY KEY NOT NULL,
  "user_id" integer NOT NULL REFERENCES "users"("id"),
  "points" integer NOT NULL,
  "level" integer DEFAULT 1 NOT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL,
  "updated_at" timestamp DEFAULT now() NOT NULL,
  "is_available" boolean DEFAULT true NOT NULL,
  "description" text,
  "name" varchar(255) NOT NULL,
  "collection_info" text NOT NULL
);

-- Create collected_wastes table
CREATE TABLE IF NOT EXISTS "collected_wastes" (
  "id" serial PRIMARY KEY NOT NULL,
  "report_id" integer NOT NULL REFERENCES "reports"("id"),
  "collector_id" integer NOT NULL REFERENCES "users"("id"),
  "collection_date" timestamp DEFAULT now() NOT NULL,
  "status" varchar(20) NOT NULL
);

-- Create notifications table
CREATE TABLE IF NOT EXISTS "notifications" (
  "id" serial PRIMARY KEY NOT NULL,
  "user_id" integer NOT NULL REFERENCES "users"("id"),
  "message" text NOT NULL,
  "type" varchar(50) NOT NULL,
  "is_read" boolean DEFAULT false NOT NULL,
  "created_at" timestamp DEFAULT now() NOT NULL
);

-- Create transactions table
CREATE TABLE IF NOT EXISTS "transactions" (
  "id" serial PRIMARY KEY NOT NULL,
  "user_id" integer NOT NULL REFERENCES "users"("id"),
  "type" varchar(50) NOT NULL,
  "amount" integer NOT NULL,
  "description" text NOT NULL,
  "date" timestamp DEFAULT now() NOT NULL
);

-- Create waste_locations table
CREATE TABLE IF NOT EXISTS "waste_locations" (
  "id" serial PRIMARY KEY NOT NULL,
  "latitude" numeric(10, 6) NOT NULL,
  "longitude" numeric(10, 6) NOT NULL,
  "title" varchar(255) NOT NULL,
  "description" text NOT NULL,
  "waste_type" varchar(100) NOT NULL,
  "difficulty" varchar(20) NOT NULL,
  "points" integer NOT NULL,
  "status" varchar(20) DEFAULT 'available' NOT NULL,
  "assigned_to" integer REFERENCES "users"("id"),
  "completed_by" integer REFERENCES "users"("id"),
  "created_at" timestamp DEFAULT now() NOT NULL,
  "updated_at" timestamp DEFAULT now() NOT NULL
);