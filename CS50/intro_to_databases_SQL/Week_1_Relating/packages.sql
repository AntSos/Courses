
-- *** The Lost Letter ***
-- Query address and residential type for 2 Finnegan Street
SELECT "address", "type"
FROM "addresses"
WHERE "id" = (SELECT "to_address_id"
              FROM "packages"            -- Subquery to find from_address_id due to the given direction (to_address_id) is wrong
              WHERE "from_address_id" = (SELECT "id"
                                         FROM "addresses"
                                         WHERE "address" LIKE '%900 Somerville Avenue%'
                                         )
              AND "contents" LIKE '%congratulatory%'
              )
;
    -- Answers:
        -- At what type of address did the Lost Letter end up?: Residential
        -- At what address did the Lost Letter end up?: 2 Finnigan Street
-- *** The Devious Delivery ***
-- Write querys to find the delivery address and the content (probably a rubber duck), there is not from_address_id
-- Get the content, address of the package and type
SELECT "packages"."contents", "addresses"."address", "addresses"."type"
-- scans has relationships with packages and addresses
FROM "scans"
JOIN "packages" ON "packages"."id" = "scans"."package_id"
JOIN "addresses" ON "addresses"."id" = "scans"."address_id"
-- content (probably a rubber duck)
WHERE "packages"."contents" LIKE '%duck%'
-- from_address_id is absent
AND "packages"."from_address_id" IS NULL
-- The package was Drop in some place
AND "scans"."action" = 'Drop';
    -- Answers:
        -- At what type of address did the Devious Delivery end up?: Police Station
        -- What were the contents of the Devious Delivery?: Duck debugger
-- *** The Forgotten Gift ***
SELECT *
FROM "scans"
JOIN "packages" ON "packages"."id" = "scans"."package_id"
JOIN "addresses" ON "addresses"."id" = "scans"."address_id"
JOIN "drivers" ON "drivers"."id" = "scans"."driver_id"
WHERE "packages"."from_address_id" = (SELECT "id"
                                      FROM "addresses"
                                      WHERE "address" = '109 Tileston Street.'
                                      )
OR "packages"."to_address_id" = (SELECT "id"
                                  FROM "addresses"
                                  WHERE "address" = '728 Maple Place'
                                  )
AND "scans"."action" != 'Drop'
AND "addresses"."type" ='Warehouse'
;
    -- Answers:
        -- What are the contents of the Forgotten Gift?: Flowers
        -- Who has the Forgotten Gift?: Mikel
