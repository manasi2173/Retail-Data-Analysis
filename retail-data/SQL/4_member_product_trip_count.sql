-- 25-03-2025

USE retail_data;

-- per member per product trip count
SELECT th.member_id, td.product_id, COUNT(th.tran_id) AS member_proudct_trip_count
FROM tran_hdr th
JOIN tran_dtl td
ON th.tran_id = td.tran_id
GROUP BY th.member_id, td.product_id
ORDER BY th.member_id, td.product_id;


SELECT th.member_id, td.product_id, MONTH(th.tran_dt) AS month, COUNT(th.tran_id) AS member_proudct_trip_count
FROM tran_hdr th
JOIN tran_dtl td
ON th.tran_id = td.tran_id
GROUP BY th.member_id, td.product_id, MONTH(th.tran_dt)
ORDER BY th.member_id, td.product_id, month;


SELECT th.member_id, td.product_id, YEAR(th.tran_dt) AS year, COUNT(th.tran_id) AS member_proudct_trip_count
FROM tran_hdr th
JOIN tran_dtl td
ON th.tran_id = td.tran_id
GROUP BY th.member_id, td.product_id, YEAR(th.tran_dt)
ORDER BY th.member_id, td.product_id, YEAR;
