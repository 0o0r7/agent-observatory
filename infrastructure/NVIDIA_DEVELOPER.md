# NVIDIA Developer Account

**Status**: Verified and accessible by the user.

## What's Included

- NVIDIA NGC catalog access (pre-trained models, containers)
- NVIDIA GPU Cloud (NGC) registry
- NVIDIA Deep Learning SDK (TensorRT, cuDNN, CUDA toolkit)
- NVIDIA Nsight Systems/Compute (profiling tools)
- Free credits for NVIDIA GPU compute (varies; check NVIDIA Developer portal)

## Documentation

- https://developer.nvidia.com

## Use Cases for AgentObservatory v2

- Local LLM via Ollama (provider-agnostic LLM router per `../specs/autoloop-yml-schema.md`)
- Self-hosted LLM inference (Llama 3.1 70B, Mistral, etc.) for fallback chain
- Profiling `agent-observatory-kernel` Python service performance
- GPU-accelerated evidence synthesis (if needed for large-context verdicts)

## Provider-Agnostic LLM Router (per spec §3)

The `autoloop.yml` schema specifies 6 LLM providers with role separation:
- Primary: Claude 3.5 Sonnet (paid API)
- Fallback 1: Codex GPT-5.6 (paid API)
- Fallback 2: Z.AI GLM-4.5 (paid API)
- Fallback 3: MiniMax Text-01 (paid API)
- Fallback 4: HuggingFace router (paid API)
- Fallback 5: Ollama Llama 3.1 70B (self-hosted on NVIDIA GPU — FREE)

The NVIDIA GPU enables the FREE Ollama fallback, reducing ongoing LLM API costs to $0/month if used as primary.

## How to Request Access

See `ACCESS_PROTOCOL.md` for the access request protocol.
