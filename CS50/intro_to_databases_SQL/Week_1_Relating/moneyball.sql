-- You should start by getting a sense for how average player salaries have changed over time.
-- In 1.sql, write a SQL query to find the average player salary by year.
    -- Sort by year in descending order.
    -- Round the salary to two decimal places and call the column “average salary”.
    -- Your query should return a table with two columns, one for year and one for average salary.
SELECT "year", ROUND(AVG("salary"), 2) AS 'average salary'
FROM "salaries"
GROUP BY "year"
ORDER BY "year" DESC;
-- Your general manager (i.e., the person who makes decisions about player contracts) asks you whether the team should trade a current player for Cal Ripken Jr.,
-- a star player who’s likely nearing his retirement.
-- In 2.sql, write a SQL query to find Cal Ripken Jr.’s salary history.
    -- Sort by year in descending order.
    -- Your query should return a table with two columns, one for year and one for salary.
SELECT "salaries"."year", "salaries"."salary"
FROM "salaries"
JOIN "players" ON "salaries"."player_id" = "players"."id"
WHERE "players"."first_name" LIKE '%Cal%'
AND "players"."last_name" LIKE '%Ripken%'
GROUP BY "salaries"."year"
ORDER BY "salaries"."year" DESC;
-- Your team is going to need a great home run hitter. Ken Griffey Jr., a long-time Silver Slugger and Gold Glove award winner, might be a good prospect.
-- In 3.sql, write a SQL query to find Ken Griffey Jr.’s home run history.
    -- Sort by year in descending order.
    -- Note that there may be two players with the name “Ken Griffey.” This Ken Griffey was born in 1969.
    -- Your query should return a table with two columns, one for year and one for home runs.
SELECT "performances"."year", "performances"."HR"
FROM "players"
JOIN "performances" ON "performances"."player_id" = "players"."id"
WHERE "players"."first_name" LIKE '%Ken%'
AND "players"."last_name" LIKE '%Griffey%'
AND "players"."birth_year" = 1969
ORDER BY "performances"."year" DESC;
-- You need to make a recommendation about which players the team should consider hiring.
-- With the team’s dwindling budget, the general manager wants to know which players were paid the lowest salaries in 2001.
-- In 4.sql, write a SQL query to find the 50 players paid the least in 2001.
    -- Sort players by salary, lowest to highest.
    -- If two players have the same salary, sort alphabetically by first name and then by last name.
    -- If two players have the same first and last name, sort by player ID.
    -- Your query should return three columns, one for players’ first names, one for their last names, and one for their salaries.
SELECT "players"."first_name", "players"."last_name", "salaries"."salary"
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
WHERE "salaries"."year" = 2001
ORDER BY "salaries"."salary" ASC,
"players"."first_name" ASC,
"players"."last_name" ASC,
"players"."id" ASC;
-- It’s a bit of a slow day in the office. Though Satchel no longer plays,
-- in 5.sql, write a SQL query to find all teams that Satchel Paige played for.
    -- Your query should return a table with a single column, one for the name of the teams.
SELECT DISTINCT("teams"."name")
FROM "players"
JOIN "performances" ON "players"."id" = "performances"."player_id"
JOIN "teams" ON "performances"."team_id" = "teams"."id"
WHERE "players"."first_name" LIKE '%Satchel%'
OR "players"."last_name" LIKE '%Satchel%';
-- Which teams might be the biggest competition for the A’s this year?
-- In 6.sql, write a SQL query to return the top 5 teams, sorted by the total number of hits by players in 2001.
    -- Call the column representing total hits by players in 2001 “total hits”.
    -- Sort by total hits, highest to lowest.
    -- Your query should return two columns, one for the teams’ names and one for their total hits in 2001.
SELECT "teams"."name", SUM("performances"."H") AS 'total hits'
FROM "teams"
JOIN "performances" ON "performances"."team_id" = "teams"."id"
WHERE "performances"."year" = 2001
GROUP BY "teams"."name"
ORDER BY "total hits" DESC
LIMIT 5;
-- You need to make a recommendation about which player (or players) to avoid recruiting.
-- In 7.sql, write a SQL query to find the name of the player who’s been paid the highest salary,
-- of all time, in Major League Baseball.
    -- Your query should return a table with two columns, one for the player’s first name and one for their last name.
SELECT "players"."first_name", "players"."last_name"
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
ORDER BY "salaries"."salary" DESC
LIMIT 1;
-- How much would the A’s need to pay to get the best home run hitter this past season?
-- In 8.sql, write a SQL query to find the 2001 salary of the player who hit the most home runs in 2001.
    -- Your query should return a table with one column, the salary of the player.
