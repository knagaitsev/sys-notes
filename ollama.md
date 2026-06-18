# Ollama Notes

Start the server like so:

```bash
OLLAMA_HOST=127.0.0.1:11435 OLLAMA_CONTEXT_LENGTH=16384 ollama serve

# Chat with specific model
OLLAMA_HOST=127.0.0.1:11435 ollama run gemma4:26b
OLLAMA_HOST=127.0.0.1:11435 ollama run gemma4:31b
```

List models:

```bash
OLLAMA_HOST=127.0.0.1:11435 ollama list
```

## Open Code

Add this provider to `~/.config/opencode/opencode.json`:

```json
"ollama-kir": {
  "models": {
    "gemma4:31b": {
      "_launch": true,
      "name": "gemma4:31b"
    }
  },
  "name": "Ollama-kir",
  "npm": "@ai-sdk/openai-compatible",
  "options": {
    "baseURL": "http://127.0.0.1:11435/v1"
  }
}
```
