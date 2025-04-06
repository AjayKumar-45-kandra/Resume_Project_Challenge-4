# 💼 Ad-Hoc Analysis – AtliQ Hardwares (CodeBasics Resume Project Challenge #4)


## 📊 Project Overview

This project was developed as part of the **CodeBasics Resume Project Challenge #4**. It simulates a real-world business scenario involving **AtliQ Hardwares**, a leading (imaginary) computer hardware company in India.

The company’s management lacked proper **insights** for making quick, data-informed decisions. As part of a hiring process, I took on the challenge to analyze data, derive actionable insights, and present them in a clear and concise format.

---

## 🧠 Problem Statement

> The management at **AtliQ Hardware** needed help from the data team to answer critical business questions.  
> They want to expand the team with junior data analysts and designed this SQL & visualization challenge to assess both technical and soft skills.

---

## 🛠 Tools Used

- **SQL** (MySQL)
- **Power BI**
- **Microsoft PowerPoint**

---

## 📁 Data Model

The data model was built by connecting multiple fact and dimension tables to enable meaningful analysis. 

### 🧾 Fact Tables

| Table Name                 | Description                                       |
|----------------------------|---------------------------------------------------|
| `fact_sales_monthly`       | Monthly gross sales data per product and customer |
| `fact_gross_price`         | Product price details                             |
| `fact_manufacturing_cost`  | Manufacturing cost per product                    |
| `fact_pre_invoice_deductions` | Discounts applied before invoicing            |

### 🧭 Dimension Tables

| Table Name     | Description                                   |
|----------------|-----------------------------------------------|
| `dim_customer` | Customer information (name, region, etc.)     |
| `dim_product`  | Product details (code, segment, division)     |
| `dim_market`   | Market-related geography info                 |
| `dim_date`     | Calendar information (year, month, quarter)   |

### 🔗 Relationships

- Products and sales are linked using `product_code`
- Customers and sales are linked via `customer_code`
- Dates are joined through `date` or `fiscal_year`
- Discounts and costs are associated at the product level

This star schema helped drive efficient querying and visualization in Power BI.

---

## 🔍 Key Business Questions Answered

### 1. **Markets of "AtliQ Exclusive" in APAC region**
Identified which APAC markets the key customer operates in.

### 2. **% Increase in Unique Products (2021 vs 2020)**
Analyzed product diversity growth year-over-year.

### 3. **Unique Products by Segment**
Notebooks, Accessories, and Peripherals make up **83%** of the total unique product count.

### 4. **Segment-wise Increase in Products (2021 vs 2020)**
Accessories, Notebooks, and Peripherals led the growth.

### 5. **Products with Highest and Lowest Manufacturing Costs**
Reported the cost extremes across all products.

### 6. **Top 5 Customers with High Avg. Discount in FY 2021 (India)**
Identified which customers benefited from the highest average pre-invoice discounts.

### 7. **Monthly Gross Sales of "AtliQ Exclusive"**
Captured a significant drop in March 2020 due to the pandemic.

### 8. **Quarter with Maximum Sales in 2020**
**Q1 2020** had the highest sales; **Q3 2020** saw a dip due to COVID-19 impact.

### 9. **Top Sales Channel in FY 2021**
**Retailers** contributed **73.22%** to gross sales.

### 10. **Top 3 High-Selling Products per Division (FY 2021)**
Identified the best-selling products by division.

---

## 🖼 Presentation

The insights were visualized and shared in a PowerPoint presentation:  
📂 `AD-HOC ANALYSIS PPT.pptx`

---

## 📌 Key Takeaways

- Strong command of SQL for analytical queries
- Ability to generate business insights and communicate them effectively
- Proficiency in Power BI and storytelling through visual tools

---