SELECT "salary"
FROM "salaries"
WHERE "player_id" = (SELECT "player_id"
                     FROM "performances"
                     WHERE "HR" = (SELECT MAX("HR")
                                   FROM "performances"
                                   WHERE "year" = 2001
                                   )
                     )
AND "year" = 2001
LIMIT 1;
-- What salaries are other teams paying?
-- In 9.sql, write a SQL query to find the 5 lowest paying teams (by average salary) in 2001.
    -- Round the average salary column to two decimal places and call it “average salary”.
    -- Sort the teams by average salary, least to greatest.
    -- Your query should return a table with two columns, one for the teams’ names and one for their average salary.
SELECT "teams"."name", ROUND(AVG("salaries"."salary"), 2) AS 'average salary'
FROM "salaries"
JOIN "teams" ON "salaries"."team_id" = "teams"."id"
WHERE "salaries"."year" = 2001
GROUP BY "teams"."name"
ORDER BY "average salary" ASC
LIMIT 5;
-- The general manager has asked you for a report which details each player’s name, their salary for each year they’ve been playing,
-- and their number of home runs for each year they’ve been playing. To be precise, the table should include:
    -- All player’s first names
    -- All player’s last names
    -- All player’s salaries
    -- All player’s home runs
    -- The year in which the player was paid that salary and hit those home runs
SELECT "players"."first_name", "players"."last_name", "salaries"."salary", "performances"."HR", "performances"."year"
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
JOIN "performances" ON "players"."id" = "performances"."player_id"
AND "performances"."year" = "salaries"."year"
ORDER BY "players"."id" ASC, "performances"."year" DESC, "salaries"."year" DESC, "performances"."HR" DESC, "salaries"."salary" DESC;
-- You need a player that can get hits. Who might be the most underrated?
-- In 11.sql, write a SQL query to find the 10 least expensive players per hit in 2001.

    -- Your query should return a table with three columns, one for the players’ first names, one of their last names, and one called “dollars per hit”.
    -- You can calculate the “dollars per hit” column by dividing a player’s 2001 salary by the number of hits they made in 2001. Recall you can use AS to rename a column.
    -- Dividing a salary by 0 hits will result in a NULL value. Avoid the issue by filtering out players with 0 hits.
    -- Sort the table by the “dollars per hit” column, least to most expensive. If two players have the same “dollars per hit”, order by first name, followed by last name, in alphabetical order.
    -- As in 10.sql, ensure that the salary’s year and the performance’s year match.
    -- You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
SELECT "players"."first_name", "players"."last_name", "salaries"."salary"/"performances"."H" AS 'dollars per hit'
FROM "players"
JOIN "salaries" ON "players"."id" = "salaries"."player_id"
JOIN "performances" ON "players"."id" = "performances"."player_id"
AND "performances"."year" = "salaries"."year"
WHERE "performances"."H" != 0
AND "salaries"."year" = 2001
ORDER BY "dollars per hit" ASC, "players"."first_name" ASC, "players"."last_name" ASC
LIMIT 10;
-- Hits are great, but so are RBIs!
-- In 12.sql, write a SQL query to find the players among the 10 least expensive players per hit and among the 10 least expensive players per RBI in 2001.
    --Your query should return a table with two columns, one for the players’ first names and one of their last names.
    -- You can calculate a player’s salary per RBI by dividing their 2001 salary by their number of RBIs in 2001.
    -- You may assume, for simplicity, that a player will only have one salary and one performance in 2001.
    -- Order your results by player ID, least to greatest (or alphabetically by last name, as both are the same in this case!).
    -- Keep in mind the lessons you’ve learned in 10.sql and 11.sql!
SELECT "first_name", "last_name"
FROM "players"
WHERE "id" IN (-- Dollars per hit set
               SELECT "salaries"."player_id"
               FROM "salaries"
               JOIN "performances" ON "salaries"."player_id" = "performances"."player_id"
               AND "performances"."year" = "salaries"."year"
               WHERE "salaries"."year" = 2001
               AND "performances"."H" != 0
               ORDER BY "salaries"."salary"/"performances"."H" ASC
               LIMIT 10
               )
-- Intersect queries sets
INTERSECT

SELECT "first_name", "last_name"
FROM "players"
WHERE "id" IN (-- Dollars per RBI set
               SELECT "salaries"."player_id"
               FROM "salaries"
               JOIN "performances" ON "salaries"."player_id" = "performances"."player_id"
               AND "performances"."year" = "salaries"."year"
               WHERE "salaries"."year" = 2001
               AND "performances"."RBI" != 0
               ORDER BY "salaries"."salary"/"performances"."RBI" ASC
               LIMIT 10
               )
-- Order them only, by "last_name" 
ORDER BY "last_name" ASC;
