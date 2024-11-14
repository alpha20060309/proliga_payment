/*
  Warnings:

  - The values [dynamic,static] on the enum `banner_type` will be removed. If these variants are still used in the database, this will fail.
  - The values [A,B,C,D,E,F] on the enum `forma` will be removed. If these variants are still used in the database, this will fail.
  - The values [uzum] on the enum `pay_system` will be removed. If these variants are still used in the database, this will fail.
  - The values [uzum] on the enum `pay_system_ext` will be removed. If these variants are still used in the database, this will fail.
  - The values [blocked_penalty] on the enum `point_action` will be removed. If these variants are still used in the database, this will fail.
  - The primary key for the `card` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `club` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `competition_name` on the `club` table. All the data in the column will be lost.
  - You are about to drop the column `logo_img` on the `club` table. All the data in the column will be lost.
  - You are about to drop the column `name_ru` on the `news` table. All the data in the column will be lost.
  - You are about to drop the column `canceled_at` on the `pay_balance` table. All the data in the column will be lost.
  - You are about to drop the column `subs_id` on the `pay_balance` table. All the data in the column will be lost.
  - You are about to drop the column `season_id` on the `pay_expense` table. All the data in the column will be lost.
  - You are about to drop the column `autogoal` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `blocked_penalty` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `every_2_missed_goals` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `goal` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `goal_asist` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `is_actualized` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `missed_penalty` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `played_min` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `red_card` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `yellow_card` on the `player` table. All the data in the column will be lost.
  - You are about to drop the column `match_name` on the `player_point` table. All the data in the column will be lost.
  - You are about to drop the column `match_name` on the `player_result` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `prize` table. All the data in the column will be lost.
  - You are about to drop the column `created_by` on the `prize` table. All the data in the column will be lost.
  - You are about to drop the column `deleted_at` on the `prize` table. All the data in the column will be lost.
  - You are about to drop the column `deleted_by` on the `prize` table. All the data in the column will be lost.
  - You are about to drop the column `name_ru` on the `prize` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `prize` table. All the data in the column will be lost.
  - You are about to drop the column `is_exclude` on the `system_language` table. All the data in the column will be lost.
  - You are about to drop the `subscribtion` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `usersub` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `company` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[transaction_id]` on the table `pay_expense` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "forms" AS ENUM ('f3_5_2', 'f3_4_3', 'f4_3_3', 'f5_3_2', 'f5_4_1', 'f4_4_2');

-- AlterEnum
BEGIN;
CREATE TYPE "banner_type_new" AS ENUM ('modal_banner', 'mini_banner', 'big_banner', 'side_banner_right', 'side_banner_left');
ALTER TABLE "banner" ALTER COLUMN "banner_type" TYPE "banner_type_new" USING ("banner_type"::text::"banner_type_new");
ALTER TYPE "banner_type" RENAME TO "banner_type_old";
ALTER TYPE "banner_type_new" RENAME TO "banner_type";
DROP TYPE "banner_type_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "forma_new" AS ENUM ('a3', 'a4', 'a5', 'a2', 'a1');
ALTER TYPE "forma" RENAME TO "forma_old";
ALTER TYPE "forma_new" RENAME TO "forma";
DROP TYPE "forma_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "pay_system_new" AS ENUM ('click', 'payme', 'balance');
ALTER TABLE "pay_expense" ALTER COLUMN "system" TYPE "pay_system_new" USING ("system"::text::"pay_system_new");
ALTER TYPE "pay_system" RENAME TO "pay_system_old";
ALTER TYPE "pay_system_new" RENAME TO "pay_system";
DROP TYPE "pay_system_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "pay_system_ext_new" AS ENUM ('click', 'payme');
ALTER TABLE "pay_balance" ALTER COLUMN "system" TYPE "pay_system_ext_new" USING ("system"::text::"pay_system_ext_new");
ALTER TYPE "pay_system_ext" RENAME TO "pay_system_ext_old";
ALTER TYPE "pay_system_ext_new" RENAME TO "pay_system_ext";
DROP TYPE "pay_system_ext_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "point_action_new" AS ENUM ('is_lineup', 'is_lineup_more_60', 'goal', 'goal_asist', 'missed_penalty', 'every_2_missed_goals', 'red_card', 'yellow_card', 'is_shutout', 'blocked penalty', 'autogoal');
ALTER TABLE "action" ALTER COLUMN "type" TYPE "point_action_new" USING ("type"::text::"point_action_new");
ALTER TYPE "point_action" RENAME TO "point_action_old";
ALTER TYPE "point_action_new" RENAME TO "point_action";
DROP TYPE "point_action_old";
COMMIT;

-- AlterTable
ALTER TABLE "banner" ALTER COLUMN "content_url" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "banner_view" ADD COLUMN     "browser" VARCHAR(255);

-- AlterTable
ALTER TABLE "card" DROP CONSTRAINT "card_pkey";

-- AlterTable
ALTER TABLE "club" DROP CONSTRAINT "_copy_1_copy_1_copy_1_copy_1_copy_1",
DROP COLUMN "competition_name",
DROP COLUMN "logo_img",
ADD COLUMN     "flag_url" VARCHAR(255);

-- AlterTable
ALTER TABLE "news" DROP COLUMN "name_ru";

-- AlterTable
ALTER TABLE "pay_balance" DROP COLUMN "canceled_at",
DROP COLUMN "subs_id",
ALTER COLUMN "reason" SET DATA TYPE VARCHAR(255);

-- AlterTable
ALTER TABLE "pay_expense" DROP COLUMN "season_id",
ADD COLUMN     "perform_time" TIMESTAMPTZ(6),
ADD COLUMN     "reason" VARCHAR(255),
ALTER COLUMN "transaction_id" SET DATA TYPE TEXT,
ADD CONSTRAINT "pay_expense_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "pay_package" ADD CONSTRAINT "pay_package_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "player" DROP COLUMN "autogoal",
DROP COLUMN "blocked_penalty",
DROP COLUMN "every_2_missed_goals",
DROP COLUMN "goal",
DROP COLUMN "goal_asist",
DROP COLUMN "is_actualized",
DROP COLUMN "missed_penalty",
DROP COLUMN "played_min",
DROP COLUMN "red_card",
DROP COLUMN "yellow_card";

-- AlterTable
ALTER TABLE "player_point" DROP COLUMN "match_name";

-- AlterTable
ALTER TABLE "player_result" DROP COLUMN "match_name";

-- AlterTable
ALTER TABLE "prize" DROP COLUMN "created_at",
DROP COLUMN "created_by",
DROP COLUMN "deleted_at",
DROP COLUMN "deleted_by",
DROP COLUMN "name_ru",
DROP COLUMN "updated_at";

-- AlterTable
ALTER TABLE "system_config" ALTER COLUMN "created_at" DROP DEFAULT;

-- AlterTable
ALTER TABLE "system_language" DROP COLUMN "is_exclude";

-- AlterTable
ALTER TABLE "system_notification" ALTER COLUMN "created_at" DROP DEFAULT;

-- DropTable
DROP TABLE "subscribtion";

-- DropTable
DROP TABLE "users";

-- DropTable
DROP TABLE "usersub";

-- CreateTable
CREATE TABLE "goal" (
    "id" SERIAL NOT NULL,
    "player_id" INTEGER,
    "match_id" INTEGER,
    "is_own_goal" SMALLINT,
    "time" VARCHAR(10),
    "is_penalty" SMALLINT,
    "name" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER
);

-- CreateTable
CREATE TABLE "system_table" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255),
    "is_active" BOOLEAN,
    "t_tables" "t_tables",
    "field_hidden" JSONB,
    "field_readonly" JSONB,
    "role" "roles",
    "deny_read" BOOLEAN,
    "deny_edit" BOOLEAN,
    "deny_create" BOOLEAN,
    "deny_delete" BOOLEAN,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6),
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER
);

-- CreateTable
CREATE TABLE "team" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255),
    "user_id" INTEGER,
    "competition_id" INTEGER,
    "formation" "forms" DEFAULT 'f4_3_3',
    "DEF" SMALLINT,
    "MID" SMALLINT,
    "STR" SMALLINT,
    "registered_tour_id" INTEGER,
    "season_id" INTEGER,
    "point" REAL DEFAULT 0,
    "order" INTEGER DEFAULT 0,
    "balance" REAL DEFAULT 100,
    "is_team_created" BOOLEAN NOT NULL DEFAULT false,
    "count_of_transfers" INTEGER DEFAULT 2,
    "transfers_from_one_team" INTEGER DEFAULT 2,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER,
    "last_tour_point" INTEGER DEFAULT 0,

    CONSTRAINT "_copy_1_copy_1_copy_1_copy_1_copy_3" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team_player" (
    "id" SERIAL NOT NULL,
    "player_id" INTEGER,
    "order_number" SMALLINT,
    "is_captain" BOOLEAN DEFAULT false,
    "team_id" INTEGER,
    "position" "player_position",
    "club_id" INTEGER,
    "point" INTEGER,
    "name" VARCHAR(255),
    "price" REAL,
    "tour_id" INTEGER,
    "competition_id" INTEGER,
    "user_id" INTEGER,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER
);

-- CreateTable
CREATE TABLE "team_player_club" (
    "id" BIGSERIAL NOT NULL,
    "team_id" INTEGER,
    "club_id" INTEGER,
    "count" INTEGER,
    "slug" VARCHAR,
    "tour_id" INTEGER,
    "competition_id" INTEGER,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER,
    "name" VARCHAR(255)
);

-- CreateTable
CREATE TABLE "tour" (
    "id" SERIAL NOT NULL,
    "season_id" INTEGER,
    "name" VARCHAR(255),
    "status" "tour_status",
    "competition_id" INTEGER,
    "datetime_start" TIMESTAMPTZ(6),
    "order" INTEGER,
    "datetime_end" TIMESTAMPTZ(0),
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER
);

-- CreateTable
CREATE TABLE "tour_team" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "tour_id" INTEGER,
    "purchased_players" SMALLINT,
    "is_purchase_locked" BOOLEAN,
    "team_id" INTEGER,
    "price" REAL,
    "point" REAL,
    "competition_id" INTEGER,
    "season_id" INTEGER,
    "captain_id" INTEGER,
    "current_count_of_transfers" INTEGER DEFAULT 0,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER,
    "name" VARCHAR(255)
);

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "guid" UUID,
    "company_id" INTEGER,
    "role" "roles" DEFAULT 'user',
    "name" VARCHAR(255),
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255),
    "is_active" BOOLEAN,
    "photo" TEXT,
    "is_super_admin" BOOLEAN,
    "phone_second" VARCHAR(255),
    "phone_telegram" VARCHAR(255),
    "notes" TEXT,
    "is_developer" BOOLEAN,
    "telegram_user" VARCHAR(255),
    "grid_resize" JSONB,
    "grid_drag_drop" JSONB,
    "is_notified" BOOLEAN,
    "sms_code" VARCHAR(255),
    "sms_created_at" TIMESTAMPTZ(6),
    "last_name" TEXT,
    "middle_name" TEXT,
    "gender" TEXT,
    "birth_date" DATE,
    "bio" TEXT,
    "balance" DOUBLE PRECISION DEFAULT 0,
    "created_at" TIMESTAMPTZ(6),
    "updated_at" TIMESTAMPTZ(6),
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER,
    "language" "language" DEFAULT 'uz',
    "enable_notification" BOOLEAN DEFAULT true,
    "phone_verified" BOOLEAN DEFAULT false,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_activity" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "activity" "user_event",
    "team_id" INTEGER,
    "name_uz" TEXT,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER,
    "name_ru" TEXT,
    "name_en" TEXT,
    "tour_id" INTEGER,
    "competition_id" INTEGER,
    "name" VARCHAR(255)
);

-- CreateTable
CREATE TABLE "user_payment" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "in_amount" INTEGER,
    "added_balance" INTEGER,
    "currency" VARCHAR(10),
    "name" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER
);

-- CreateTable
CREATE TABLE "user_player" (
    "id" SERIAL NOT NULL,
    "player_id" INTEGER,
    "user_match_id" INTEGER,
    "is_lineup_11" SMALLINT,
    "played_min" SMALLINT,
    "is_captain" BOOLEAN,
    "name" VARCHAR(255),
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMPTZ(6),
    "created_by" INTEGER,
    "updated_by" INTEGER,
    "deleted_by" INTEGER
);

-- CreateTable
CREATE TABLE "user_prize" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255),
    "competition_id" INTEGER,
    "season_id" INTEGER,
    "team_id" INTEGER,
    "user_id" INTEGER,
    "prize_id" INTEGER,
    "team_point" INTEGER,
    "prize_order" SMALLINT,
    "updated_by" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "name_unique" ON "team"("name");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_idx" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_phone_idx" ON "user"("phone");

-- CreateIndex
CREATE INDEX "name_user_copy1" ON "user"("name");

-- CreateIndex
CREATE UNIQUE INDEX "company_name_key" ON "company"("name");

-- CreateIndex
CREATE INDEX "name_company_copy1" ON "company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "pay_expense_transaction_id_key" ON "pay_expense"("transaction_id");

-- AddForeignKey
ALTER TABLE "banner_view" ADD CONSTRAINT "fk_banner_id" FOREIGN KEY ("banner_id") REFERENCES "banner"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "company" ADD CONSTRAINT "card_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "company" ADD CONSTRAINT "card_deleted_by_fkey" FOREIGN KEY ("deleted_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "company" ADD CONSTRAINT "card_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "competition" ADD CONSTRAINT "card_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "competition" ADD CONSTRAINT "card_deleted_by_fkey" FOREIGN KEY ("deleted_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "competition" ADD CONSTRAINT "card_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "competition" ADD CONSTRAINT "competition_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "country"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "country" ADD CONSTRAINT "country_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "country" ADD CONSTRAINT "country_deleted_by_fkey" FOREIGN KEY ("deleted_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "country" ADD CONSTRAINT "country_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "team" ADD CONSTRAINT "team_competition_id_fkey" FOREIGN KEY ("competition_id") REFERENCES "competition"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "team" ADD CONSTRAINT "team_season_id_fkey" FOREIGN KEY ("season_id") REFERENCES "season"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "team" ADD CONSTRAINT "team_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "user_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "company"("id") ON DELETE SET NULL ON UPDATE SET NULL;

-- RenameIndex
ALTER INDEX "transaction_id" RENAME TO "pay_balance_transaction_id_key";
