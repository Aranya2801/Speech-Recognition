.PHONY: up down build logs backend-shell frontend-shell migrate revision seed test lint fmt clean

up:
	docker compose up -d --build

down:
	docker compose down

build:
	docker compose build

logs:
	docker compose logs -f --tail=200

backend-shell:
	docker compose exec backend bash

frontend-shell:
	docker compose exec frontend sh

migrate:
	docker compose exec backend alembic upgrade head

revision:
	docker compose exec backend alembic revision --autogenerate -m "$(m)"

seed:
	docker compose exec backend python -m app.scripts.seed_demo_data

test:
	docker compose exec backend pytest -v --cov=app --cov-report=term-missing

test-local:
	cd backend && pytest -v --cov=app --cov-report=term-missing

lint:
	cd backend && ruff check app && black --check app && mypy app
	cd frontend && npm run lint

fmt:
	cd backend && black app && ruff check --fix app
	cd frontend && npm run format

clean:
	docker compose down -v --remove-orphans
	find . -type d -name __pycache__ -exec rm -rf {} +
