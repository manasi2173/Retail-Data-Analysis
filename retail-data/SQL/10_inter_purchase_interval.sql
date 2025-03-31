-- 27-03-2025
USE retail;

-- Inter Purchase Interval Matrix
-- per member -> overall purchase behaviour
-- analyzes customer shopping frequency
SELECT member_id,
	tran_dt AS last_purchase_dt,
    LEAD(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt) AS next_purchase_dt,
    DATEDIFF( LEAD(tran_dt) OVER (PARTITION BY member_id ORDER BY tran_dt), tran_dt) AS ipi
FROM tran_hdr;



-- per member per product -> product-specific behaviour
-- analyzes product repurchase behaviour and frequency
SELECT th.member_id, td.product_id,
	th.tran_dt AS last_purchase_dt,
    LEAD(th.tran_dt) OVER (PARTITION BY th.member_id, td.product_id ORDER BY th.tran_dt) AS next_purchase_dt,
    DATEDIFF( LEAD(th.tran_dt) OVER (PARTITION BY th.member_id, td.product_id ORDER BY th.tran_dt), th.tran_dt) AS ipi
FROM tran_hdr th
JOIN tran_dtl td
ON td.tran_id = th.tran_id;





-- SELECT th.member_id, td.product_id,
-- 	th.tran_dt AS last_purchase_dt,
--     LAG(th.tran_dt) OVER (PARTITION BY th.member_id, td.product_id ORDER BY th.tran_dt) AS next_purchase_dt,
--     DATEDIFF( LAG(th.tran_dt) OVER (PARTITION BY th.member_id, td.product_id ORDER BY th.tran_dt), th.tran_dt) AS ipi
-- FROM tran_hdr th
-- JOIN tran_dtl td
-- ON td.tran_id = th.tran_id;


    
    
    
SELECT * FROM member_trip_count;