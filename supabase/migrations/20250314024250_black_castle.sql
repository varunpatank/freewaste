/*
  # Add level column to rewards table

  1. Changes
    - Add level column to rewards table
    - Set default level to 1
    - Make level column NOT NULL
*/

ALTER TABLE rewards ADD COLUMN IF NOT EXISTS level integer NOT NULL DEFAULT 1;