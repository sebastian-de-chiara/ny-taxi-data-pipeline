# New York Taxi Data Pipeline

End-to-end data pipeline for NYC taxi trip data (yellow, green, FHV, HVFHV). Data is sourced as parquet files from the [NYC TLC](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page), landed in S3, transformed via dbt in Snowflake, orchestrated by Airflow, and visualised in Power BI.

## Architecture

```
NYC TLC Website (Parquet)
    → Python ingestion script
    → S3 (raw)
    → Snowflake (raw tables)
    → Soda scan (raw validation)
    → dbt staging → intermediate → mart models
    → Soda scan (mart validation)
    → Power BI dashboards
```

Orchestrated end-to-end by Airflow. Infrastructure managed by Terraform.

## Tech Stack

| Category | Tool |
|---|---|
| Language | Python (uv, ruff) |
| Warehouse | Snowflake |
| Cloud | AWS (S3, Secrets Manager, CloudWatch) |
| Transformations | dbt-core |
| Orchestration | Airflow (Astro CLI) |
| Infrastructure | Terraform |
| Visualisation | Power BI |
| Data Quality | dbt tests + Soda |
| Testing | pytest + pytest-cov |
| Logging | structlog |

## Project Structure

```
ny-taxi-data-pipeline/
├── .github/workflows/   # CI/CD pipeline definitions
├── airflow/             # Astro CLI project, DAGs
├── dbt/                 # dbt project (models, macros, tests)
├── docs/                # Project documentation
├── src/                 # Python source code (ingestion, utilities)
├── terraform/           # Infrastructure as code
│   └── bootstrap/       # State backend (S3 bucket)
├── tests/               # pytest (unit + integration)
├── .gitignore
├── .pre-commit-config.yaml
├── Makefile
├── pyproject.toml
└── README.md
```

## Prerequisites

- WSL 2 with Ubuntu 24.04
- Python 3.13+ (managed by uv)
- Terraform 1.14+
- Docker Engine
- Astro CLI
- AWS CLI (configured with named profile `ny-taxi`)
- Snowflake account

## Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:<username>/ny-taxi-data-pipeline.git
   cd ny-taxi-data-pipeline
   ```

2. Install Python dependencies:
   ```bash
   uv sync
   ```

3. Install pre-commit hooks:
   ```bash
   pre-commit install
   ```

4. Initialise Terraform:
   ```bash
   cd terraform/bootstrap
   terraform init
   ```

## Usage

```bash
make lint              # Run ruff linter (check only)
make format            # Auto-fix lint issues and format code
make test              # Run unit tests
make test-cov          # Run tests with coverage report
make test-integration  # Run integration tests
make dbt-test          # Run dbt tests
make dbt-docs          # Generate and serve dbt documentation
make soda-check        # Run Soda data quality scans
make tf-plan           # Run terraform plan
make sql-lint          # Lint dbt SQL models
make sql-fix           # Auto-fix dbt SQL models
make airflow-start     # Start local Airflow
make airflow-stop      # Stop local Airflow
make clean             # Remove caches and compiled files
```

## Environments

| Environment | S3 Prefix | Snowflake Database | Purpose |
|---|---|---|---|
| dev | `ny-taxi-dev-` | `NY_TAXI_DEV` | Local development |
| test | `ny-taxi-test-` | `NY_TAXI_TEST` | CI/CD validation |
| prod | `ny-taxi-prod-` | `NY_TAXI_PROD` | Production pipeline |

## Data Source

All available trip types from the [NYC Taxi & Limousine Commission](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page):
- Yellow taxi (2009+)
- Green taxi (2013+)
- For-Hire Vehicle (FHV)
- High Volume For-Hire Vehicle (HVFHV)

Historical scope: all available data by default, parameterised for date range selection.
