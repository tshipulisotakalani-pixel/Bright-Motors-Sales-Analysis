select * from `retailanalysis`.`default`.`bright_car_sales` limit 100;

---Data Exploratort/EDA
--how many car brands are sold?..8 brands
SELECT DISTINCT(make)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Date range 03 April 2015 and 27 May 2015(1 month and a few weeks)
SELECT MIN(saledate),
       MAX(saledate)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Check unique car model--974 
SELECT DISTINCT(model)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Check different car transmissions-2 transmissions and null rows
SELECT DISTINCT(transmission)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Number of cars sold--550296
SELECT COUNT(DISTINCT vin) AS total_units_sold,
       SUM(sellingprice) AS total_revenue,
       AVG(sellingprice) AS average_sale_price
FROM `retailanalysis`.`default`.`bright_car_sales`;


--pricing errors
SELECT sellingprice
FROM `retailanalysis`.`default`.`bright_car_sales`
WHERE sellingprice=1;


--38 states
SELECT DISTINCT(state)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Diffent colours of cars sold,21 colors-null rows
SELECT DISTINCT(color)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Different sellers at bright motors-1000 
SELECT DISTINCT(seller)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Total revenue--with duplication
SELECT SUM(sellingprice)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--odometer range-- 1km to 999999km
SELECT MIN(odometer),
       MAX(odometer)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Create mileage buckets
SELECT odometer,
CASE
    WHEN odometer BETWEEN 0 AND 20000 THEN 'New/Demo'
    WHEN odometer BETWEEN 20001 AND 50000 THEN 'Low Mileage'
    WHEN odometer BETWEEN 50001 AND 70000 THEN 'Mid-Mileage'
    WHEN odometer BETWEEN 70001 AND 90000 THEN 'High Mileage'
    ELSE 'Legacy'
    END AS Mileage_Category
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Extract from saledate--Weekly,Monthly and daily view

SELECT
SPLIT_PART(saledate,' ',2) AS Month_name,
SPLIT_PART(saledate,' ',1) AS day_name,
SPLIT_PART(saledate,' ',3) AS date,
SPLIT_PART(saledate,' ',4) AS year,
SPLIT_PART(saledate,' ',5) AS Time_of_purchase
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Margin catergory/buckets

SELECT sellingprice,
       mmr,
CASE 
    WHEN (sellingprice - mmr) > 1000 THEN 'High Margin'
    WHEN (sellingprice - mmr) BETWEEN 0 AND 1000 THEN 'Medium Margin'
    ELSE 'Low Margin'
    END AS Margin_category
FROM `retailanalysis`.`default`.`bright_car_sales`;


--differnt types of car bodys(87)
SELECT DISTINCT(body)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--different car interior 18,null and dash rows--clean by coalesce
SELECT DISTINCT(interior)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Year of manufacture range 1982 T0 2015..create buckets
SELECT MIN(year),
       MAX(year)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Selling price range--must create price buckets--1-230000
SELECT MIN(sellingprice),
       MAX(sellingprice)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--condition range--1 to 49 create buckets
SELECT MIN(condition),
       MAX(condition)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--create buckets for condition of the car
SELECT sellingprice,
       condition,
    CASE 
        WHEN condition BETWEEN 0 AND 19 THEN 'Poor (1-19)'
        WHEN condition BETWEEN 20 AND 29 THEN 'Fair (20-29)'
        WHEN condition BETWEEN 30 AND 39 THEN 'Good (30-39)'
        WHEN condition BETWEEN 40 AND 49 THEN 'Excellent (40-49)'
        ELSE 'Unknown'
    END AS condition_category
FROM `retailanalysis`.`default`.`bright_car_sales`;


--550296
SELECT DISTINCT(vin)
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Create selling price buckets

SELECT sellingprice,
CASE 
        WHEN sellingprice <= 10000 THEN 'Budget (Under 10k)'
        WHEN sellingprice <= 25000 THEN ' Mainstream (10k-25k)'
        WHEN sellingprice <= 60000 THEN 'Premium (25k-60k)'
        ELSE 'Exotic (Over 60k)'
    END AS price_category
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Year model buckets
SELECT --year,
       --make,
