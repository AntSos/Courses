-- Terminal line comand to import data from the csv file:
.import --csv meteorites.csv "meteorites_temp"
-- Meteorites table
CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" FLOAT,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" FLOAT,
    "long" FLOAT,
    PRIMARY KEY("id")
);
-- Delete relict meteorites
DELETE FROM "meteorites_temp"
WHERE "nametype" = 'Relict';
-- Update year NULL values
UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = '';
-- Update mass NULL values
UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = '';
-- Update lat NULL values
UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = '';
-- Update long NULL values
UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = '';
-- Round "mass" to two decimals
UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2)
WHERE "mass" IS NOT NULL;
-- Round "lat" to two decimals
UPDATE "meteorites_temp"
SET "lat" = ROUND("lat", 2)
WHERE "lat" IS NOT NULL;
-- Round "lat" to two decimals
UPDATE "meteorites_temp"
SET "long" = ROUND("long", 2)
WHERE "long" IS NOT NULL;
--Insert Values from the temp table to the final
INSERT INTO "meteorites"
("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name",  "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year" ASC, "name" ASC;
-- Drop temporatl table
DROP TABLE "meteorites_temp";
