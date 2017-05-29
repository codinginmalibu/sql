SELECT * FROM flights LIMIT 10;

SELECT code FROM airports WHERE elevation > 2000;

SELECT * FROM flights WHERE origin IN (
	SELECT code FROM airports WHERE elevation > 2000
);

SELECT * FROM flights WHERE origin IN (
	SELECT code FROM airports WHERE elevation < 2000
);

SELECT * FROM flights WHERE origin IN (
	SELECT code FROM airports WHERE fac_type = 'SEAPLANE_BASE'
);

SELECT * FROM flights WHERE origin IN (
        SELECT code FROM airports WHERE faa_region = 'ASO'
);

-- Number of flights on average for all Fridays in a given month.
SELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_count) AS average_flights
  FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               COUNT(*) AS flight_count
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;

-- Find the average total distance flown by day of week and month
SELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_distance) AS average_distance
  FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               SUM(distance) AS flight_distance
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;

-- Correlated subquery example: find the list of all flights whose distance is above average for their carrier
SELECT id FROM flights AS f WHERE distance > (
 SELECT AVG(distance) FROM flights WHERE carrier = f.carrier);

-- Find the id of the flights whose distance is below average for their carrier.
SELECT id FROM flights AS f WHERE distance < (
 SELECT AVG(distance) FROM flights WHERE carrier = f.carrier);

-- flight_id increments with each additional flight, the following query to view flights by carrier, flight id, and sequence number
SELECT carrier, id,
    (SELECT COUNT(*)
FROM flights f
WHERE f.id < flights.id
AND f.carrier=flights.carrier) + 1
 AS flight_sequence_number
FROM flights;

-- view flights by origin, flight id, and sequence number. Alias the sequence number column as flight_sequence_number
SELECT origin, id,
    (SELECT COUNT(*)
FROM flights f
WHERE f.id < flights.id
AND f.origin=flights.origin) + 1
 AS flight_sequence_number
FROM flights;


-- COUNTS
SELECT count(*) FROM flights;

SELECT count(*) 
FROM flights 
WHERE arr_time IS NOT NULL AND destination IS "ATL";

-- CONDITIONAL LOGIC
SELECT
    CASE
        WHEN elevation < 250 THEN 'Low'
        WHEN elevation BETWEEN 250 AND 1749 THEN 'Medium'
        WHEN elevation >= 1750 THEN 'High'
        ELSE 'Unknown'
    END AS elevation_tier
    , COUNT(*)
FROM airports
GROUP BY 1;

SELECT state, 
COUNT(CASE WHEN elevation < 1000 THEN 1 ELSE NULL END) as count_low_elevation_airports 
FROM airports 
GROUP BY state;

SELECT origin, sum(distance) as total_flight_distance, sum(CASE WHEN carrier = 'DL' THEN distance ELSE 0 END) as total_delta_flight_distance 
FROM flights 
GROUP BY origin;

SELECT     origin, 
    100.0*(sum(CASE WHEN carrier = 'DL' THEN distance ELSE 0 END)/sum(distance)) as percentage_flight_distance_from_united FROM flights 
GROUP BY origin;

SELECT state, 100.0 * sum(CASE WHEN elevation >= 2000 THEN 1 ELSE 0 END) / count(*)  as percentage_high_elevation_airports FROM airports GROUP BY state;