CASE 
        WHEN year >= 2013 THEN 'Latest Model (2013-2015)'
        WHEN year >= 2008 THEN 'Mid-Age Model (2008-2012)'
        WHEN year >= 2000 THEN 'Older Model (2000-2007)'
        ELSE 'Vintage (Pre-2000)'
    END AS model_year_category
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Checking NULLS,condition,color,interior,transmission(Data Cleaning)
SELECT ---interior,
       --transmission,
       --color,
       --condition,
COALESCE(NULLIF(interior,'—'),'unknown') AS cleaned_interior,
COALESCE(transmission,'unknown') AS cleaned_transmission,
COALESCE(condition,0) AS cleaned_condition,
COALESCE(NULLIF(color,'—'),'unknown') AS cleaned_color
FROM `retailanalysis`.`default`.`bright_car_sales`;


--Final Query

SELECT SPLIT_PART(saledate,' ',2) AS Month_name,
       SPLIT_PART(saledate,' ',1) AS day_name,
       SPLIT_PART(saledate,' ',3) AS date,
       SPLIT_PART(saledate,' ',4) AS year,
       COUNT(DISTINCT vin) AS total_units_sold,
       SUM(sellingprice) AS total_revenue,
       AVG(sellingprice) AS average_sale_price,
       COALESCE(NULLIF(interior,'—'),'unknown') AS cleaned_interior,
       COALESCE(transmission,'unknown') AS cleaned_transmission,
       COALESCE(condition,0) AS cleaned_condition,
       COALESCE(NULLIF(color,'—'),'unknown') AS cleaned_color,
       year,
       make,
       model,
       trim,
       body,
       state,
       seller,
       odometer,
       mmr,
       sellingprice,
CASE
    WHEN odometer BETWEEN 0 AND 20000 THEN 'New/Demo'
    WHEN odometer BETWEEN 20001 AND 50000 THEN 'Low Mileage'
    WHEN odometer BETWEEN 50001 AND 70000 THEN 'Mid-Mileage'
    WHEN odometer BETWEEN 70001 AND 90000 THEN 'High Mileage'
    ELSE 'Legacy'
    END AS Mileage_Category,
CASE 
    WHEN (sellingprice - mmr) > 1000 THEN 'High Margin'
    WHEN (sellingprice - mmr) BETWEEN 0 AND 1000 THEN 'Medium Margin'
    ELSE 'Low Margin'
    END AS Margin_category,
CASE 
        WHEN condition BETWEEN 0 AND 19 THEN 'Poor (1-19)'
        WHEN condition BETWEEN 20 AND 29 THEN 'Fair (20-29)'
        WHEN condition BETWEEN 30 AND 39 THEN 'Good (30-39)'
        WHEN condition BETWEEN 40 AND 49 THEN 'Excellent (40-49)'
        ELSE 'Unknown'
    END AS condition_category,
CASE 
        WHEN sellingprice <= 10000 THEN 'Budget (Under 10k)'
        WHEN sellingprice <= 25000 THEN ' Mainstream (10k-25k)'
        WHEN sellingprice <= 60000 THEN 'Premium (25k-60k)'
        ELSE 'Exotic (Over 60k)'
    END AS price_category,
CASE 
        WHEN year >= 2013 THEN 'Latest Model (2013-2015)'
        WHEN year >= 2008 THEN 'Mid-Age Model (2008-2012)'
        WHEN year >= 2000 THEN 'Older Model (2000-2007)'
        ELSE 'Vintage (Pre-2000)'
    END AS model_year_category
FROM `retailanalysis`.`default`.`bright_car_sales`
GROUP BY SPLIT_PART(saledate,' ',2),
         SPLIT_PART(saledate,' ',1),
         SPLIT_PART(saledate,' ',3),
         SPLIT_PART(saledate,' ',4), 
         COALESCE(NULLIF(interior,'—'),'unknown'),
         COALESCE(transmission,'unknown'),
         COALESCE(condition,0),
         COALESCE(NULLIF(color,'—'),'unknown'),
         year,
         make,
         model,
         trim,
         body,
         state,
         seller,
         condition,
         odometer,
         mmr,
         sellingprice;
