USE retail_data;

-- by member trip count
SELECT * FROM member;

SELECT * FROM tran_hdr
WHERE member_id = 1102 AND  store_id = 1
ORDER BY member_id, store_id;


-- Can be done without using DISTICNT, since tran_hdr already has distinct entries
SELECT member_id, COUNT(DISTINCT tran_id) AS trip_count
FROM tran_hdr
GROUP BY member_id
ORDER BY member_id;

SELECT member_id, YEAR(tran_dt) AS year, COUNT(DISTINCT tran_id) AS yearly_trip_count
FROM tran_hdr
GROUP BY member_id, YEAR(tran_dt)
ORDER BY member_id , year;


SELECT member_id, MONTH(tran_dt) AS month, COUNT(DISTINCT tran_id) AS monthly_trip_count
FROM tran_hdr
GROUP BY member_id, MONTH(tran_dt)
ORDER BY member_id, month;






-- using tran_dtl

SELECT th.member_id, MONTH(td.tran_dt) AS month, COUNT(DISTINCT td.tran_id) AS monthly_trip_count
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY member_id, MONTH(td.tran_dt)
ORDER BY member_id, month;


SELECT th.member_id, YEAR(td.tran_dt) AS year, COUNT(DISTINCT td.tran_id) AS yearly_trip_count
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY member_id, YEAR(td.tran_dt)
ORDER BY member_id, year;





-- using member_id

SELECT member_id, YEAR(tran_dt) AS year, COUNT(member_id) AS yearly_trip_count
FROM tran_hdr
GROUP BY member_id, YEAR(tran_dt)
ORDER BY member_id, year;

SELECT member_id, MONTH(tran_dt) AS month, COUNT(member_id) AS monthly_trip_count
FROM tran_hdr 
GROUP BY member_id, MONTH(tran_dt)
ORDER  BY member_id, month;

SELECT member_id, COUNT(member_id) AS trip_count
FROM tran_hdr
GROUP BY member_id
ORDER BY member_id;



-- by member by product -> query only
-- member_trip_count table
-- last one year -> curr_dt-1 year 


-- update trip count table daily