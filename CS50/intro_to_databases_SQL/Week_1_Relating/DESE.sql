-- Your colleague is preparing a map of all public schools in Massachusetts.
-- In 1.sql, write a SQL query to find the names and cities of all public schools in Massachusetts.

    -- Keep in mind that not all schools in the schools table are considered traditional public schools.
    -- Massachusetts also recognizes charter schools, which (according to DESE!) are considered distinct.
SELECT "name", "city"
FROM "schools"
WHERE "schools"."type" = 'Public School';
-- Your team is working on archiving old data. 
-- In 2.sql, write a SQL query to find the names of districts that are no longer operational.
    -- Districts that are no longer operational have “(non-op)” at the end of their name.
SELECT "name"
FROM "districts"
WHERE "name" LIKE '%(non-op)';
-- The Massachusetts Legislature would like to learn how much money, on average, districts spent per-pupil last year.
-- In 3.sql, write a SQL query to find the average per-pupil expenditure. Name the column “Average District Per-Pupil Expenditure”.

    -- Note the per_pupil_expenditure column in the expenditures table contains the average amount, per pupil, each district spent last year.
    -- You’ve been asked to find the average of this set of averages, weighting all districts equally regardless of their size.
SELECT AVG("per_pupil_expenditure") AS 'Average District Per-Pupil Expenditure'
FROM "expenditures";
-- Some cities have more public schools than others. 
-- In 4.sql, write a SQL query to find the 10 cities with the most public schools.
-- Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least.
-- If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("type") AS "number of public schools"
FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
ORDER BY "number of public schools" DESC, "city" ASC
LIMIT 10;
-- DESE would like you to determine in what cities additional public schools might be needed.
-- In 5.sql, write a SQL query to find cities with 3 or fewer public schools.
-- Your query should return the names of the cities and the number of public schools within them, ordered from greatest number of public schools to least.
-- If two cities have the same number of public schools, order them alphabetically.
SELECT "city", COUNT("type") AS "number of public schools"
FROM "schools"
WHERE "type" = 'Public School'
GROUP BY "city"
HAVING "number of public schools" <= 3
ORDER BY "number of public schools" DESC, "city" ASC;
-- DESE wants to assess which schools achieved a 100% graduation rate.
-- In 6.sql, write a SQL query to find the names of schools (public or charter!) that reported a 100% graduation rate.
SELECT "schools"."name"
FROM "graduation_rates"
JOIN "schools" ON "schools"."id" = "graduation_rates"."school_id"
WHERE "graduation_rates"."graduated" = 100;
-- DESE is preparing a report on schools in the Cambridge school district.
-- In 7.sql, write a SQL query to find the names of schools (public or charter!) in the Cambridge school district. Keep in mind that Cambridge,
-- the city, contains a few school districts, but DESE is interested in the district whose name is “Cambridge.”
SELECT "schools"."name"
FROM "districts"
JOIN "schools" ON "districts"."id" = "schools"."district_id"
WHERE "districts"."name" = "Cambridge";
-- A parent wants to send their child to a district with many other students.
-- In 8.sql, write a SQL query to display the names of all school districts and the number of pupils enrolled in each.
SELECT "districts"."name", "expenditures"."pupils"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id";
-- Another parent wants to send their child to a district with few other students.
-- In 9.sql, write a SQL query to find the name (or names) of the school district(s) with the single least number of pupils.
-- Report only the name(s).
SELECT "districts"."name"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
ORDER BY "expenditures"."pupils" ASC
LIMIT 1;
-- In Massachusetts, school district expenditures are in part determined by local taxes on property (e.g., home) values.
-- In 10.sql, write a SQL query to find the 10 public school districts with the highest per-pupil expenditures.
-- Your query should return the names of the districts and the per-pupil expenditure for each.
SELECT "districts"."name", "expenditures"."per_pupil_expenditure"
FROM "districts"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
WHERE "districts"."type" = 'Public School District'
ORDER BY "expenditures"."per_pupil_expenditure" DESC
LIMIT 10;
-- Is there a relationship between school expenditures and graduation rates?
-- In 11.sql, write a SQL query to display the names of schools, their per-pupil expenditure, and their graduation rate.
-- Sort the schools from greatest per-pupil expenditure to least. If two schools have the same per-pupil expenditure, sort by school name.

    --You should assume a school spends the same amount per-pupil their district as a whole spends.
SELECT "schools"."name","expenditures"."per_pupil_expenditure", "graduation_rates"."graduated"
FROM "districts"
JOIN "schools" ON "districts"."id" = "schools"."district_id"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
ORDER BY "expenditures"."per_pupil_expenditure" DESC, "schools"."name" ASC;
-- A parent asks you for advice on finding the best public school districts in Massachusetts.
-- In 12.sql, write a SQL query to find public school districts with above-average per-pupil expenditures and an above-average percentage of teachers rated “exemplary”.
-- Your query should return the districts’ names, along with their per-pupil expenditures and percentage of teachers rated exemplary.
-- Sort the results first by the percentage of teachers rated exemplary (high to low), then by the per-pupil expenditure (high to low).
SELECT "districts"."name", "expenditures"."per_pupil_expenditure", "staff_evaluations"."exemplary"
FROM "districts"
JOIN "staff_evaluations" ON "districts"."id" = "staff_evaluations"."district_id"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
-- Find the set of districts with public schools, avoid repetition of districts using DISTINCT
WHERE "districts"."name" IN (SELECT "name"
                             FROM "districts"
                             WHERE "id" IN (SELECT DISTINCT("district_id")
                                            FROM "schools"
                                            WHERE "type" = 'Public School'
                                            )
                            )
-- above-average per_pupil_expenditure
AND "expenditures"."per_pupil_expenditure" > (SELECT AVG("per_pupil_expenditure")
                                                FROM "expenditures"
                                                )
-- per_pupil_expenditure exemplary rating
AND "staff_evaluations"."exemplary" > (SELECT AVG("exemplary")
                                       FROM "staff_evaluations"
                                       )
ORDER BY  "staff_evaluations"."exemplary" DESC, "expenditures"."per_pupil_expenditure" DESC;
-- In 13.sql, write a SQL query to answer a question you have about the data! The query should:
    -- Involve at least one JOIN or subquery
SELECT "schools"."name"AS 'School Name',"districts"."name" AS 'District Name', "staff_evaluations"."needs_improvement", "graduation_rates"."dropped", "expenditures"."per_pupil_expenditure"
FROM "districts"
JOIN "schools" ON "districts"."id" = "schools"."district_id"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
JOIN "expenditures" ON "districts"."id" = "expenditures"."district_id"
JOIN "staff_evaluations" ON "districts"."id" = "staff_evaluations"."district_id"
WHERE "staff_evaluations"."proficient" IS NOT NULL
AND "staff_evaluations"."needs_improvement" > 0
AND "graduation_rates"."dropped" > 0
ORDER BY "staff_evaluations"."needs_improvement" DESC, "graduation_rates"."dropped" DESC;