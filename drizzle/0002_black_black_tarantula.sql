DROP TABLE "account";--> statement-breakpoint
DROP TABLE "session";--> statement-breakpoint
DROP TABLE "verification_token";--> statement-breakpoint
ALTER TABLE "users" ALTER COLUMN "total_waste" SET DEFAULT '0';--> statement-breakpoint
ALTER TABLE "rewards" ADD COLUMN "level" integer DEFAULT 1 NOT NULL;--> statement-breakpoint
ALTER TABLE "rewards" ADD COLUMN "name" varchar(255) NOT NULL;--> statement-breakpoint
ALTER TABLE "rewards" ADD COLUMN "description" text;--> statement-breakpoint
ALTER TABLE "rewards" ADD COLUMN "collection_info" text NOT NULL;--> statement-breakpoint
ALTER TABLE "rewards" ADD COLUMN "website" varchar(255);--> statement-breakpoint
ALTER TABLE "rewards" ADD COLUMN "code" varchar(50);--> statement-breakpoint
ALTER TABLE "users" DROP COLUMN IF EXISTS "password";