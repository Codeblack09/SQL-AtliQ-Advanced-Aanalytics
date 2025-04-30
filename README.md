# SQL-AtliQ-Advanced-Aanalytics
This SQL project defines how to analyze data using SQL using skillset varying from basic to advanced level.

# 📊 SQL Procedures & Views for Business Intelligence

This repository contains advanced SQL scripts designed to power business insights for a retail dataset. The queries include stored procedures, views, and CTE-based logic that enable deep analytics across sales, market performance, and customer segmentation.

---

## 📁 Contents

- **Stored Procedure 1**: `get_market_badge`
- **Stored Procedure 2**: `get_top_n_markets_per_division_by_gross_sales_mlns`
- **View**: `gross_price`
- **CTE-Based Query**: Top 2 markets per region by gross sales (FY 2021)

---

## 🧩 Query Descriptions

### 🔹 1. `get_market_badge` [Stored Procedure](https://github.com/Codeblack09/SQL-AtliQ-Advanced-Aanalytics/blob/main/get_market_badge_stored_procedure.sql) 
**Purpose**: Assigns a badge (Gold/Silver) to a market based on total sold quantity for a given fiscal year.

**Parameters**:
- `in_market` (IN): Name of the market (default = 'India' if empty).
- `in_fiscal_year` (IN): Year of analysis.
- `out_badge` (OUT): Resulting badge (`Gold` if sold quantity > 5,000,000, else `Silver`).

**Logic**:
- Calculates total quantity sold in a market for the year.
- Uses conditional logic to assign a "Gold" or "Silver" badge based on performance.

---

### 🔹 2. `get_top_n_markets_per_division_by_gross_sales_mlns` [Stored Procedure](https://github.com/Codeblack09/SQL-AtliQ-Advanced-Aanalytics/blob/main/get_top_n_markets_per_division_by_gross_sales_mln_stored_procedure.sql)
**Purpose**: Retrieves top N markets per region based on gross sales (in millions) for a selected fiscal year.

**Parameters**:
- `in_fiscal_year` (IN): Target fiscal year.
- `in_top_n` (IN): Number of top markets to return per region.

**Logic**:
- Uses Common Table Expressions (CTEs) to:
  1. Calculate gross sales per item.
  2. Aggregate sales per market and region.
  3. Rank markets within each region.
- Returns only the top N ranked markets by sales volume.

---

### 🔹 3. `gross_price` [SQL View](https://github.com/Codeblack09/SQL-AtliQ-Advanced-Aanalytics/blob/main/gross_price_view.sql)
**Purpose**: A consolidated view that combines sales, customer, product, and pricing data.

**Fields Returned**:
- `date`, `fiscal_year`, `customer_code`, `market`, `product_code`, `sold_quantity`
- `gross_price_per_item`, `gross_price_total` (calculated)

**Logic**:
- Joins `fact_sales_monthly`, `dim_customer`, `dim_product`, and `fact_gross_price`.
- Computes total gross sales for each transaction (sold quantity × price).

**Usage**:
- Great for quick analysis without manually joining multiple tables.
- Used frequently in dashboards and summary reports.

---

### 🔹 4. Top 2 Markets per Region by Gross Sales [CTE Query](https://github.com/Codeblack09/SQL-AtliQ-Advanced-Aanalytics/blob/main/top_2_markets_per_region_by_net_sales_mln.sql)
**Purpose**: Returns the top 2 performing markets within each region for fiscal year 2021.

**Logic**:
- Similar structure to Procedure #2 but hardcoded for:
  - `fiscal_year = 2021`
  - `top 2` ranks only
- Uses three CTEs for calculation, aggregation, and ranking.

**Use Case**:
- Can be embedded into dashboards or exported for reporting.
- Helps in identifying regional outperformers for strategic planning.

---

## 💡 How to Use

To run these procedures and queries:
1. Load your dataset and ensure schema names match (`fact_sales_monthly`, `dim_customer`, etc.).
2. Run the view and procedure creation scripts.
3. Execute the stored procedures with appropriate parameters.

Example:
```sql
CALL get_market_badge('India', 2021, @badge);
SELECT @badge;
