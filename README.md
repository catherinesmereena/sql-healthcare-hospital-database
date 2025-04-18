# sql-healthcare-hospital-database
Normalized SQL database for managing hospital beds, business units, and resource types. Includes CSV imports, schema creation, and query-based reporting.

Hospital Resource Management Database – SQL Project

This repository contains a normalized SQL database and associated data files to support healthcare resource management and reporting. Designed as part of an advanced SQL course assignment, the project demonstrates how to model hospital bed usage, business units, and bed types using a fully normalized relational schema.

##  Project Overview
- Designed and implemented a healthcare database with multiple related tables
- Normalized raw CSV data into 3NF, ensuring integrity and avoiding redundancy
- Included business rules for entity relationships such as hospital location, bed availability, and unit assignments

##  Data Sources
- `bed_fact.csv`: Fact table representing daily bed usage across hospitals
- `bed_type.csv`: Dimensions detailing the types of beds (e.g., ICU, General)
- `business.csv`: Reference table of hospital entities, locations, and IDs

##  SQL Script Includes
- Table creation and primary/foreign key relationships
- Data types defined for hospital resource tracking
- `JOIN`, `GROUP BY`, and other relational queries for report generation

##  Tools Used
- MySQL · SQL · MySQL Workbench · CSV Import

##  Files Included
- `Hospital_Database_Script.sql` – Executable SQL schema
- `bed_fact.csv`, `bed_type.csv`, `business.csv` – Source data for ETL and query validation

##  Summary
This project simulates a real-world healthcare operations database, structured to optimize data integrity, resource reporting, and query performance.
