-- 28-03-2025

-- Average IPI
WITH TripGaps AS (
	SELECT member_id, tran_dt,
		LAG(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt) AS prev_tran_dt,
		DATEDIFF(tran_dt, LAG(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt)) AS ipi_gap
    FROM tran_hdr
)
SELECT mtc.member_id, mtc.year,
	AVG(tg.ipi_gap) as avg_ipi
FROM member_trip_count mtc
JOIN TripGaps tg
ON tg.member_id = mtc.member_id
WHERE tg.ipi_gap IS NOT NULL
GROUP BY mtc.member_id, mtc.year
ORDER BY tg.member_id;








-- Average updating 
WITH TripGaps AS (
    SELECT member_id, tran_dt,
        LAG(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt) AS prev_tran_dt,
        DATEDIFF(tran_dt, LAG(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt)) AS ipi_gap
    FROM tran_hdr
)
SELECT 
    mtc.member_id, 
    mtc.year,
    tg.tran_dt,
    tg.prev_tran_dt,
    tg.ipi_gap,
    -- Running AVG of ipi_gap, updating each row with previous avg
    AVG(tg.ipi_gap) OVER (PARTITION BY mtc.member_id ORDER BY tg.tran_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS avg_ipi
FROM member_trip_count mtc
JOIN TripGaps tg
ON tg.member_id = mtc.member_id
WHERE tg.ipi_gap IS NOT NULL
ORDER BY tg.member_id, tg.tran_dt;