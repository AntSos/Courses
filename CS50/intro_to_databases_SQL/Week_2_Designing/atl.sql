-- Airlines table
CREATE TABLE IF NOT EXISTS "airlines" (
    "id", INTEGER,
    "name" NOT NULL UNIQUE,
    "concourse" NOT NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'E', 'F', 'T')),
    PRIMARY KEY ("id")
);
-- Passengers table
CREATE TABLE IF NOT EXISTS "passengers" (
    "id" INTEGER,
    "first_name", TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "id_ticket_fk" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_ticket_fk") REFERENCES "tickets" ("id")
);
-- Tickets table
CREATE TABLE IF NOT EXISTS "tickets" (
    "id" INTEGER,
    "id_flight_fk" INTEGER NOT NULL,
    "id_passenger_fk" INTEGER NOT NULL,
    "value" FLOAT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_flight_fk") REFERENCES "flights" ("id"),
    FOREIGN KEY ("id_passenger_fk") REFERENCES "passengers" ("id")
);
-- Flights table
CREATE TABLE IF NOT EXISTS "flights" (
    "id" INTEGER,
    "number" INTEGER NOT NULL,
    "departing_airport_code" TEXT NOT NULL UNIQUE,
    "heading_airport_code" TEXT NOT NULL UNIQUE,
    "departure_date" NUMERIC NOT NULL,
    "arrival_date" NUMERIC NOT NULL,
    "id_airline_fk" NUMERIC NOT NULL,
    "id_ticket_fk" INTEGER NOT NULL,
    "id_passenger_fk" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_ticket_fk") REFERENCES "tickets" ("id"),
    FOREIGN KEY ("id_passenger_fk") REFERENCES "passengers" ("id"),
    FOREIGN KEY ("id_airline_fk") REFERENCES "airlines" ("id")
);
-- Check-Ins table
CREATE TABLE IF NOT EXISTS "checkins" (
    "id" INTEGER,
    "date_checkin" NUMERIC NOT NULL,
    "id_passenger_fk" INTEGER NOT NULL,
    "id_ticket_fk" INTEGER NOT NULL,
    "id_airline_fk" NUMERIC NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_passenger_fk") REFERENCES "passengers" ("id"),
    FOREIGN KEY ("id_ticket_fk") REFERENCES "tickets" ("id"),
    FOREIGN KEY ("id_airline_fk") REFERENCES "airlines" ("id")
);
