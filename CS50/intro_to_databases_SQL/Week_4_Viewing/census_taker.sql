-- In rural.sql, write a SQL statement to create a view named rural. 
-- This view should contain all census records relating to a rural municipality 
-- (identified by including “rural” in their name). 
-- Ensure the view contains all of the columns from the census table.
CREATE VIEW "rural" AS
SELECT *
FROM "census"
WHERE "locality" LIKE '%rural%';
-- In total.sql, write a SQL statement to create a view named total. 
-- This view should contain the sums for each numeric column in census, across all districts and localities.
CREATE VIEW "total" AS
SELECT SUM("families") AS "families", SUM("households") AS "households", SUM("population") AS "population", SUM("male") AS "male", SUM("female") AS "female"
FROM "census";
-- In by_district.sql, write a SQL statement to create a view named by_district. 
-- This view should contain the sums for each numeric column in census, grouped by district. 
CREATE VIEW "by_district" AS
SELECT "district", SUM("families") AS "families", SUM("households") AS "households", SUM("population") AS "population", SUM("male") AS "male", SUM("female") AS "female"
FROM "census"
GROUP BY "district";
-- In most_populated.sql, write a SQL statement to create a view named most_populated. 
-- This view should contain, in order from greatest to least, the most populated districts in Nepal.
CREATE VIEW "most_populated" AS
SELECT "district", "families", "households", "population", "male", "female"
FROM "census"
ORDER BY "population" DESC;

