-- 31-03-2025

-- Monthly Sales    (Sm)
-- Total Sales per proudct, per month

SELECT product_id, 
	   YEAR(tran_dt) AS year,
	   MONTH(tran_dt) AS month, 
       SUM(amt) AS total_monthly_sale
FROM tran_dtl
GROUP BY product_id,YEAR(tran_dt), MONTH(tran_dt)
ORDER BY product_id, month;
	   


-- Average Monthly Sale   (Savg)
-- Average Sales per product, per month
SELECT product_id, 
	   YEAR(tran_dt) AS year,
	   MONTH(tran_dt) AS month,
       AVG(amt) AS avg_monthly_sale
FROM tran_dtl
GROUP BY product_id, YEAR(tran_dt), MONTH(tran_dt)
ORDER BY product_id, month;



SELECT product_id, AVG(monthly_sale) AS avg_monthly_sale
FROM (
    SELECT product_id, YEAR(tran_dt) AS year, MONTH(tran_dt) AS month, 
           SUM(amt) AS monthly_sale
    FROM tran_dtl
    GROUP BY product_id, YEAR(tran_dt), MONTH(tran_dt)
) AS subquery
WHERE product_id = 2
GROUP BY product_id;



-- Seasonality Index  (Im)
-- Fluctuation of product's sale relative to its average sales 
-- Formula --> Im = Sm/Savg * 100
WITH MonthlySales AS (
	 SELECT product_id, 
			YEAR(tran_dt) AS year,
			MONTH(tran_dt) AS month, 
			SUM(amt) AS monthly_sale
	FROM tran_dtl
	GROUP BY product_id,YEAR(tran_dt), MONTH(tran_dt)
),
AverageMonthlySales AS (
	 SELECT product_id,
			AVG(monthly_sale) AS avg_monthly_sale
	 FROM MonthlySales
     GROUP BY product_id
)
SELECT ms.*,
	   ams.avg_monthly_sale,
       (ms.monthly_sale/ams.avg_monthly_sale) * 100 AS seasonality_index
FROM MonthlySales ms
JOIN AverageMonthlySales ams
ON ms.product_id = ams.product_id
ORDER BY ms.product_id, ms.year, ms.month;