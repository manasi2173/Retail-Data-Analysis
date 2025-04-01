-- 31-03-2025
USE retail_data;


DROP TABLE IF EXISTS rolling_member_trip_count;
CREATE TABLE rolling_member_trip_count (
    member_id  INT NOT NULL,
    tran_dt    DATE NOT NULL,
    trip_count INT NOT NULL,
    PRIMARY KEY (member_id, tran_dt)
);


DELETE FROM rolling_member_trip_count 
WHERE tran_dt < DATE_SUB(CURDATE(), INTERVAL 365 DAY)
	  OR tran_dt > CURDATE();


INSERT INTO rolling_member_trip_count (member_id, tran_dt, trip_count) 
SELECT 
    member_id,
    tran_dt,
    COUNT(DISTINCT tran_id) AS trip_count
FROM tran_hdr
WHERE tran_dt BETWEEN DATE_SUB(CURDATE(), INTERVAL 365 DAY) AND CURDATE()
GROUP BY member_id, tran_dt
ON DUPLICATE KEY UPDATE trip_count = VALUES(trip_count);



SELECT * FROM rolling_member_trip_count ORDER BY tran_dt;

-- SELECT * FROM rolling_member_trip_count
-- WHERE trip_count > 1
-- ORDER BY tran_dt ASC;




-- SELECT COUNT(tran_id) FROM tran_hdr
-- WHERE tran_dt >= DATE_SUB(CURDATE(), INTERVAL 365 DAY);

-- SELECT COUNT(member_id) FROM rolling_member_trip_count;


-- SELECT DISTINCT member_id 
-- FROM tran_hdr
-- WHERE tran_dt >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
-- AND member_id NOT IN (SELECT DISTINCT member_id FROM rolling_member_trip_count);


-- SELECT member_id, tran_dt, COUNT(tran_id) as count_per_day
-- FROM tran_hdr
-- WHERE tran_dt >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
-- GROUP BY member_id, tran_dt
-- HAVING count_per_day > 1
-- ORDER BY count_per_day DESC;

-- SELECT member_id, tran_dt, tran_id FROM tran_hdr WHERE tran_dt = '2025-02-03' AND member_id = 1175;
-- SELECT th.member_id, th.tran_dt, td.tran_dt, th.tran_id, td.tran_id FROM tran_dtl td JOIN tran_hdr th ON td.tran_id = th.tran_id 
-- WHERE td.tran_dt = '2025-02-03' AND th.member_id = 1175 AND th.tran_dt = '2025-02-03';



-- INSERT INTO rolling_member_trip_count (member_id, tran_dt, trip_count) 
-- SELECT 
--     member_id,
--     tran_dt,
--     COUNT(DISTINCT tran_id) AS trip_count
-- FROM tran_hdr
-- WHERE tran_dt >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
-- GROUP BY member_id, tran_dt
-- ON DUPLICATE KEY UPDATE trip_count = VALUES(trip_count);
-- DROP TABLE rolling_member_trip_count;




-- SELECT member_id, tran_dt, COUNT(*)
-- FROM rolling_member_trip_count
-- GROUP BY member_id, tran_dt
-- HAVING COUNT(*) > 1;



-- SHOW CREATE TABLE rolling_member_trip_count;



-- SELECT COUNT(*) FROM tran_hdr
-- WHERE tran_dt >= DATE_SUB(CURDATE(), INTERVAL 365 DAY);


-- SELECT COUNT(DISTINCT member_id, tran_dt) FROM tran_hdr
-- WHERE tran_dt >= DATE_SUB(CURDATE(), INTERVAL 365 DAY);
