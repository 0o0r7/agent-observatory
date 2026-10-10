# Development Environment Configuration

This directory contains configuration for running AgentObservatory v2 in a cloud-based or local Docker development environment, which is essential for users with limited or unreliable local internet connectivity.

## Option 1: GitHub Codespaces (Recommended for Quick Setup)

GitHub Codespaces provides a cloud-hosted development environment that is free for 180 hours per month with GitHub Education benefits.

### Quick Start

1. Navigate to https://github.com/0o0r7/agent-observatory
2. Click the green "Code" button → "Codespaces" tab → "Create codespace on main"
3. Wait for the codespace to provision (5-10 minutes on first creation; subsequent creations are faster)
4. VS Code will open in your browser with all dependencies pre-installed
5. Alternatively, open locally with VS Code: install the "Codespaces" extension, then `Cmd/Ctrl+Shift+P` → "Codespaces: Connect to Codespace"

### What's Pre-Installed

The `devcontainer.json` automatically installs:
- Node.js 20 + pnpm (for TypeScript repos)
- Python 3.11 + Poetry + uv + Ruff (for Python kernel)
- Foundry (forge, cast, anvil — for Solidity contracts)
- Slither + Mythril (Solidity security analysis)
- GitHub CLI (for authentication and repo management)
- Ollama (optional — for local LLM fallback)
- VS Code extensions: ESLint, Prettier, Python, Ruff, Solidity, Docker, GitHub PR, Copilot, GitLens

### Why This Solves the Bad Internet Problem

When you use Codespaces:
- All `npm install`, `pip install`, `forge install` commands run in the cloud (high-speed GitHub internet)
- Git pushes go from Codespaces to GitHub (cloud-to-cloud, fast)
- Your local internet only carries the SSH tunnel for VS Code Remote (very low bandwidth — just text editing)
- If your internet drops temporarily, the codespace continues running; you can reconnect when internet returns

## Option 2: AWS EC2 (Recommended for Persistent Always-On)

For persistent always-on development (no auto-suspend after 30 minutes of inactivity like Codespaces), use AWS EC2.

### Recommended Instance

- **Instance type**: `t3.small` (2 vCPU, 2 GB RAM) — sufficient for Foundry + npm + Python
- **AMI**: Ubuntu 24.04 LTS
- **Storage**: 30 GB EBS gp3
- **Cost**: ~$15/month (or free tier with `t2.micro` — but 1 GB RAM may be tight)

### Quick Start

```bash
# Launch EC2 instance (via AWS Console or CLI)
aws ec2 run-instances \
  --image-id ami-0c7216cd879bb9f4a \
  --count 1 \
  --instance-type t3.small \
  --key-name your-key-pair \
  --block-device-mappings DeviceName=/dev/sda1,Ebs={VolumeSize=30,VolumeType=gp3} \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=agent-observatory-dev}]'

# SSH into the instance
ssh -i your-key-pair.pem ubuntu@<EC2_PUBLIC_IP>

# Inside EC2 — clone the repo
git clone https://github.com/0o0r7/agent-observatory.git
cd agent-observatory

# Build the dev container
cd .devcontainer
docker build -t agent-observatory-dev .

# Run the dev container (persistent)
docker run -d \
  --name agent-observatory-dev \
  -v $(dirname $(pwd)):/workspace \
  -p 3000:3000 -p 5173:5173 -p 8545:8545 \
  --restart unless-stopped \
  agent-observatory-dev

# Enter the running container
docker exec -it agent-observatory-dev /bin/bash
```

### Connect VS Code to EC2

1. Install the "Remote - SSH" extension in VS Code
2. `Cmd/Ctrl+Shift+P` → "Remote-SSH: Connect to Host" → select your EC2 instance
3. VS Code will connect to EC2; open `/home/ubuntu/agent-observatory`
4. All builds run on EC2 (high-speed AWS internet); your local internet only carries the SSH tunnel

### Why EC2 is Better Than Codespaces for This Project

| Criterion | Codespaces | AWS EC2 |
|---|---|---|
| Free hours/month | 180 (with Education) | 750 (with free tier t2.micro) |
| Auto-suspend after inactivity | Yes (30 min default) | No (always-on) |
| Persistent storage | Ephemeral (lost on delete) | Persistent (survives reboots) |
| RAM (free tier) | 8 GB (4-core) | 1 GB (t2.micro) — tight |
| RAM (paid) | N/A | 2 GB (t3.small, ~$15/mo) |
| Setup complexity | Easy (one-click) | Medium (manual EC2 + Docker) |
| Auto-configures dev tools | Yes (via devcontainer.json) | Yes (via Dockerfile in this dir) |

## Option 3: Hybrid (Best of Both Worlds)

Use Codespaces for ephemeral work + GitHub Actions for CI/CD:

1. **Editing**: Codespaces (low-bandwidth SSH tunnel)
2. **Heavy builds**: Codespaces (cloud high-speed internet)
3. **Tests**: GitHub Actions CI (runs on GitHub infra — completely independent of your internet)
4. **Studio deploy**: Vercel (auto-deploy on push — runs on Vercel's infra)
5. **Kernel deploy**: Railway or Fly.io (auto-deploy on push)
6. **LLM fallback**: NVIDIA GPU + Ollama (local, free, no internet)

This way, your bad internet only affects the SSH tunnel to Codespaces.

## Verifying the Environment

After Codespaces or EC2 is running, verify:

```bash
node --version      # v20+
pnpm --version      # 9+
python3 --version   # 3.11+
poetry --version    # 1.8+
uv --version        # 0.5+
forge --version     # 1.0+
slither --version   # 0.10+
gh --version        # 2.40+
```

If any are missing, run `bash .devcontainer/setup.sh` to install.
