# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability, please **do not** open a public
GitHub issue. Instead, email the maintainers privately (see repository
contact details) with:

1. A description of the vulnerability and its potential impact
2. Steps to reproduce
3. Any suggested remediation

We aim to acknowledge reports within 72 hours and to ship a fix or
mitigation plan within 30 days for confirmed high-severity issues.

## Scope notes specific to this project

- **Voice commands** (`app/services/voice_commands`): this subsystem can
  launch applications and open URLs on the host machine. It must never be
  exposed on a server that isn't the user's own device. See
  `docs/user-guide.md`.
- **Recordings contain sensitive audio** (meetings, interviews, personal
  notes). MinIO and Postgres should be encrypted at rest in any
  multi-tenant or cloud deployment — see `docs/deployment.md`.
- **LLM providers**: when `LLM_PROVIDER` is set to a cloud provider
  (OpenAI/Anthropic/Gemini), transcript content is sent to that provider's
  API. Use `LLM_PROVIDER=local` (Ollama) for fully offline/private
  deployments.
