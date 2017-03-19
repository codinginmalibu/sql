SELECT * FROM flights LIMIT 10;

SELECT code FROM airports WHERE elevation > 2000;

SELECT * FROM flights WHERE origin IN (
	SELECT code FROM airports WHERE elevation > 2000
);

SELECT * FROM flights WHERE origin IN (
	SELECT code FROM airports WHERE elevation < 2000
);

