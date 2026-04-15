# Coding Standards

## Python

### Type Hints

All functions must have type annotations on parameters and return types. Enforced by ruff rule `ANN`.

```python
# Good
def download_file(url: str, dest: Path, timeout: int = 30) -> Path:
    ...

# Bad — missing return type and parameter annotations
def download_file(url, dest, timeout=30):
    ...
```

### Docstrings

All public functions, classes, and modules must have docstrings. Google style. Enforced by ruff rule `D`.

```python
def download_parquet(url: str, dest: Path, timeout: int = 30) -> Path:
    """Download a parquet file from the TLC website.

    Args:
        url: Full URL to the parquet file.
        dest: Local directory to save the file.
        timeout: Request timeout in seconds.

    Returns:
        Path to the downloaded file.

    Raises:
        DownloadError: If the request fails after retries.
    """
```

### Imports

Sorted automatically by ruff (`I` rule — isort). Order: standard library, third-party, local.

### Logging

Use `structlog` for all logging. Never use the built-in `logging` module directly.

```python
import structlog

logger = structlog.get_logger()

logger.info("downloading_file", url=url, dest=str(dest))
```

### Tests

Tests live in `tests/` and are relaxed on style rules — no type hints or docstrings required. Test function names should be descriptive.

```python
def test_download_parquet_creates_file_in_dest_directory():
    ...

def test_download_parquet_raises_on_404():
    ...
```

## SQL (dbt)

- Linted by SQLFluff with the Snowflake dialect
- dbt Jinja templating supported via `sqlfluff-templater-dbt`
- Style rules TBD — will be configured in `.sqlfluff` when dbt project is initialised

## Terraform

- Formatted by `terraform fmt` (enforced via pre-commit hook)
- All resources tagged with `Project` and `Environment` via provider `default_tags`
- Per-resource `Name` tag
- No variable interpolation in backend blocks (Terraform limitation)

## Git

- Use modern commands: `git switch` (not `git checkout`), `git restore` (not `git checkout --`)
- Feature branches for all work: `feature/`, `fix/`, `chore/`
- PR-based workflow with self-review
- Pre-commit hooks must pass before committing
