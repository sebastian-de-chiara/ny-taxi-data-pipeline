.PHONY: lint format test test-cov test-integration dbt-test dbt-docs soda-check tf-plan airflow-start clean

# ---------- Python ----------

lint:
	uv run ruff check src/ tests/
	uv run ruff format --check src/ tests/

format:
	uv run ruff check --fix src/ tests/
	uv run ruff format src/ tests/

test:
	uv run pytest tests/ -x -q

test-cov:
	uv run pytest tests/ --cov --cov-report=term-missing

test-integration:
	uv run pytest tests/ -m integration -x -q

# ---------- dbt ----------

dbt-test:
	cd dbt && uv run dbt test

dbt-docs:
	cd dbt && uv run dbt docs generate && uv run dbt docs serve

# ---------- Soda ----------

soda-check:
	uv run soda scan -d snowflake -c soda/configuration.yml soda/checks/

# ---------- Terraform ----------

tf-plan:
	cd terraform && terraform plan

# ---------- Airflow ----------

airflow-start:
	cd airflow && astro dev start

airflow-stop:
	cd airflow && astro dev stop

# ---------- SQL Lint ----------

sql-lint:
	uv run sqlfluff lint dbt/models/ --dialect snowflake

sql-fix:
	uv run sqlfluff fix dbt/models/ --dialect snowflake

# ---------- Cleanup ----------

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf htmlcov/ .coverage
