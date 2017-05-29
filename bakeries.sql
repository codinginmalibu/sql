SELECT * FROM bakeries;

SELECT * FROM bakeries LIMIT 10;


-- Datetime functions

SELECT DATETIME(delivery_time)
FROM baked_goods;

SELECT DATE(delivery_time), count(*) as count_baked_goods
FROM baked_goods
GROUP BY DATE(delivery_time);

SELECT DATETIME(manufacture_time, '+2 hours', '30 minutes', '1 day') as inspection_time
FROM baked_goods;

SELECT DATETIME(delivery_time, '+5 hours', '20 minutes', '2 day') as package_time
FROM baked_goods;


-- Math functions

SELECT ROUND(ingredients_cost, 2) as rounded_cost
FROM baked_goods;

SELECT ROUND(distance,2) AS distance_from_market 
FROM bakeries;

SELECT id, MIN(cook_time, cool_down_time) AS max_time
FROM baked_goods ORDER BY max_time DESC;


-- String functions

SELECT city || ', ' || state as location
FROM bakeries;

SELECT first_name || ' ' || last_name as full_name 
FROM bakeries;

SELECT id, REPLACE(ingredients,'_',' ') as item_ingredients
from baked_goods;

SELECT REPLACE(ingredients,'enriched_',' ') as item_ingredients
FROM baked_goods;


