# AdventureWorks Sales Infrastructure

A MySQL star schema and SQL view layer built on top of the AdventureWorksDW2017 dataset, feeding a Tableau dashboard published to Tableau Public.

**Live dashboard:** [AdventureWorks Story on Tableau Public](https://public.tableau.com/views/adventureworks_dw/AdventureWorksStory)
**Portfolio site:** [himani-mistry.github.io/portfolio](https://himani-mistry.github.io/portfolio/)

## What this project demonstrates

This project takes a raw data warehouse export and turns it into a business-ready analytics layer:

1. **Schema design** — loaded 9 tables (1 fact, 8 dimensions) from the AdventureWorksDW2017 sample dataset into MySQL, forming a classic star schema centered on Internet Sales.
2. **View layer** — built 4 SQL views, each answering a specific business question, so the analytics logic lives in SQL rather than being recreated inside the BI tool.
3. **Dashboard** — connected the views to Tableau and built a multi-page Story summarizing the findings.

## Data source

[AdventureWorksDW2017](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure) — Microsoft's sample data warehouse, originally built for SQL Server. Exported to CSV and loaded into MySQL for this project.

## Schema

**Fact table:** `factinternetsales` (60,398 rows) — one row per order line item.

**Dimension tables:** `dimdate`, `dimproduct`, `dimproductsubcategory`, `dimproductcategory`, `dimcustomer`, `dimgeography`, `dimsalesterritory`, `dimpromotion`.

See [`sql/schema_setup.sql`](sql/schema_setup.sql) for the full schema and `LOAD DATA LOCAL INFILE` load script, and [`docs/adventureworks_schema.png`](docs/adventureworks_schema.png) for the table relationships diagram.

## Views and the questions they answer

| View | Business question |
|---|---|
| `vw_sales_by_category_month` | How is revenue trending by product category, month over month? |
| `vw_sales_by_territory` | Which regions drive the most revenue and orders? |
| `vw_customer_segments` | Who are our customers, and how much do different segments spend? |
| `vw_promotion_effectiveness` | Do promotions actually move sales, and which types work best? |

See [`sql/views_for_tableau.sql`](sql/views_for_tableau.sql) for the full definitions.

## Key findings

- **Customer concentration:** the top 9.4% of customers (spending $5,000+) generate 38.3% of total revenue — a clear long-tail customer base.
- **Promotion effectiveness:** the Volume Discount promotion shows a genuine average-order-value lift ($947 vs. $469 for no discount) across 2,075 real orders. The Touring bike promotions show larger dollar figures, but those reflect fixed-price product bundles rather than a broad promotional effect.
- **Category growth:** all three product categories (Bikes, Accessories, Clothing) peaked in 2013, the strongest year in the available data (which runs through January 2014).
- **Geography:** Australia is the single largest market by revenue, nearly double the next-highest region (Southwest US).

## Tools

- **MySQL 9.5** — schema, data load, view layer
- **Tableau Desktop / Tableau Public** — dashboard and Story
- Data cleaning handled in Python (encoding conversion, delimiter fixes) and loaded via `LOAD DATA LOCAL INFILE`

## Repo contents

```
sql/
├── schema_setup.sql            — schema creation + data load
└── views_for_tableau.sql       — the 4 business-question views
docs/
└── adventureworks_schema.png   — table relationship diagram
```
