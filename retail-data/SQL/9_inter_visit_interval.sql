-- 27-03-2025
USE retail_data;

-- Inter-Visit Interval
SELECT member_id, 
	tran_dt AS latest_visit, 
	LAG(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt) AS prev_visit,
    DATEDIFF(tran_dt, LAG(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt)) AS trip_gap
FROM tran_hdr
WHERE tran_dt >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 YEAR);