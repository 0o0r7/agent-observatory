# Contributing to AgentObservatory v2

Thank you for your interest in contributing! This document outlines the process for contributing to the AgentObservatory v2 project.

---

## §1. Language Policy

**All code, documentation, commit messages, PR titles, PR descriptions, issue titles, issue descriptions, code comments, variable names, file names = English ONLY.**

Persian is acceptable in chat with the project owner (for clearer execution-flow understanding), but Persian must NOT leak into any file in any of the 5 production repositories.

### Enforcement
- Tech Lead reviews every PR for English-only compliance
- QA adds a CI check: `grep -rP '[\x{0600}-\x{06FF}]' src/ docs/` should return zero hits
- PRs with Persian in code/docs will be rejected

---

## §2. Repository Structure

This is a **multi-repo** project. Contributions go to the appropriate repository:

| Repo | Language | License | Purpose |
|---|---|---|---|
| `agent-observatory-kernel` | Python | AGPL-3.0 | Verdict engine + autoloop runner |
| `agent-observatory-contracts` | Solidity | MIT | Phase-2 contracts (post-team-audit) |
| `agent-observatory-studio` | TypeScript / Next.js | MIT | Web UI + Privy wallet |
| `agent-observatory-mcp-bridge` | TypeScript | MIT | Robinhood Trading MCP bridge |
| `vibe-vibe-create-sdk` | TypeScript | MIT | SDK for vibe/vibe V6 LaunchFactory |

**This documentation repository** (the one you're reading) is for specification, research, and handoff only. Code contributions do not go here.

---

## §3. Development Setup

### Prerequisites
- Node.js 20+ (for TypeScript repos)
- Python 3.11+ (for kernel)
- Foundry (for Solidity contracts)
- pnpm (for TypeScript package management)
- Poetry or uv (for Python dependency management)

### Setup Steps

1. **Fork the relevant repo** on GitHub
2. **Clone locally**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
   cd REPO_NAME
   ```
3. **Install dependencies**:
   - TypeScript repos: `pnpm install`
   - Python repo: `poetry install` or `uv sync`
   - Solidity repo: `forge install`
4. **Copy `.env.example` to `.env`** and fill in your secrets
5. **Run tests**:
   - TypeScript repos: `pnpm test`
   - Python repo: `pytest`
   - Solidity repo: `forge test`

---

## §4. Contribution Workflow

### §4.1 Open an Issue First
Before starting work, open a GitHub Issue describing:
- What you want to add/fix
- Why it's needed
- Proposed approach

Wait for maintainer feedback before starting work (unless it's a trivial fix).

### §4.2 Create a Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### §4.3 Write Code + Tests
- Follow the existing code style (enforced by Ruff for Python, ESLint + Prettier for TypeScript, Forge fmt for Solidity)
- Write unit tests for all new functionality (Vitest, pytest, or Forge test)
- Aim for >80% test coverage on new code

### §4.4 Run Tests Locally
```bash
# TypeScript repos
pnpm test
pnpm lint
pnpm build

# Python repo
pytest
ruff check .
ruff format .

# Solidity repo
forge test
forge fmt
slither .
```

### §4.5 Commit Your Changes
Use conventional commits format:
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `build`, `perf`

Example:
```
feat(sdk): add commitVerdict() function for per-holder commit-reveal

Implements the commit phase of the Numerai-pattern commit-reveal mechanism
per §4.1 of the specification. Holders submit a hash of their verdict
plus stake amount; stake is locked for 30 days and slashable if 30-day
accuracy < 0.40 (Brier score).

Closes #42
```

### §4.6 Push + Open PR
```bash
git push origin feature/your-feature-name
```

Open a Pull Request with:
- Summary of changes
- Phase + role tags (e.g., `phase:1`, `role:3`)
- Acceptance criteria link
- Test coverage report
- For Solidity PRs: Slither + Mythril reports
- For PRs touching tokenomics: Legal/Compliance review

---

## §5. Code Review Criteria

PRs are reviewed against these criteria:

### §5.1 Architectural Constraints (non-negotiable)
- Multi-repo structure maintained (no monolith)
- AGPL kernel + MIT adapters license split
- Provider-agnostic LLM routing (no Claude lock-in)
- File-first inspectable state (`artifacts/verdicts/<launch_address>/`)
- Operator-in-control / fail-closed verification
- Evidence over prose (verdict outputs include `evidence_citations`, `commit_hash`, `replay.html`)
- Autoloop, not one-shot (per `autoloop.yml` schema)

### §5.2 Legal/Regulatory Constraints (non-negotiable)
- NO "agent token" terminology (use "agent-attested token")
- Per-holder commit-reveal (Holders submit their OWN verdicts)
- Slash for inaccuracy (NOT just sybil)
- Reg S transfer-restriction stack
- US-exclusion stack
- NO "bond" / "insurance" terminology
- Snapshot-based distribution (NOT maintained ledger)
- Multi-sig scope limitation

### §5.3 On-chain Constraints (non-negotiable)
- V6 LaunchFactory produces ERC-20 (NOT ERC-721)
- V6 LaunchFactory is NOT source-verified (use `vibe-vibe-create-abi`)
- WebSocket does NOT exist on Robinhood Chain Testnet (use HTTP polling)
- Bonding curve dual-support (legacy + current k values)
- Anti-sniper window auto-reject (MCP bridge)

### §5.4 Ecosystem Constraints (non-negotiable)
- AgentObservatory agents are NOT Robinhood Agents
- MCP bridge runs as LOCAL process
- Content generation at LLM layer (NOT via MCP tools)
- Position as extension of `seedify-agents-dashboard` (NOT pivot)

### §5.5 Quality Criteria
- Test coverage >80% on new code
- No linting errors (Ruff / ESLint / Forge fmt)
- No Slither/Mythril critical/high/medium findings (for Solidity)
- Comprehensive documentation (README + API reference)
- English only (no Persian in code/docs)

---

## §6. Infrastructure Access

If your contribution requires infrastructure access (GitHub Education, NVIDIA, Azure, AWS Builder), see `infrastructure/ACCESS_PROTOCOL.md`.

---

## §7. Communication

- **GitHub Issues**: technical issues, bug reports, feature requests
- **GitHub PRs**: code review
- **Discord** (`discord.gg/vibevibebuilders`): community engagement (English only in public channels)
- **Internal Discord** (private): team coordination (Persian OK)

---

## §8. License

By contributing, you agree that your contributions will be licensed under:
- AGPL-3.0-only for `agent-observatory-kernel`
- MIT for `agent-observatory-contracts`, `agent-observatory-studio`, `agent-observatory-mcp-bridge`, `vibe-vibe-create-sdk`

---

## §9. Security

If you discover a security vulnerability, please DO NOT open a public issue. Instead, email the maintainers directly (see `SECURITY.md`).

---

## §10. Code of Conduct

Be respectful. Be professional. We follow the [Contributor Covenant 2.1](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).

