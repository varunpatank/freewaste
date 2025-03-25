/*
  # Add location and amount columns to waste_locations table

  1. Changes
    - Add `location` column to store the textual location
    - Add `amount` column to store the numeric waste amount
    - Add `image_url` column to store verification images
*/

ALTER TABLE waste_locations
ADD COLUMN IF NOT EXISTS location text NOT NULL DEFAULT '',
ADD COLUMN IF NOT EXISTS amount numeric(10, 2),
ADD COLUMN IF NOT EXISTS image_url text;