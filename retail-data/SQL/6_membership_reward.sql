-- 25-03-2025
USE retail_data;

SELECT * FROM member_trip_count;

-- Reward on trip count
SELECT year, MIN(trip_count), MAX(trip_count)
FROM member_trip_count
GROUP BY year;

SELECT *,
CASE WHEN trip_count < 30 THEN 'BRONZE'
	 WHEN trip_count >= 30 AND trip_count < 60 THEN 'SILVER'
     WHEN trip_count >= 60 AND trip_count < 90 THEN 'GOLD'
     WHEN trip_count >= 90 AND trip_count < 120 THEN 'PLATINUM'
     ELSE 'DIAMOND'
END AS membership_plan
FROM member_trip_count;


SELECT *,
CASE WHEN trip_count < 30 THEN 'BRONZE'
	 WHEN trip_count >= 30 AND trip_count < 60 THEN 'SILVER'
     WHEN trip_count >= 60 AND trip_count < 90 THEN 'GOLD'
     WHEN trip_count >= 90 AND trip_count < 120 THEN 'PLATINUM'
     ELSE 'DIAMOND'
END AS membership_plan
FROM member_trip_count
HAVING membership_plan = 'BRONZE';