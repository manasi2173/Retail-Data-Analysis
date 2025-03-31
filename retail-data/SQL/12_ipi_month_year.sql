-- 28-03-2025

-- IPI per month
SELECT member_id, 
	   YEAR(tran_dt) AS year,
       MONTH(tran_dt) AS month,
       LAG(tran_dt) OVER (PARTITION BY member_id, YEAR(tran_dt), MONTH(tran_dt) ORDER BY tran_dt) AS prev_tran_dt,
       tran_dt,
       DATEDIFF(tran_dt, LAG(tran_dt) OVER (PARTITION BY member_id, YEAR(tran_dt), MONTH(tran_dt) ORDER BY tran_dt)) AS ipi
FROM tran_hdr;




-- IPI per year
SELECT member_id,
	   YEAR(tran_dt) AS year,
       LAG(tran_dt) OVER (PARTITION BY member_id, YEAR(tran_dt) ORDER BY tran_dt) AS prev_tran_dt,
       tran_dt,
       DATEDIFF(tran_dt, LAG(tran_dt) OVER (PARTITION BY member_id, YEAR(tran_dt) ORDER BY tran_dt)) AS ipi
FROM tran_hdr;