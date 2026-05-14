# API Test Automation Framework

A reusable Python-based API test automation framework built with `pytest` and BDD.

[![API Tests](https://github.com/terebery/test-automation-framework/actions/workflows/tests.yml/badge.svg)](https://github.com/terebery/test-automation-framework/actions)
[![Allure Report](https://img.shields.io/badge/Allure-Report-brightgreen)](https://terebery.github.io/test-automation-framework/)
[![Python](https://img.shields.io/badge/Python-3.13-blue)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Stack

| Tool | Purpose |
|------|---------|
| Python 3.13+ | Core language |
| pytest | Test runner |
| requests | HTTP client |
| pytest-bdd | BDD scenarios (Gherkin) |
| jsonschema | JSON schema validation |
| Poetry | Dependency management (`pyproject.toml`) |
| Allure | Test reporting |
| GitHub Actions | CI/CD |

---

## Project Structure
```
test-automation-framework/
├── API/
│   ├── clients/        # API client wrappers
│   ├── tests/          # Test files
│   └── config.py       # Base URL and config
├── features/           # Gherkin .feature files
├── steps/              # BDD step definitions
├── conftest.py         # Shared fixtures
├── pytest.ini          # Pytest configuration
├── pyproject.toml      # Project config and dependencies
└── poetry.lock         # Locked dependency versions
```

---

## Features

- REST API testing (GET, POST, PUT, DELETE)
- BDD scenarios written in Gherkin
- JSON schema validation
- Parametrized tests
- Automatic CI execution on every push
- Allure reports published to GitHub Pages

---

## How to run locally

**1. Clone the repo**
```bash
git clone https://github.com/terebery/test-automation-framework.git
cd test-automation-framework
```

**2. Install Poetry**
```bash
pip install poetry
```

If `poetry` command is not available, reopen terminal and verify:

```bash
poetry --version
```

**3. Install dependencies from `pyproject.toml`**

```bash
poetry install
```

**4. Run tests**
```bash
poetry run pytest
```

**5. Generate Allure report**
```bash
poetry run pytest
allure serve allure-results
```

> `pytest.ini` already configures `--alluredir=allure-results`, so no extra flag is needed.

## Optional: export `requirements.txt` for external CI/tools

```bash
poetry export -f requirements.txt --output requirements.txt --without-hashes
```

---

## Test Report

Live Allure report available here:
👉 [View Allure Report](https://terebery.github.io/test-automation-framework/)