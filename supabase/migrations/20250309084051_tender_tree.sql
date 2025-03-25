/*
  # Add Impact Table and Update Waste Locations

  1. New Tables
    - `impact`
      - `id` (serial, primary key)
      - `total_points` (integer)
      - `total_waste` (numeric)
      - `waste_types` (jsonb)
      - `success_rate` (numeric)
      - `updated_at` (timestamp)

  2. Changes
    - Add success_rate column to track verification success percentage
*/

CREATE TABLE IF NOT EXISTS "impact" (
  "id" serial PRIMARY KEY NOT NULL,
  "total_points" integer NOT NULL DEFAULT 0,
  "total_waste" numeric(10, 2) NOT NULL DEFAULT 0,
  "waste_types" jsonb NOT NULL DEFAULT '{}',
  "success_rate" numeric(5, 2) NOT NULL DEFAULT 0,
  "updated_at" timestamp DEFAULT now() NOT NULL
);

-- Add custom waste location challenges
INSERT INTO "waste_locations" (
  "latitude",
  "longitude",
  "title",
  "description",
  "waste_type",
  "difficulty",
  "points"
) VALUES
  (40.7128, -74.0060, 'Central Park Cleanup', 'Help clean up plastic waste in Central Park. This area sees heavy foot traffic and needs regular maintenance.', 'Plastic', 'Medium', 50),
  (51.5074, -0.1278, 'Thames River Bank', 'River bank cleanup needed. Mix of plastic and organic waste affecting local wildlife.', 'Mixed', 'Hard', 100),
  (35.6762, 139.6503, 'Shibuya Crossing', 'Urban waste collection challenge. High volume of recyclable materials.', 'Recyclables', 'Easy', 30),
  (-33.8688, 151.2093, 'Sydney Harbor', 'Coastal cleanup initiative. Marine debris and plastic waste affecting ocean life.', 'Marine Debris', 'Hard', 120),
  (48.8566, 2.3522, 'Seine Riverfront', 'Historical area needs waste management. Mix of tourist and local waste.', 'Mixed', 'Medium', 60);