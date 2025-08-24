SELECT* FROM fashion_boutique_dataset;

-- CUSTOMER SATISFACTION ANALYSIS
SELECT brand, return_reason, count(*) AS total, RANK() OVER (PARTITION BY brand ORDER BY COUNT(*) DESC) AS reason_rank
FROM fashion_boutique_dataset
WHERE is_returned='True'
GROUP BY brand, return_reason;

CREATE TABLE brand_top_return_reason AS
WITH reason_count AS (
    SELECT 
        brand,
        return_reason,
        COUNT(*) AS total_reason,
        RANK() OVER (PARTITION BY brand ORDER BY COUNT(*) DESC) AS reason_rank
    FROM fashion_boutique_dataset
    WHERE is_returned = 'True'
    GROUP BY brand, return_reason
)
SELECT brand, return_reason, total_reason
FROM reason_count
WHERE reason_rank = 1;

SELECT* FROM brand_top_return_reason;

SELECT DISTINCT
    brand,
    ROUND(AVG(CAST(customer_rating AS DECIMAL(3,2))),2) AS avg_rating,
    COUNT(*) AS total_orders,   -- ini otomatis jadi total order
    SUM(CASE WHEN is_returned = 'True' THEN 1 ELSE 0 END) AS total_returns,
    ROUND(
        SUM(CASE WHEN is_returned = 'True' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
	)AS return_rate_percent
FROM fashion_boutique_dataset 
GROUP BY brand
ORDER BY return_rate_percent DESC;

-- SEASONAL DEMAND FORECASTING
#untuk tahu category apa yang memiliki demand tinggi untuk masing-masing season pada masing-masing brand
SELECT brand, category, season, COUNT(*) AS total_orders FROM fashion_boutique_dataset
GROUP BY season, category, brand
ORDER BY season, total_orders DESC;

#untuk tahu pendapatan paling banyak dari sebuah brand itu di saat season apa
SELECT 
	brand,
    season,
    ROUND(SUM(current_price), 2) AS total_revenue,
	RANK() OVER(PARTITION BY brand ORDER BY ROUND(SUM(current_price), 2) DESC) AS rank_revenue
FROM fashion_boutique_dataset
GROUP BY brand, season;

WITH season_top_revenue AS
(
SELECT 
	brand,
    season,
    ROUND(SUM(current_price), 2) AS total_revenue,
	RANK() OVER(PARTITION BY brand ORDER BY ROUND(SUM(current_price), 2) DESC) AS rank_revenue
FROM fashion_boutique_dataset
GROUP BY brand, season
)
SELECT brand, season, total_revenue 
FROM season_top_revenue
WHERE rank_revenue=1;

-- Pricing Optimization
SELECT* FROM fashion_boutique_dataset;

#Ingin mencari tahu apakah diskon memengaruhi return rate dan diskon mana yang memiliki revenue paling besar (efektif)
SELECT 
    CASE 
        WHEN markdown_percentage <= 30 THEN '0-30%'
        WHEN markdown_percentage <= 50 THEN '31-50%'
        ELSE '>50%'
    END AS discount_range,
    COUNT(*) AS total_orders,
    SUM(current_price) AS total_revenue,
    ROUND(AVG(current_price),2) AS avg_selling_price,
    ROUND(SUM(CASE WHEN is_returned = 'True' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS return_rate_percent
FROM fashion_boutique_dataset
GROUP BY discount_range
ORDER BY discount_range;

-- Inventory Management
SELECT 
    DATE_FORMAT(purchase_date, '%Y-%m') AS month,
    brand,
    COUNT(*) AS total_orders,
    SUM(current_price) AS total_revenue
FROM fashion_boutique_dataset
WHERE is_returned = 'False'
GROUP BY DATE_FORMAT(purchase_date, '%Y-%m'), brand
ORDER BY month, brand;

SELECT 
    brand,
    category,
    SUM(stock_quantity) AS current_stock,
    COUNT(*) AS total_orders
FROM fashion_boutique_dataset
WHERE is_returned = 'False'
GROUP BY brand, category
ORDER BY current_stock ASC;

SELECT
    product_id,
    category,
    brand,
    season,
    stock_quantity,
    CASE 
        WHEN stock_quantity < 5 THEN 'LOW STOCK'
        WHEN stock_quantity > 40 THEN 'HIGH STOCK'
        ELSE 'NORMAL'
    END AS stock_status,
    CASE 
        WHEN markdown_percentage <= 30 THEN '0-30%'
        WHEN markdown_percentage <= 50 THEN '31-50%'
        ELSE '>50%'
    END AS discount_range
FROM fashion_boutique_dataset;