-- Users table
CREATE TABLE IF NOT EXISTS "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);
-- Schools table
CREATE TABLE IF NOT EXISTS "universities" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "type" TEXT NOT NULL CHECK("type" IN( 'Elementary School', 'Middle School', 'High School', 'Lower School', 'Upper School', 'College', 'University', 'Other')),
    "address" TEXT NOT NULL,
    "foundation_date" NUMERIC NOT NULL,
    PRIMARY KEY ("id")
);
-- Companies table
CREATE TABLE IF NOT EXISTS "companies" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "industry" TEXT NOT NULL CHECK("industry" IN ('Education', 'Technology', 'Finance')),
    "address" TEXT NOT NULL,
    PRIMARY KEY ("id")
);
-- People connections table
CREATE TABLE IF NOT EXISTS "people_connections" (
    "id" INTEGER,
    "id_user_fk" INTEGER NOT NULL,
    "id_following_fk" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_user_fk") REFERENCES "users" ("id"),
    FOREIGN KEY ("id_following_fk") REFERENCES "users" ("id")
);
-- Schools connection
CREATE TABLE IF NOT EXISTS "schools_connections" (
    "id" INTEGER,
    "id_user_fk" INTEGER NOT NULL,
    "id_school_fk" INTEGER NOT NULL,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC NOT NULL,
    "degree" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_user_fk") REFERENCES "users" ("id"),
    FOREIGN KEY ("id_school_fk") REFERENCES "schools" ("id")
);
-- Companies connection
CREATE TABLE IF NOT EXISTS "companies_connections" (
    "id" INTEGER,
    "id_user_fk" INTEGER NOT NULL,
    "id_companie_fk" INTEGER NOT NULL,
    "start_date" NUMERIC NOT NULL,
    "end_date" NUMERIC NOT NULL,
    "title" TEXT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_user_fk") REFERENCES "users" ("id"),
    FOREIGN KEY ("id_companie_fk") REFERENCES "schools" ("id")
);
