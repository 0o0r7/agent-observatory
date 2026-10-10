# Development Environment Configuration — GitHub Codespaces Only

This directory contains configuration for running AgentObservatory v2 in **GitHub Codespaces** — the sole cloud development environment for this project. Codespaces centralizes everything in GitHub (repo, dev environment, CI/CD, packages, deploys) leveraging GitHub Education benefits and simplifying access management.

## Why GitHub Codespaces (Sole Choice)

**Centralization benefits**:
- Everything in GitHub (repo, dev environment, CI/CD, packages, deploys) — single account, single sign-on, single management surface
- Free 180 hours/month of Codespaces compute with GitHub Education benefits (user has verified access)
- Pre-configured via `.devcontainer/devcontainer.json` — auto-installs Node 20, Python 3.11, Foundry, Slither, Mythril, GitHub CLI, Ollama
- All builds run in cloud (high-speed GitHub internet) — user's bad internet only affects the SSH tunnel for VS Code Remote (very low bandwidth, just text editing)
- If internet drops temporarily, the codespace continues running; user can reconnect when internet returns
- GitHub Actions CI/CD (free with Education) runs on GitHub infra — completely independent of user's internet
- GitHub Packages (free 500 MB with Education) for npm/PyPI publication
- GitHub Copilot (free with Education) for in-editor code assistance

## Codespaces Free Hours Budget (21-Day MVP)

- **Free with GitHub Education**: 180 hours/month of Codespaces compute
- **21-day MVP needs**: ~504 hours total (21 days × 24 hours) — **DOES NOT FIT** in 180 free hours
- **Strategy**: Use Codespaces ONLY for active development (assume 8-10 hours/day active work = ~200 hours for 21-day MVP)
- Codespaces auto-suspends after 30 min inactivity (configurable) — this CONSERVES free hours
- If approaching 180-hour limit, open a GitHub Issue with label `codespaces-budget-warning` — user will decide whether to (a) upgrade to paid Codespaces, (b) extend timeline, (c) reduce scope

## Quick Start (Codespaces Setup)

### Option A: Web Browser (Easiest)

1. Navigate to https://github.com/0o0r7/agent-observatory
2. Click the green "Code" button → "Codespaces" tab → "Create codespace on main"
3. Wait 5-10 minutes for provisioning (first time; subsequent creations are faster)
4. VS Code opens in your browser with all dependencies pre-installed
5. Run `bash .devcontainer/setup.sh` if any tool is missing

### Option B: VS Code (Recommended for Daily Use)

1. Install VS Code locally: https://code.visualstudio.com/
2. Install the "Codespaces" extension in VS Code (search for "Codespaces" in Extensions)
3. `Cmd/Ctrl+Shift+P` → "Codespaces: Create New Codespace"
4. Select repository: `0o0r7/agent-observatory`
5. Select branch: `main`
6. Select machine type: `4-core` (recommended for Foundry + npm builds)
7. Wait 5-10 minutes for provisioning
8. VS Code connects to the Codespace; all files are accessible
9. Run `bash .devcontainer/setup.sh` if any tool is missing

### Option C: GitHub CLI (Automated)

```bash
# Install GitHub CLI: https://cli.github.com/
gh auth login
gh codespace create --repo 0o0r7/agent-observatory --branch main --machine basicLinux32gb
gh codespace code  # Opens VS Code connected to the Codespace
```

## What's Pre-Installed by `.devcontainer/devcontainer.json`

The Codespace auto-installs on creation:

### Languages & Runtimes
- Node.js 20 + pnpm (for TypeScript repos)
- Python 3.11 + pip + Poetry + uv + Ruff (for Python kernel)

### Solidity Toolchain
- Foundry (`forge`, `cast`, `anvil`) — for Solidity development
- Slither — Solidity static analyzer
- Mythril — Solidity symbolic execution

### GitHub Integration
- GitHub CLI (`gh`) — for authentication and repo management
- GitLens VS Code extension — for git history visualization

### Optional LLM Fallback
- Ollama — local LLM via NVIDIA GPU (provider-agnostic fallback per `autoloop.yml` schema)

### VS Code Extensions
- ESLint + Prettier — TypeScript linting/formatting
- Python + Ruff — Python linting/formatting
- Solidity (Nomic Foundation Hardhat) — Solidity support
- Docker — for container management
- GitHub Pull Requests — for PR review
- GitHub Copilot — AI code assistance (free with GitHub Education)
- GitLens — git history visualization

## Codespace Lifecycle Management

### Auto-Suspend (Conserve Free Hours)
- Default: Auto-suspends after 30 min inactivity
- Configurable: GitHub Settings → Codespaces → "Auto-suspend after"
- Recommendation: Keep default 30 min to conserve free hours

