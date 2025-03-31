-- 25-03-2025

-- yearly member trip count table
CREATE TABLE member_trip_count (
	member_id            INT            NOT NULL,
    year                 INT            NOT NULL,
    trip_count           INT            NOT NULL,
    PRIMARY KEY(member_id, year)
);

INSERT INTO member_trip_count (member_id, year, trip_count) 
SELECT 
	member_id,
    YEAR(tran_dt) AS year,
    COUNT(tran_id) AS trip_count
FROM tran_hdr
GROUP BY member_id, YEAR(tran_dt);

SELECT * FROM member_trip_count ORDER BY member_id, year;
-- DROP TABLE member_trip_count;