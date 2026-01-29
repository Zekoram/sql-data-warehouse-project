# 🏭 My Data Warehouse Project

## 👋 About This Project
I built a modern **Data Warehouse** to practice Data Engineering. The goal was to take messy sales data, clean it up, and organize it so it can be used for business reports.

I used the **Medallion Architecture** (Bronze, Silver, Gold) to structure the data properly.

---

## 🏗️ How I Built It (The Architecture)
I divided the project into three main layers (like a filter system):

| Layer | Name | What it does |
| :--- | :--- | :--- |
| 🥉 | **Bronze Layer** | Stores the **Raw Data** exactly as it came from the source (messy). |
| 🥈 | **Silver Layer** | **Cleans** the data. I fixed errors, formatted dates, and removed bad rows here. |
| 🥇 | **Gold Layer** | **Ready for Business.** The data is organized into a Star Schema for reporting. |

---

## 🛠️ Tools I Used
| Tool | Purpose |
| :--- | :--- |
| **SQL Server** | To store and manage the database. |
| **SQL (SSMS)** | To write the code and queries. |
| **Draw.io** | To design the diagrams and plans. |
| **CSV Files** | The raw source data (ERP and CRM systems). |

---

## 📂 Project Structure
Here is how my files are organized:
* `datasets/` -> The CSV files (Raw data).
* `scripts/bronze/` -> Code to load raw data.
* `scripts/silver/` -> Code to clean the data.
* `scripts/gold/` -> Code to finalize the data for reports.

---

## 🚀 What I Learned
* How to build a complete **ETL Pipeline** (Extract, Transform, Load).
* How to design a **Star Schema** (Fact and Dimension tables).
* How to handle data quality issues (cleaning nulls, duplicates, etc.).

---

## 🙏 Credits & Reference
This project was built by following the **Data Warehouse Project** by **Data With Baraa**.
* **Original Course:** [Data With Baraa on YouTube](https://www.youtube.com/@DataWithBaraa)
* **License:** MIT License (Open Source).

---

| 📧 **Email** | [your-email@example.com](mailto:your-email@example.com) |
| 🐙 **GitHub** | [Click Here to view my Work](#) |
