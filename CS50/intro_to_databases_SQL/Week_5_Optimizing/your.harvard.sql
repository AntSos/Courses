-- 1.- Find a student’s historical course enrollments, based on their ID:
    -- EXPLAIN QUERY PLAN
    -- SELECT "courses"."title", "courses"."semester"
    -- FROM "enrollments"
    -- JOIN "courses" ON "enrollments"."course_id" = "courses"."id"
    -- JOIN "students" ON "enrollments"."student_id" = "students"."id"
    -- WHERE "students"."id" = 3;
    -- Result:
    -- QUERY PLAN
    --SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
    --SCAN enrollments
    --SEARCH courses USING INTEGER PRIMARY KEY (rowid=?)
CREATE INDEX IF NOT EXISTS "search_students_by_id" ON "students" ("id");

-- 2.- Find all students who enrolled in Computer Science 50 in Fall 2023:
    -- EXPLAIN QUERY PLAN
    -- SELECT "id", "name"
    -- FROM "students"
    -- WHERE "id" IN (
        -- SELECT "student_id"
        -- FROM "enrollments"
        -- WHERE "course_id" = (
            -- SELECT "id"
            -- FROM "courses"
            -- WHERE "courses"."department" = 'Computer Science'
            -- AND "courses"."number" = 50
            -- AND "courses"."semester" = 'Fall 2023'
        -- )
    -- );
-- Result:
-- QUERY PLAN
--SEARCH students USING INTEGER PRIMARY KEY (rowid=?)
--LIST SUBQUERY 2
   --SCAN enrollments
   --SCALAR SUBQUERY 1
     --SCAN courses
   --CREATE BLOOM FILTE
CREATE INDEX IF NOT EXISTS "search_courses" ON "courses" ("id");
CREATE INDEX IF NOT EXISTS "search_enrollments" ON "enrollments" ("course_id");

-- 3.- Sort courses by most- to least-enrolled in Fall 2023:
    -- EXPLAIN QUERY PLAN
    -- SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title", COUNT(*) AS "enrollment"
    -- FROM "courses"
    -- JOIN "enrollments" ON "enrollments"."course_id" = "courses"."id"
    -- WHERE "courses"."semester" = 'Fall 2023'
    -- GROUP BY "courses"."id"
    -- ORDER BY "enrollment" DESC;
-- Result:
-- QUERY PLAN
--SCAN courses
--SEARCH enrollments USING COVERING INDEX search_enrollments (course_id=?)
--USE TEMP B-TREE FOR ORDER BY
-- Done in the previous exercises

-- 4.- Find all computer science courses taught in Spring 2024:
    -- EXPLAIN QUERY PLAN
    -- SELECT "courses"."id", "courses"."department", "courses"."number", "courses"."title"
    -- FROM "courses"
    -- WHERE "courses"."department" = 'Computer Science'
    -- AND "courses"."semester" = 'Spring 2024';
-- Result:
-- QUERY PLAN
--SCAN courses
CREATE INDEX IF NOT EXISTS "search_courses_by_department" ON "courses" ("id");

-- 5.- Find the requirement satisfied by “Advanced Databases” in Fall 2023:
    -- EXPLAIN QUERY PLAN
    -- SELECT "requirements"."name"
    -- FROM "requirements"
    -- WHERE "requirements"."id" = (
        -- SELECT "requirement_id"
        -- FROM "satisfies"
        -- WHERE "course_id" = (
            -- SELECT "id"
            -- FROM "courses"
            -- WHERE "title" = 'Advanced Databases'
            -- AND "semester" = 'Fall 2023'
        -- )
    -- );
-- Result:
-- QUERY PLAN
--SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
--SCALAR SUBQUERY 2
   --SCAN satisfies
   --SCALAR SUBQUERY 1
      --SCAN courses
CREATE INDEX IF NOT EXISTS "search_requirements_by_id" ON "requirements" ("id");
CREATE INDEX IF NOT EXISTS "search_satisfies_by_icourse_id" ON "satisfies" ("course_id");

-- 6.- Find how many courses in each requirement a student has satisfied:
    -- EXPLAIN QUERY PLAN
    -- SELECT "requirements"."name", COUNT(*) AS "courses"
    -- FROM "requirements"
    -- JOIN "satisfies" ON "requirements"."id" = "satisfies"."requirement_id"
    -- WHERE "satisfies"."course_id" IN (
        -- SELECT "course_id"
        -- FROM "enrollments"
        -- WHERE "enrollments"."student_id" = 8
    -- )
    -- GROUP BY "requirements"."name";
-- Result:
-- QUERY PLAN
--SEARCH satisfies USING INDEX search_satisfies_by_icourse_id (course_id=?)
--LIST SUBQUERY 1
  --SCAN enrollments
  --CREATE BLOOM FILTER
--SEARCH requirements USING INTEGER PRIMARY KEY (rowid=?)
--USE TEMP B-TREE FOR GROUP BY
-- Done in the previous exercises

--7.- Search for a course by title and semester:
    -- EXPLAIN QUERY PLAN
    -- SELECT "department", "number", "title"
    -- FROM "courses"
    -- WHERE "title" LIKE "History%"
    -- AND "semester" = 'Fall 2023';
-- Result:
-- QUERY PLAN
--SCAN courses
CREATE INDEX IF NOT EXISTS "search_courses_by_title" ON "courses" ("title");
