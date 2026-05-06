# subscription_analytics_new_tech_companies
Subscription Analytics for New Tech Companies (PostgreSQL Project

Project Overview

This project analyzes subscription and customer behavior data for tech companies using PostgreSQL.
It focuses on identifying churn patterns, revenue metrics, and customer engagement signals.

The dataset includes accounts, subscriptions, churn events, and support tickets, allowing for end-to-end business analysis.

🗂️ Project Structure
new_tech_companies_subscriptions/
│
├── data/
│   └── *.csv                  # Raw datasets
│
├── processed_data/
│   └── *.csv                  # Cleaned / transformed data
│
├── queries/
│   └── queries.sql            # SQL analysis queries
│
├── vis/
│   └── (coming soon)          # Dashboards / visualizations
│
└── README.md
🧱 Database Schema

The project is built on a relational database with 4 main tables:

accounts

Customer-level information:

industry, country, signup date
referral source
plan tier, seats, trial status
subscriptions

Subscription lifecycle and revenue:

start/end dates
MRR and ARR
billing frequency
upgrade/downgrade flags
churn_events

Churn tracking:

churn date
reason codes
refund amounts
reactivation flags
support_tickets

<img width="1280" height="820" alt="model" src="https://github.com/user-attachments/assets/a8513d03-b8e7-4cc5-8ab6-a24e57009900" />


Customer support activity:

resolution time
response time
priority levels
🔗 Relationships
One account → many subscriptions
One account → many churn events
One account → many support tickets

This is implemented using foreign keys in PostgreSQL.

📊 Key Analyses
📌 Customer & Account Insights
Most popular industry by country
Referral source distribution
⚠️ Churn Analysis
Refund amounts by churn reason
Upgrade, downgrade, and reactivation patterns
Churn distribution across segments
💰 Subscription Metrics
Subscription duration analysis
Longest active subscriptions by plan
Billing frequency distribution
🎫 Support Analysis
Average resolution time by priority
Average response time by priority
🚀 Advanced Metrics

The project also includes business-critical KPIs:

Churn Rate
Monthly Recurring Revenue (MRR)
Customer Segmentation
Support Impact on Churn
🛠️ Tech Stack
PostgreSQL
SQL (joins, aggregations, window functions)
(Planned) Tableau / Power BI
▶️ How to Run
Create a PostgreSQL database
Create tables using your schema
Import data from /data
(Optional) Use /processed_data if transformations are applied
Run analysis queries:
queries/queries.sql
🎯 Key Learning Outcomes
Designing relational data models
Writing analytical SQL queries
Working with real-world business metrics
Understanding churn and revenue dynamics

Dashboard:
<img width="1171" height="658" alt="dashboard" src="https://github.com/user-attachments/assets/9aac91db-1e6b-430b-a6a9-05c5a53ad88d" />


👤 Author

Dmitruz Ruzhytskyi
GitHub: https://github.com/dmitruzik
