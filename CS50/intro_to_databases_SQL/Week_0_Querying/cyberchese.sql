--In 1.sql, write a SQL query to list the titles of all episodes in Cyberchase’s original season, Season 1.
SELECT "title"
FROM "episodes"
WHERE "season" = 1;
--In 2.sql, list the season number of, and title of, the first episode of every season.
SELECT "season", "title"
FROM "episodes"
WHERE "episode_in_season" = 1;
--In 3.sql, find the production code for the episode “Hackerized!”.
SELECT "production_code"
FROM "episodes"
WHERE "title" = 'Hackerized!';
--In 4.sql, write a query to find the titles of episodes that do not yet have a listed topic.
SELECT "title"
FROM "episodes"
WHERE "topic" IS NULL;
--In 5.sql, find the title of the holiday episode that aired on December 31st, 2004.
SELECT "title"
FROM "episodes"
WHERE "air_date" = '2004-12-31';
--In 6.sql, list the titles of episodes from season 6 (2008) that were released early, in 2007.
SELECT "title"
FROM "episodes"
WHERE "air_date" LIKE '2007%' AND "season" = 6;
--In 7.sql, write a SQL query to list the titles and topics of all episodes teaching fractions.
SELECT "title", "topic"
FROM "episodes"
WHERE "topic" LIKE '%fractions%';
--In 8.sql, write a query that counts the number of episodes released in the last 6 years, from 2018 to 2023, inclusive
SELECT COUNT("title")
FROM "episodes"
WHERE "air_date" BETWEEN '2018-01-01' AND '2023-12-31';
--In 9.sql, write a query that counts the number of episodes released in Cyberchase’s first 6 years, from 2002 to 2007, inclusive.
SELECT COUNT("title")
FROM "episodes"
WHERE "air_date" BETWEEN '2002-01-01' AND '2007-12-31';
--In 10.sql, write a SQL query to list the ids, titles, and production codes of all episodes. Order the results by production code, from earliest to latest.
SELECT "id", "title", "production_code"
FROM "episodes"
ORDER BY "production_code" ASC;
--In 11.sql, list the titles of episodes from season 5, in reverse alphabetical order.
SELECT "title"
FROM "episodes"
WHERE "season" = 5
ORDER BY "title" DESC;
--In 12.sql, count the number of unique episode titles.
SELECT COUNT(DISTINCT "title")
FROM "episodes";
--In 13.sql, write a SQL query to explore a question of your choice. This query should:
    --Involve at least one condition, using WHERE with AND or OR
SELECT "title", "topic"
FROM "episodes"
WHERE "air_date" BETWEEN '2002-01-01' AND '2019-12-31';