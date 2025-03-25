-- Create Impact table
CREATE TABLE IF NOT EXISTS "impact" (
  "id" serial PRIMARY KEY NOT NULL,
  "total_points" integer NOT NULL DEFAULT 0,
  "total_waste" numeric(10, 2) NOT NULL DEFAULT 0,
  "waste_types" jsonb NOT NULL DEFAULT '{}',
  "updated_at" timestamp DEFAULT now() NOT NULL
);