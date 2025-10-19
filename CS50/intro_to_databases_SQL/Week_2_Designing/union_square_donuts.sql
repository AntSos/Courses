-- Ingredients table
CREATE TABLE IF NOT EXISTS "ingredients" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price" FLOAT NOT NULL,
    PRIMARY KEY ("id")
);
-- Donuts table
CREATE TABLE IF NOT EXISTS "donuts" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" TEXT NOT NULL CHECK("gluten_free" IN ("yes", "no")),
    "price" FLOAT NOT NULL,
    "id_ingredient_1_fk" INTEGER NOT NULL,
    "id_ingredient_2_fk" INTEGER NOT NULL,
    "id_ingredient_3_fk" INTEGER NOT NULL,
    "id_ingredient_4_fk" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_ingredient_1_fk") REFERENCES "ingredients" ("id"),
    FOREIGN KEY ("id_ingredient_2_fk") REFERENCES "ingredients" ("id"),
    FOREIGN KEY ("id_ingredient_3_fk") REFERENCES "ingredients" ("id"),
    FOREIGN KEY ("id_ingredient_4_fk") REFERENCES "ingredients" ("id")
);
-- Orders table
CREATE TABLE IF NOT EXISTS "orders" (
    "id" INTEGER,
    "donut_num" INTEGER NOT NULL,
    "id_donut_fk" INTEGER NOT NULL,
    "id_customer_fk" TEXT NOT NULL UNIQUE,
    "total_price" FLOAT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_donut_fk") REFERENCES "donuts" ("id"),
    FOREIGN KEY ("id_customer_fk") REFERENCES "customers" ("id")
);
-- Customers table
CREATE TABLE IF NOT EXISTS "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "id_order_fk" INTEGER NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("id_order_fk") REFERENCES "orders" ("id")
);
