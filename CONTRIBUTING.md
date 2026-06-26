# Contributing to Speech Recognition AI

Thank you for considering a contribution — this project spans ML, backend,
and frontend, so contributions of all kinds are welcome: bug fixes, new
agents, model swaps, documentation, tests, and UI polish.

## Development setup

```bash
git clone https://github.com/<your-username>/speech-recognition-ai.git
cd speech-recognition-ai
cp .env.example .env
make up          # starts the full stack via Docker Compose
make migrate      # applies database migrations
```

For backend-only iteration without Docker:

```bash
cd backend
python -m venv .venv && source .venv/bin/activate
pip install -r requirements-dev.txt
uvicorn app.main:app --reload
```

For frontend-only iteration:

```bash
cd frontend
npm install
npm run dev
```

## Project structure

See `docs/architecture.md` for the full system design. In short:

- `backend/app/services/*` — one directory per capability (speech, diarization,
  emotion, biometrics, llm, rag, summarization, translation, agents, ...).
  Each is designed to be swappable independently.
- `backend/app/api/v1/endpoints/*` — thin FastAPI route handlers; business
  logic belongs in `services`, not here.
- `backend/app/tasks/*` — Celery tasks for anything CPU/GPU-heavy.
- `frontend/app/*` — Next.js App Router pages; `frontend/components/*` for
  reusable UI.

## Adding a new LLM provider

1. Create `backend/app/services/llm/<provider>_provider.py` implementing the
   `LLMProvider` ABC (`base.py`).
2. Register it in `backend/app/services/llm/factory.py`.
3. Add any new settings to `backend/app/core/config.py` and `.env.example`.
4. No other code needs to change — that's the point of the plugin boundary.

## Adding a new agent

1. Create `backend/app/services/agents/<name>_agent.py` implementing
   `BaseAgent` (`can_handle` + `run`).
2. Register it in `AgentOrchestrator.specialist_agents` (`orchestrator.py`).
3. Add unit tests for `can_handle`'s routing heuristics — these are the most
   important tests for a new agent, since misrouting is the most common bug.

## Code style

- Python: `black` + `ruff`, enforced in CI. Run `make fmt` before committing.
- TypeScript: `next lint` + `prettier`, enforced in CI.
- Type hints are required on all new Python functions; `mypy` runs in CI in
  non-blocking (warn-only) mode for now — see `pyproject.toml`.

## Tests

```bash
make test          # backend tests in Docker
make test-local     # backend tests against your local Python env
```

New features should ship with unit tests for any pure logic (parsers,
chunking, scoring) and integration tests for new API endpoints, mocking the
ML/storage boundary the way `backend/tests/integration` already does — see
`backend/tests/conftest.py` for the pattern. Heavy ML model loading should
never run in the test suite; mock at the engine boundary (`asr_engine`,
`diarization_engine`, etc.) instead.

## Commit messages

Conventional Commits are preferred (`feat:`, `fix:`, `docs:`, `refactor:`,
`test:`, `chore:`) since they make the changelog and release notes easier to
generate, but this isn't strictly enforced.

## Pull requests

- Keep PRs focused on one change.
- Link the issue it resolves, if any.
- Fill out the PR template checklist (tests, lint, docs).
