-- 24-03-2025

-- Total Sale
USE retail_data;

SELECT * FROM tran_dtl;
SELECT * FROM product;

SELECT * FROM product p
JOIN tran_dtl td
ON p.product_id = td.product_id;

SELECT SUM(amt) AS total_sale FROM tran_dtl;


-- Total Sale per Product
SELECT td.product_id, p.description, p.category, SUM(td.amt) AS total_sale
FROM product p
JOIN tran_dtl td
ON p.product_id = td.product_id
GROUP BY p.product_id
ORDER BY p.product_id;


-- Total Avg Sale 
SELECT AVG(amt) FROM tran_dtl;


-- Total Avg Sale per Product
SELECT td.product_id, p.description, AVG(td.amt) AS avg_sale
FROM product p
JOIN tran_dtl td
ON p.product_id = td.product_id
GROUP BY p.product_id
ORDER BY p.product_id;


-- total Sale per Member
SELECT * FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id;

SELECT th.member_id, SUM(td.amt) AS total_sale
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY th.member_id
ORDER BY th.member_id;


-- total Avg Sale per Member
SELECT th.member_id, AVG(td.amt) AS avg_sale
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY th.member_id
ORDER BY th.member_id;


-- Yearly Sale 
SELECT YEAR(tran_dt) AS year, SUM(amt) AS total_yearly_sale 
FROM tran_dtl
GROUP BY YEAR(tran_dt)
ORDER BY year;


-- Yearly Sale per Member
SELECT th.member_id, YEAR(td.tran_dt) AS year, SUM(td.amt) AS total_yearly_sale 
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY th.member_id, YEAR(tran_dt)
ORDER BY th.member_id, year;


-- Yearly Sale per Product
SELECT p.product_id, p.description, YEAR(td.tran_dt) AS year, SUM(td.amt) AS total_yearly_sale
FROM tran_dtl td
JOIN product p
ON td.product_id = p.product_id
GROUP BY p.product_id, YEAR(td.tran_dt)
ORDER BY p.product_id, year;


-- Avg Monthly Sale
SELECT MONTH(tran_dt) AS month, AVG(amt) AS avg_monthly_sale
FROM tran_dtl
GROUP BY MONTH(tran_dt)
ORDER BY month;


-- 25-03-2025

-- Avg Monthly Sale of Product (per Product)
SELECT p.product_id, p.description, MONTH(td.tran_dt) AS month, AVG(td.amt) AS avg_monthly_sale
FROM tran_dtl td
JOIN product p
ON td.product_id = p.product_id
GROUP BY p.product_id, MONTH(td.tran_dt)
ORDER BY p.product_id, month;


-- Avg Monthly Sale of Member (per Member)
SELECT th.member_id, MONTH(td.tran_dt) AS month, AVG(td.amt) AS avg_monthly_sale
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY th.member_id, MONTH(td.tran_dt)
ORDER BY th.member_id, month;


-- Avg Yearly Sale
SELECT YEAR(tran_dt) AS year, AVG(amt) AS avg_yearly_sale
FROM tran_dtl
GROUP BY YEAR(tran_dt)
ORDER BY year;


-- Avg Yearly Sale per Member
SELECT th.member_id, YEAR(td.tran_dt) AS year, AVG(td.amt) AS avg_yearly_sale
FROM tran_dtl td
JOIN tran_hdr th
ON td.tran_id = th.tran_id
GROUP BY th.member_id, YEAR(td.tran_dt)
ORDER BY th.member_id, year;


-- Avg Yearly Sale per Product
SELECT p.product_id, p.description, YEAR(td.tran_dt) AS year, AVG(td.amt) AS avg_yearly_sale
FROM tran_dtl td
JOIN product p
ON td.product_id = p.product_id
GROUP BY p.product_id, YEAR(td.tran_dt)
ORDER BY p.product_id, year;



SELECT tran_dt, DAY(tran_dt) AS date FROM tran_hdr;