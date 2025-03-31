-- 26-03-2025

-- discount reward
SELECT *,
	CASE WHEN membership_plan = 'BRONZE' THEN '5%'
		 WHEN membership_plan = 'SILVER' THEN '15%'
		 WHEN membership_plan = 'GOLD' THEN '25%'
		 WHEN membership_plan = 'PLATINUM' THEN '30%'
		 ELSE '45%'
	END AS membership_discount
FROM 
(
	SELECT *,
		CASE WHEN trip_count < 30 THEN 'BRONZE'
			 WHEN trip_count >= 30 AND trip_count < 60 THEN 'SILVER'
			 WHEN trip_count >= 60 AND trip_count < 90 THEN 'GOLD'
			 WHEN trip_count >= 90 AND trip_count < 120 THEN 'PLATINUM'
			 ELSE 'DIAMOND'
		END AS membership_plan
	FROM member_trip_count
)mp;