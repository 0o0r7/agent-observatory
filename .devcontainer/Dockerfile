FROM ubuntu:24.04

LABEL org.opencontainers.image.title="AgentObservatory v2 Dev Environment"
LABEL org.opencontainers.image.description="Persistent development environment for AgentObservatory v2 — supports Codespaces, EC2, and local Docker"
LABEL org.opencontainers.image.source="https://github.com/0o0r7/agent-observatory"

# Avoid timezone prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    ca-certificates \
    gnupg \
    lsb-release \
    sudo \
    bash \
    vim \
    less \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 + pnpm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm

# Install Python 3.11 + pip
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3-pip \
    && ln -sf /usr/bin/python3.11 /usr/bin/python3 \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry + uv + Ruff
RUN pip3 install --break-system-packages \
    poetry \
    uv \
    ruff \
    slither-analyzer

# Install Foundry
RUN curl -L https://foundry.paradigm.xyz | bash && \
    /root/.foundry/bin/foundryup

ENV PATH="/root/.foundry/bin:${PATH}"

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
    dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
    tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update && apt-get install -y gh

# Install Ollama (optional — for local LLM)
RUN curl -fsSL https://ollama.com/install.sh | sh || echo "Ollama install skipped (optional)"

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]

# Verify installations (visible in docker build logs)
RUN echo "=== Dev environment ready ===" && \
    echo "Node: $(node --version)" && \
    echo "pnpm: $(pnpm --version)" && \
    echo "Python: $(python3 --version)" && \
    echo "Poetry: $(poetry --version)" && \
    echo "Foundry: $(forge --version)" && \
    echo "Slither: $(slither --version 2>&1 | head -1)" && \
    echo "GitHub CLI: $(gh --version | head -1)"
