-- In no_descriptions.sql, write a SQL statement to create a view named no_descriptions that includes all of the columns in the listings table except for description.
CREATE VIEW "no_descriptions" AS
SELECT "id", "property_type", "host_name", "accommodates", "bedrooms"
FROM "listings";
-- In one_bedrooms.sql, write a SQL statement to create a view named one_bedrooms.
-- This view should contain all listings that have exactly one bedroom.
CREATE VIEW "one_bedrooms" AS
SELECT "id", "property_type", "host_name", "accommodates"
FROM "listings"
WHERE "bedrooms" = 1;
-- In available.sql, write a SQL statement to create a view named available.
-- This view should contain all dates that are available at all listings.
CREATE VIEW "available" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", "availabilities"."date", "availabilities"."available"
FROM "listings"
JOIN "availabilities" ON "listings"."id" = "availabilities"."listing_id"
WHERE "availabilities"."available" = 'TRUE';
-- In frequently_reviewed.sql, write a SQL statement to create a view named frequently_reviewed.
-- This view should contain the 100 most frequently reviewed listings, sorted from most- to least-frequently reviewed.
CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id", "listings"."property_type", "listings"."host_name", COUNT("reviews"."comments") AS "reviews"
FROM "listings"
JOIN "reviews" ON "listings"."id" = "reviews"."listing_id"
GROUP BY "reviews"."listing_id"
ORDER BY "reviews" DESC
LIMIT 100;
-- In june_vacancies.sql, write a SQL statement to create a view named june_vacancies.
-- This view should contain all listings and the number of days in June of 2023 that they remained vacant.
CREATE VIEW "june_vacancies" AS
SELECT
"listings"."id",
"listings"."property_type",
"listings"."host_name",
"listings"."accommodates",
COUNT("availabilities"."date") AS "days_vacant"
FROM "listings"
JOIN "availabilities" ON "listings"."id" = "availabilities"."listing_id"
WHERE "availabilities"."date" BETWEEN '2023-06-01' AND '2023-06-30'
AND "availabilities"."available" = 'TRUE'
GROUP BY "listings"."id"
ORDER BY "days_vacant" DESC;