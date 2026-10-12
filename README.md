# E-commerce Analytics Data Warehouse

A hands-on Data Engineering portfolio project that uses PostgreSQL, SQL, and dbt to transform e-commerce order data into analytical fact and dimension models.

## Project Overview

This project demonstrates dimensional modeling, SQL transformations, data-quality testing, and systematic debugging in an analytical data warehouse. The models support analysis of sales, customers, products, dates, locations, and shipping information.

## Data Model

The project includes the following models:

- `stg_orders`: staging model for order data.
- `dim_customer`: customer dimension.
- `dim_product`: product dimension.
- `dim_date`: calendar dimension supporting both order dates and shipping dates.
- `dim_location`: location dimension.
- `fct_orders`: fact table with one row per order line.

The fact table includes sales, customer and product surrogate keys, order and shipping date keys, a location key, shipping mode, and shipping duration.

The `models/analytics/` directory contains reporting models for sales by category (latest year), customer, month, and region.

## Engineering Challenges and Solutions

### Date Dimension Coverage

The initial date spine covered order dates but did not include every shipping date. This caused 48 missing `ship_date_key` values. I updated the date spine to cover both order dates and shipping dates, rebuilt the affected models, and verified that the missing shipping-date keys were resolved.

### Join Fan-Out and Row-Level Validation

I checked dimension join keys for uniqueness and investigated whether joins could multiply fact rows. Validation confirmed 9,800 order lines, matching the staging row count, and 9,800 distinct `row_id` values.

### Data Quality

I implemented dbt tests covering uniqueness, required values, and relationships between fact and dimension models. Eleven source rows had incomplete location attributes; these were investigated as source-data gaps rather than incorrectly treating them as join failures.

## Validation Results

The final local `dbt build` completed successfully: 30 of 30 resources passed. The build included five table models, 20 tests, and five views.

## Technology Stack

- PostgreSQL
- SQL
- dbt
- Dimensional modeling and star schemas
- Data-quality testing

## Project Structure

- `models/`: staging, dimension, fact, and analytics models
- `models/schema.yml`: model tests and data-quality rules
- `models/sources.yml`: source definitions
- `macros/`: reusable SQL macros
- `seeds/`: dbt seed directory
- `snapshots/`: dbt snapshots
- `tests/`: custom data tests
- `dbt_project.yml`: dbt project configuration

## Running the Project

A PostgreSQL database containing the configured source data is required. The source data must be loaded according to the definitions in `models/sources.yml`, and a local dbt profile for PostgreSQL must be configured.

1. Install dbt with the PostgreSQL adapter in your Python environment.
2. Configure your local dbt profile without placing credentials in this repository.
3. Confirm the connection with `dbt debug`.
4. Run the models and tests with `dbt build`.

Source-data setup may need to be completed separately; this repository does not include database credentials.

## About This Project

This is an independent portfolio project built to demonstrate hands-on practice in SQL, PostgreSQL, dbt, dimensional modeling, data-quality validation, and systematic debugging.
