-- DATA CLEANING

SELECT* FROM dirty_cafe_sales;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns

#Membuat tabel baru untuk cleaning data
CREATE TABLE cafe_sales
LIKE dirty_cafe_sales;

SELECT* FROM cafe_sales;

INSERT cafe_sales
SELECT* FROM dirty_cafe_sales;

#ganti nama kolom terlebih dahulu
ALTER TABLE cafe_sales
RENAME COLUMN `transaction_id` TO Transaction_ID;
ALTER TABLE cafe_sales
RENAME COLUMN `Price Per Unit` TO Price_Per_Unit;
ALTER TABLE cafe_sales
RENAME COLUMN `Total Spent` TO Total_Spent;
ALTER TABLE cafe_sales
RENAME COLUMN `Payment Method` TO Payment_Method;
ALTER TABLE cafe_sales
RENAME COLUMN `Transaction Date` TO Transaction_Date;

#Cari duplicate values
SELECT*,
ROW_NUMBER() OVER(
PARTITION BY Transaction_ID, Item, Quantity, Price_Per_Unit, Total_Spent, Payment_Method, Location, Transaction_Date ) AS row_num
FROM cafe_sales;

WITH duplicate_cte AS
(
	SELECT*,
	ROW_NUMBER() OVER(
	PARTITION BY Transaction_ID, Item, Quantity, Price_Per_Unit, Total_Spent, Payment_Method, Location, Transaction_Date ) AS row_num
	FROM cafe_sales
)
SELECT* FROM duplicate_cte
WHERE row_num>1;

CREATE TABLE `cafe_sales2` (
  `Transaction_ID` text,
  `Item` text,
  `Quantity` int,
  `Price_Per_Unit` double,
  `Total_Spent` text,
  `Payment_Method` text,
  `Location` text,
  `Transaction_Date` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT* FROM cafe_sales2;

INSERT cafe_sales2
SELECT*,
	ROW_NUMBER() OVER(
	PARTITION BY Transaction_ID, Item, Quantity, Price_Per_Unit, Total_Spent, Payment_Method, Location, Transaction_Date ) AS row_num
	FROM cafe_sales;

SELECT* FROM cafe_sales2
WHERE row_num>1;

DELETE
FROM cafe_sales2
WHERE row_num>1;

SELECT* FROM cafe_sales2;

-- Standarizing Data
SELECT DISTINCT Item FROM cafe_sales2;

SELECT DISTINCT Payment_Method FROM cafe_sales2;

SELECT DISTINCT Location FROM cafe_sales2;

ALTER TABLE cafe_sales2
MODIFY COLUMN Transaction_Date DATE;

#Karena data sudah terstandarisasi maka dilanjutkan mencari missing values
-- Missing Values
SELECT* FROM cafe_sales2
WHERE Total_Spent='ERROR';

#Karean diketahui quantity dan price per unit maka kita bisa mengganti total spent yang error dengan menghitung total spent yaitu quantity*price per unit

SELECT* FROM cafe_sales2
WHERE Total_Spent='ERROR';

UPDATE cafe_sales2
SET Total_Spent=Price_per_unit*Quantity
WHERE Total_Spent='ERROR';

SELECT* FROM cafe_sales2
WHERE Total_Spent='' OR Total_Spent='UNKNOWN';

UPDATE cafe_sales2
SET Total_Spent=Price_per_unit*Quantity
WHERE Total_Spent='' OR Total_Spent='UNKNOWN';

SELECT* FROM cafe_sales2
WHERE Item='' OR Item='ERROR' OR Item='UNKNOWN';

UPDATE cafe_sales2
SET Item=''
WHERE Item='' OR Item='ERROR' OR Item='UNKNOWN';

SELECT* FROM cafe_sales2
WHERE Transaction_Date='' OR Transaction_Date='ERROR' OR Transaction_Date='UNKNOWN';

UPDATE cafe_sales2
SET Transaction_Date=''
WHERE Transaction_Date='' OR Transaction_Date='ERROR' OR Transaction_Date='UNKNOWN';

SELECT* FROM cafe_sales2
WHERE Payment_Method='' OR Payment_Method='ERROR' OR Payment_Method='UNKNOWN';

UPDATE cafe_sales2
SET Payment_Method=''
WHERE Payment_Method='' OR Payment_Method='ERROR' OR Payment_Method='UNKNOWN';

UPDATE cafe_sales2
SET Location=''
WHERE Location='ERROR' OR Location='UNKNOWN';

UPDATE cafe_sales2
SET Transaction_Date=''
WHERE Location='ERROR' OR Location='UNKNOWN';

SELECT* FROM cafe_sales2
WHERE Item='' AND Payment_Method='' AND Location='' AND Transaction_Date='';

DELETE 
FROM cafe_sales2
WHERE Item='' AND Payment_Method='' AND Location='' AND Transaction_Date='';

DELETE
FROM cafe_sales2
WHERE Item='';

DELETE
FROM cafe_sales2
WHERE Transaction_Date='';

SELECT* FROM cafe_sales2;

-- Remove Any Columns
ALTER TABLE cafe_sales2
DROP COLUMN row_num;

SELECT* FROM cafe_sales2;
