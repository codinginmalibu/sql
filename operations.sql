-- Initial 
SELECT * FROM new_products LIMIT 10;
SELECT * FROM legacy_products LIMIT 10;

-- Union: Each SELECT statement within the UNION must have the same number of columns with similar data types. The columns in each SELECT statement must be in the same order. By default, the UNION operator selects only distinct values.

SELECT item_name FROM legacy_products ORDER BY item_name;
--UNION 
SELECT item_name FROM new_products ORDER BY item_name;

-- complete list of product names from both tables
SELECT item_name FROM legacy_products
UNION 
SELECT item_name FROM new_products;

-- complete list of brand names from the legacy_products and new_products
SELECT brand FROM legacy_products
UNION 
SELECT brand FROM new_products;

-- combine the tables for a complete analysis of sale price
SELECT id, sale_price FROM order_items
UNION ALL
SELECT id, sale_price FROM order_items_historic;

-- find the total count of order items
SELECT count(*) FROM (
  SELECT id, sale_price FROM order_items
  UNION ALL
  SELECT id, sale_price FROM order_items_historic) as a;

-- find the average sale price over order_items and order_items_historic
SELECT id, avg(a.sale_price) FROM (
  SELECT id, sale_price FROM order_items
  UNION ALL
  SELECT id, sale_price FROM order_items_historic) AS a 
  GROUP BY 1;

-- INTERSECT example
-- brands in our newly acquired store are also in our legacy store.
SELECT brand FROM new_products
INTERSECT
SELECT brand FROM legacy_products;

-- items in the category column that are both in the newly acquired new_products table and the legacy_products
SELECT category FROM new_products
INTERSECT
SELECT category FROM legacy_products;

-- EXCEPT example
-- categories that are in the new_products table that aren't in the legacy_products table
SELECT category FROM new_products
EXCEPT
SELECT category FROM legacy_products;

-- select the items in the category column that are in the legacy_products table and not in the new_products table
SELECT category FROM legacy_products
EXCEPT
SELECT category FROM new_products;


