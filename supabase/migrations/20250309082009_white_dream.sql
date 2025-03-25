/*
  # Add Impact Table

  1. New Tables
    - `impact`
      - `id` (serial, primary key)
      - `total_points` (integer)
      - `total_waste` (numeric)
      - `waste_types` (json)
      - `updated_at` (timestamp)

  This migration adds a new table to track overall impact metrics.
*/

CREATE TABLE IF NOT EXISTS "impact" (
  "id" serial PRIMARY KEY NOT NULL,
  "total_points" integer DEFAULT 0 NOT NULL,
  "total_waste" numeric(10, 2) DEFAULT 0 NOT NULL,
  "waste_types" json DEFAULT '{}' NOT NULL,
  "updated_at" timestamp DEFAULT now() NOT NULL
);