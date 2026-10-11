\# E-commerce Analytics Data Warehouse



A hands-on Data Engineering portfolio project using PostgreSQL,

SQL, and dbt to transform e-commerce order data into analytical

fact and dimension models.



\## Project Overview



This project demonstrates dimensional modeling, SQL transformations,

data-quality testing, and systematic debugging in an analytical

data warehouse.



The models support analysis of sales, customers, products, dates,

locations, and shipping information.



\## Data Model



The project includes:



\- `stg\_orders`: Staging model for order data.

\- `dim\_customer`: Customer dimension.

\- `dim\_product`: Product dimension.

\- `dim\_date`: Calendar dimension supporting order and shipping dates.

\- `dim\_location`: Location dimension.

\- `fct\_orders`: Fact table containing one row per order line.



The fact table includes sales, surrogate dimension keys, date keys,

shipping mode, and shipping duration.



\## Engineering Challenges and Solutions



\### Date Dimension Coverage



The initial date spine covered order dates but did not cover every

shipping date. This caused 48 missing `ship\_date\_key` values.



I expanded the date spine to cover both order dates and shipping

dates, rebuilt the affected models, and verified that the missing

shipping-date keys were resolved.



\### Join Fan-Out and Row-Level Validation



I checked dimension join keys for uniqueness and investigated

whether joins could multiply fact rows.



Validation confirmed 9,800 order lines, matching the staging row

count, with 9,800 distinct `row\_id` values.



\### Data Quality



I implemented dbt tests covering uniqueness, required values,

and relationships between fact and dimension models.



Eleven rows had incomplete source location attributes. These were

investigated and distinguished from failures caused by incorrect

join logic.



\## Validation Results



The final local `dbt build` completed successfully, with 30 of

30 resources passing, including five table models, 20 tests,

and five views.



\## Technology Stack



\- PostgreSQL

\- SQL

\- dbt

\- Dimensional modeling

\- Data-quality testing



\## Project Structure



\- `models/`: Staging, dimension, and fact models

\- `models/schema.yml`: Model and data-quality tests

\- `models/sources.yml`: Source definitions

\- `macros/`: Reusable SQL macros

\- `seeds/`: Seed data files

\- `snapshots/`: dbt snapshots

\- `tests/`: Data tests

\- `dbt\_project.yml`: dbt project configuration



\## Running the Project



A PostgreSQL database containing the configured source data is

required.



1\. Configure a local dbt profile for PostgreSQL.

2\. Confirm the database connection with `dbt debug`.

3\. Execute the project with `dbt build`.



Database credentials and other secrets must remain outside the

public repository.



\## About This Project



This is an independent portfolio project built to demonstrate

hands-on Data Engineering skills in SQL, PostgreSQL, dbt,

dimensional modeling, data-quality validation, and debugging.
