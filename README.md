# 🍏 Apple Sales Analysis – SQL + Power BI Project

## 📌 Project Overview
This project analyzes Apple sales data using SQL and Power BI. It focuses on sales trends, product performance, warranty claims, and store performance, offering insights into business operations and product quality.

- **Tools**: PostgreSQL (SQL), Power BI  
- **Dataset**: Apple Sales Data (Sales, Products, Warranty, Stores, etc.)  

---

## 🎯 Objectives

- Set up and query a structured Apple sales database  
- Clean and prepare the data using SQL  
- Explore sales, warranty claims, and product trends  
- Build an interactive dashboard in Power BI for business stakeholders  

---

## 🗂️ Dataset Description

| Table Name     | Column Name            | Description                                      |
|----------------|------------------------|--------------------------------------------------|
| **stores**     | store_id               | Unique identifier for each store                 |
|                | store_name             | Name of the store                                |
|                | city                   | City where the store is located                  |
|                | country                | Country of the store                             |
| **category**   | category_id            | Unique identifier for each product category      |
|                | category_name          | Name of the category                             |
| **products**   | product_id             | Unique identifier for each product               |
|                | product_name           | Name of the product                              |
|                | category_id            | References the category table                    |
|                | launch_date            | Date when the product was launched               |
|                | price                  | Price of the product                             |
| **sales**      | sale_id                | Unique identifier for each sale                  |
|                | sale_date              | Date of the sale                                 |
|                | store_id               | References the stores table                      |
|                | product_id             | References the products table                    |
|                | quantity               | Number of units sold                             |
| **warranty**   | claim_id               | Unique identifier for each warranty claim        |
|                | claim_date             | Date the claim was made                          |
|                | sale_id                | References the sales table                       |
|                | repair_status          | Status of the warranty claim (e.g., Paid Repaired, Warranty Void) |

---

## 🖼️ ER Diagram

![Apple Sales ER Diagram](Path_to_ER_Diagram.png)

---

## 📈 Power BI Dashboard

### 🔹 Page 1: Sales Overview  
**Goal:** Show KPIs and category-level performance.  

**Visuals:**  
- **KPI Cards**: Total Sales, Total Units Sold, Average Price per Product  
- **Line Chart**: Sales Trend by Month/Year  
- **Bar Chart**: Top 5 Stores by Total Sales  
- **Bar Chart**: Top 5 Categories by Sales  
- **Map Chart**: Sales by Country  

![Sales Overview](Path_to_ER_Diagram.png)
---

### 🔹 Page 2: Store & Regional Analysis  
**Goal:** Provide insights into product launches and store performance.  

**Visuals:**  
- **Line Chart**: Product Launches Over Time  
- **Bar Chart**: Top 5 Products by Sales  
- **Treemap**: Revenue Breakdown by Product  
- **Pie Chart**: Top 5 Categories by Sales  
- **Bar Chart**: Average Selling Price by Category  
- **Map Chart**: Sales by City  

![Store & Regional Analysis](Path_to_ER_Diagram.png)
---

### 🔹 Page 3: Warranty Analysis  
**Goal:** Analyze warranty claims and repair status.  

**Visuals:**  
- **KPI Cards**: Total Warranty Claims, Warranty Claim Rate  
- **Line Chart**: Warranty Claims Over Time  
- **Pie Chart**: Repair Status Breakdown  
- **Bar Chart**: Top 5 Stores by Warranty Claims  
- **Bar Chart**: Top 5 Products by Warranty Claims  
![Warranty Analysis](Path_to_ER_Diagram.png)
---

## SQL Queries for Apple Sales Analysis

### 1. Number of Stores by Country
```sql
SELECT country, COUNT(store_id) AS Total_Stores
FROM stores
GROUP BY country
ORDER BY Total_Stores DESC;
