-- In private.sql, you should write all SQL statements required to replicate your creation of the view. That is:
-- If creating the view requires creating a separate table and inserting data into it, you should ensure that private.sql
-- contains the statements to create that table and insert that data. (Don’t be afraid to add tables and add data as you wish!)
-- private.sql, when run a fresh instance of private.db, should be able to fully reconstruct your view.
CREATE TABLE IF NOT EXISTS "triplets" (
    "sentence_id" INTEGER NOT NULL,
    "character_number" INTEGER NOT NULL,
    "length" INTEGER NOT NULL
);
INSERT INTO "triplets"
("sentence_id", "character_number", "length")
VALUES
(14, 98, 4),
(114, 3, 5),
(618, 72, 9),
(630, 7, 3),
(932, 12, 5),
(2230, 50, 7),
(2346, 44, 10),
(3041, 14, 5);
-- Turns out that SQLite handily comes with a function that implements the very functionality of the book cipher:
-- substr. The function substr takes three inputs (“arguments”):
    -- A string (i.e., text) from which to take a substring (i.e., a subset of the string’s characters)
    -- The starting character of the substring, identified by its number (the first character is 1)
    -- The length of the substring
CREATE VIEW "message" AS
SELECT substr("sentences"."sentence", "triplets"."character_number", "triplets"."length") AS "phrase"
FROM "triplets"
JOIN "sentences" ON "triplets"."sentence_id" = "sentences"."id";