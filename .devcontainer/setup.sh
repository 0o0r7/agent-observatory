#!/usr/bin/env bash
set -euo pipefail

echo "=== AgentObservatory v2 Dev Container Setup ==="

# Update system packages
echo ">>> Updating system packages..."
sudo apt-get update -qq
sudo apt-get install -y -qq curl git build-essential pkg-config libssl-dev

# Install Foundry (Solidity development toolkit)
echo ">>> Installing Foundry..."
if ! command -v forge &> /dev/null; then
  curl -L https://foundry.paradigm.xyz | bash
  export PATH="$HOME/.foundry/bin:$PATH"
  foundryup
  echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> ~/.bashrc
fi

# Install Slither (Solidity static analyzer)
echo ">>> Installing Slither..."
pip install slither-analyzer

# Install Mythril (Solidity symbolic execution)
echo ">>> Installing Mythril..."
pip install mythril

# Install uv (fast Python package manager — alternative to Poetry)
echo ">>> Installing uv..."
if ! command -v uv &> /dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
fi

# Install Ollama (local LLM — for provider-agnostic fallback)
echo ">>> Installing Ollama (optional — for local LLM fallback)..."
if ! command -v ollama &> /dev/null; then
  curl -fsSL https://ollama.com/install.sh | sh
fi

# Verify installations
echo ""
echo "=== Verification ==="
echo "Node: $(node --version 2>/dev/null || echo 'not installed')"
echo "pnpm: $(pnpm --version 2>/dev/null || echo 'not installed')"
echo "Python: $(python3 --version 2>/dev/null || echo 'not installed')"
echo "Poetry: $(poetry --version 2>/dev/null || echo 'not installed')"
echo "uv: $(uv --version 2>/dev/null || echo 'not installed')"
echo "Foundry forge: $(forge --version 2>/dev/null || echo 'not installed')"
echo "Slither: $(slither --version 2>/dev/null || echo 'not installed')"
echo "Mythril: $(myth --version 2>/dev/null || echo 'not installed')"
echo "Ollama: $(ollama --version 2>/dev/null || echo 'not installed (optional)')"
echo "GitHub CLI: $(gh --version 2>/dev/null | head -1 || echo 'not installed')"
echo ""
echo "=== Setup complete! ==="
echo ""
echo "Next steps:"
echo "1. Authenticate with GitHub: gh auth login"
echo "2. Clone production repos (Phase 0 will create these)"
echo "3. Set up environment variables (copy .env.example to .env)"
echo ""
