# Changelog

All notable changes to this project are documented here. Format loosely
follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [1.0.0] - 2026-01-15

### Added
- Initial public release.
- Real-time + offline ASR via Faster-Whisper.
- Speaker diarization (pyannote.audio) + voice biometrics (SpeechBrain ECAPA-TDNN).
- Emotion detection (wav2vec2 SER) with 6-class output.
- Meeting Intelligence (minutes, decisions, action items) and Podcast Intelligence (chapters, highlights, keywords).
- RAG over personal voice memory via ChromaDB + pluggable LLM providers (OpenAI, Anthropic, Gemini, local/Ollama).
- Multi-agent assistant (speech/voice-command, search, translation, summarization, memory, general agents).
- Live translation (7 languages) and voice command framework.
- Wake word detection framework (openWakeWord).
- Next.js dashboard: live capture, transcripts, assistant chat, analytics.
- Full Docker Compose stack, GitHub Actions CI/CD, Prometheus/Grafana monitoring.
