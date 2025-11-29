## dbt + SQL Server 2022: Order-Level Incremental Pipeline with Snapshots, CI & Lineage

A full end-to-end Analytics Engineering project built using dbt Core on top of SQL Server 2022, with:

Clean staging → intermediate → mart structure

A true order-level incremental fact model

A snapshot (SCD-style) of the customer dimension

Data quality tests, including a custom generic test

GitHub Actions CI for dbt deps, dbt parse, and SQLFluff

Exposures showing how a dashboard consumes the mart

Fully browsable dbt Docs with lineage

This project uses AdventureWorksDW2022, a classic Microsoft sample data warehouse.

---
# 🛠 Tech Stack
Area	Tools
Transformation	dbt-core 1.9
Database	SQL Server 2022
Adapter	dbt-sqlserver
CI	GitHub Actions
Linting	SQLFluff + dbt templater
CI-only database	DuckDB (safe profile, no secrets)
Language	Python 3.12
Docs	dbt Docs

# 📊 Pareto Sales Analysis (dbt + Power BI)

This repo includes a complete side project showing how to go from raw operational data to a **fully analytics-ready mart** and a **Pareto dashboard**.

### **Business question**
> **Which products drive 80% of total company revenue, and how is that revenue distributed by category?**

### **Pipeline summary**

#### 🗂️ Staging  
- `stg_fact_internet_sales`  
- `stg_fact_reseller_sales`  
- `stg_dim_product`  
- `stg_dim_product_subcategory`  
(standardized column names, cleaned types, removed unused fields)

#### 🔄 Intermediate  
- `int_tot_sales_fact`  
  - Combines Internet + Reseller sales  
  - Unified revenue metric  
  - Product keys + category keys  
  - Channel indicators  

#### 📦 Mart  
- `fct_sales_pareto`  
  - Product-level revenue  
  - Rank by descending sales  
  - Running cumulative total  
  - Cumulative share of company-wide sales  
  - 80% cutoff flag  

All Pareto logic is computed in **dbt SQL**, not in Power BI.

---

# 📈 Power BI Dashboard

A one-page dashboard built directly on top of the mart `fct_sales_pareto`.

It includes:

- KPI cards (total share covered, product count, category count)  
- Treemap of top product categories  
- Horizontal bar chart of top products  
- Detailed product table  
- **Pareto curve** (bars = sales, line = cumulative %)

📷 _Screenshot available in `/docs/pareto_bi_report.png`_  

🧩 Project Structure
1. Staging models

Clean, renamed fields from raw DW tables:

sales__order_header: cleans and renames FactInternetSales

customers__dim_customer: cleaned customer dimension

2. Intermediate model

int_sales_fact

Aggregates line-level rows into order-level facts

Implements incremental refresh using order_date

Adds line_count and updated_at columns

Has unique constraint on sales_order_number

3. Mart

fct_sales_daily

Daily summary of total sales and order count

Used by exposure (dashboard)

4. Snapshot

snapshots/customer_snapshot.sql

SCD-style check strategy

Tracks historical changes in customer data

Correctly “de-identitied” (source CustomerKey cast to avoid SQL Server IDENTITY propagation)

5. Exposure

daily_sales_overview

Conceptual dashboard

Shows downstream consumption

Appears in dbt Docs lineage (see screenshot)

🧪 Data Tests

Tests implemented:

not_null

unique

relationships

custom generic test (percent_nulls_under_threshold)

accepted_range via dbt-utils

These validate:

Grain of int_sales_fact

CustomerKey integrity

Null ratio on order_amount

DimCustomer uniqueness

Staging model quality

🔄 CI/CD Pipeline

GitHub Actions runs:

dbt deps

dbt parse

sqlfluff lint .

Screenshot from CI:

CI uses a DuckDB profile to avoid database secrets in the cloud.

## Comments
AdventureWorksDW2022 is a static demo DB with last orders in 2014. Freshness is configured with a very wide window so that dbt can still demonstrate freshness checks without constantly flagging the sample data as stale
