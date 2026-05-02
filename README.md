# 🚗 Bright Motors: Car Sales Analytics & Inventory Optimization

## 📌 Project Overview
Bright Motors has appointed a new Head of Sales with a mission to expand the dealership network and optimize inventory performance. As a Junior Data Analyst, I performed an **End-to-End Data Analysis** on historical car sales data to extract actionable insights regarding revenue, market trends, and vehicle depreciation.

## 🎯 Business Objectives
* **Revenue Analysis:** Identify high-performing makes and models to maximize income.
* **Inventory Segmentation:** Categorize vehicles by mileage, price, and condition for better lot management.
* **Market Trends:** Analyze sales distribution by geography (states) and time to guide expansion.
* **Profitability:** Determine profit margins by comparing selling prices against the Market Management Record (MMR).

## 🛠️ Tech Stack
* **SQL (Databricks):** Data Extraction, Transformation, and EDA.
* **Excel/Power BI:** Data Visualization & Interactive Dashboards.
* **Miro:** Architecture & Data Flow Planning.

---

## 🔍 Data Exploration (EDA Summary)
Initial exploration of the `bright_car_sales` dataset revealed the following key metrics:
* **Total Sales Volume:** 550,296 unique vehicles (VIN).
* **Market Scope:** 38 States, 8 Brands, and 974 distinct Models.
* **Inventory Breadth:** Year of manufacture ranges from 1982 to 2015.
* **Odometer Range:** 1 km to 999,999 km.
* **Price Range:** $1.00 to $230,000 (identifying a need for outlier management).

---

## ⚙️ Feature Engineering & SQL Transformations

### 1. Date & Time Decomposition
To enable seasonal and daily trend analysis, I extracted granular time components from the `saledate` string:
```sql
SELECT
    SPLIT_PART(saledate,' ',2) AS Month_name,
    SPLIT_PART(saledate,' ',1) AS Day_name,
    SPLIT_PART(saledate,' ',3) AS Sale_Date,
    SPLIT_PART(saledate,' ',4) AS Sale_Year,
    SPLIT_PART(saledate,' ',5) AS Time_of_purchase
FROM bright_car_sales;