### Manual Suspend (When Not Working)
- VS Code: `Cmd/Ctrl+Shift+P` → "Codespaces: Suspend"
- Web: Codespaces page → "Suspend" button
- Recommendation: Manually suspend when not actively working (e.g., overnight)

### Rebuild (After .devcontainer.json Changes)
- VS Code: `Cmd/Ctrl+Shift+P` → "Codespaces: Rebuild Container"
- Re-runs `.devcontainer/setup.sh` to install any new tools

### Delete (Free Storage)
- GitHub Settings → Codespaces → "Delete"
- Cannot be undone — frees storage but loses all unsaved work
- Recommendation: Always commit and push before deleting

## Codespace Setup Verification

After creating the Codespace, verify all tools are installed by running:

```bash
# Verify all required tools are installed
node --version      # Expected: v20+
pnpm --version      # Expected: 9+
python3 --version   # Expected: 3.11+
poetry --version    # Expected: 1.8+
uv --version        # Expected: 0.5+
forge --version     # Expected: 1.0+
slither --version   # Expected: 0.10+
myth --version      # Expected: 0.24+ (or similar)
gh --version        # Expected: 2.40+
ollama --version    # Optional — for local LLM fallback
```

If any tool is missing (the `.devcontainer/setup.sh` should have installed them, but if it failed), run:

```bash
bash .devcontainer/setup.sh
```

## Codespaces Workflow for the Agent

| Task | Where It Runs | Why |
|---|---|---|
| Editing files | Codespaces | Low bandwidth SSH tunnel — works even with bad internet |
| Heavy builds (npm install, forge install) | Codespaces | Cloud high-speed GitHub internet |
| Run tests | Codespaces locally + GitHub Actions CI on push | GitHub Actions runs on GitHub infra — independent of user's internet |
| Deploy studio (Phase 3) | Vercel auto-deploy on push | Runs on Vercel's infra (free for personal projects) |
| Deploy kernel (Phase 2) | Railway or Fly.io auto-deploy on push | Free tier |
| LLM calls | NVIDIA GPU + Ollama (local) OR via Codespaces | Free, no internet needed (local) or cloud (Codespaces) |
| Git operations (commit, push) | Codespaces → GitHub | Cloud-to-cloud, fast — bypasses user's local internet entirely |

## Forbidden Local Operations

The following operations MUST NOT run on the user's local machine (they will fail or take excessively long due to bad internet):

1. ❌ `npm install` (large download — will fail or timeout)
2. ❌ `pip install` (large download — will fail or timeout)
3. ❌ `forge install` (Foundry deps — will fail or timeout)
4. ❌ `git clone` of large repos (will fail or timeout)
5. ❌ `docker pull` of large images (will fail or timeout)
6. ❌ Heavy LLM API calls (will fail or timeout)
7. ❌ `git push` from local (slow, will fail or timeout) — push from Codespaces instead

**All of these MUST happen in Codespaces.** The local machine is ONLY for:
- VS Code editing (via Codespaces extension — SSH tunnel)
- SSH connection to Codespace
- Light git operations (status, diff, log) — but commits and pushes should happen from Codespaces

## Files in This Directory

| File | Purpose |
|---|---|
| `devcontainer.json` | Codespaces configuration — features to install, VS Code extensions, postCreateCommand |
| `setup.sh` | Post-creation script that installs all dependencies (Foundry, Slither, Mythril, etc.) |
| `Dockerfile` | Optional — for advanced users who want a portable Docker image (not required for Codespaces) |
| `docker-compose.yml` | Optional — for advanced users who want local Docker deployment (not required for Codespaces) |
| `README.md` | This file |

## Troubleshooting

### Codespace Won't Start
1. Check GitHub Status: https://www.githubstatus.com/
2. Try a different machine type (e.g., 2-core instead of 4-core)
3. Delete and recreate the Codespace
4. Open a GitHub Issue with label `codespaces-issue`

### Tools Not Installed After Creation
1. Run: `bash .devcontainer/setup.sh` manually
2. If still failing, check the script output for errors
3. Open a GitHub Issue with label `devcontainer-issue`

### Free Hours Exhausted
1. Open a GitHub Issue with label `codespaces-budget-warning`
2. Specify: hours used, hours remaining, blockers causing over-consumption
3. User will decide: (a) upgrade to paid Codespaces, (b) extend timeline, (c) reduce scope

### Internet Drops While Working
- The Codespace continues running in the cloud
- VS Code will show "Disconnected" — wait for reconnection
- All work is preserved in the Codespace
- If VS Code won't reconnect, refresh the page or restart VS Code
