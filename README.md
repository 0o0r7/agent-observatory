# AgentObservatory v2

> **The other half of the Venn diagram.**
>
> Stock memes is one half (memetic creativity + stock pairs + products).
> AgentObservatory is the other half (autonomous research agents that surface the best stock-pair products).

A tokenized agent-observatory on [vibe/vibe](https://testnet.vibevibe.fun/) — a layer where AI agents discover, qualify, and surface the best stock-pair products launched on vibe/vibe. Each agent is launched as an ERC-20 token via vibe/vibe's V6 LaunchFactory `/create` flow. Holders submit their own verdicts via commit-reveal; reflections are distributed based on the HOLDER's OWN prediction accuracy (Numerai-pattern real-stakes — yield from research quality, NOT from tax redistribution by an operator).

[![Spec](https://img.shields.io/badge/spec-v2.0-blue)](docs/01-specification-v2.md)
[![License](https://img.shields.io/badge/license-AGPL%20%2B%20MIT-success)](LICENSE)
[![Status](https://img.shields.io/badge/status-MVP%20development-orange)](handoff/AGENT_INSTRUCTIONS.md)

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Repository Structure](#repository-structure)
3. [Architecture](#architecture)
4. [Quick Start](#quick-start)
5. [Documentation](#documentation)
6. [Handoff for Coder Agent](#handoff-for-coder-agent)
7. [Infrastructure](#infrastructure)
8. [License](#license)
9. [Contributing](#contributing)
10. [Security](#security)

---

## Project Overview

**AgentObservatory v2** is a tokenized agent-observatory on the vibe/vibe launchpad (deployed on Robinhood Chain Testnet, an Arbitrum Orbit L2 with chain ID 46630).

The product allows AI agents to discover, qualify, and surface the best stock-pair products launched on vibe/vibe. Each agent is launched as an ERC-20 token via vibe/vibe's V6 LaunchFactory `/create` flow. Holders submit their own verdicts via commit-reveal; reflections are distributed based on the HOLDER's OWN prediction accuracy (Numerai-pattern real-stakes).

### Why This Project

The founder of vibe/vibe (Levent Cem Aydan, @meta_alchemist) has articulated the following thesis (October 6, 2026):

> *"The thing we would most love is to see:*
> *- products (vibe coding)*
> *- stock pairs (tokenization)*
> *- memetic creativity (generative ai)*
> *merge together*
> *so that we can be home to a new breed of tokens at vibe/vibe"*

AgentObservatory v2 embodies this three-pillar merge:
- **Stock pair**: each agent token paired with NVDA / AAPL / SPCX / OPENAI / ANTHROPIC
- **Memetic creativity**: agents generate research reports, qualification verdicts, and curated digests that ARE memetic content
- **Vibe-coded product**: each agent itself is a vibe-coded product (Claude Code / Codex / Robinhood Agents)

### Founder's Intellectual Pattern Match

The founder's GitHub (`vibeforge1111`, 31K+ contributions/year, 56 public repos) demonstrates a consistent architectural taste:

- Multi-repo microservices with formal authority contracts (Governor + ledger + lifecycle + evolution)
- AGPL kernel + MIT adapters license split
- Provider-agnostic LLM routing (Claude / Codex / Z.AI / MiniMax / HuggingFace / Ollama)
- File-first inspectable state (`artifacts/`)
- Proposal-first self-edit with operator gates
- Fail-closed verification
- Evidence over prose

AgentObservatory v2 is designed to extend this pattern — specifically extending the founder's own `seedify-agents-dashboard` README: *"Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows"*.

---

## Repository Structure

This repository contains the complete specification, research dossier, and handoff documentation for the AgentObservatory v2 project. The actual product is split across 5 repositories (multi-repo structure matching the founder's Spark OS pattern).

### This Repository (Documentation + Specification + Research)

```
agent-observatory/
├── docs/                              # Core specification + research synthesis
│   ├── 00-executive-summary.md        # Project overview (1-page)
│   ├── 01-specification-v2.md         # COMPLETE SPECIFICATION (READ FIRST)
│   ├── 02-research-dossier.md         # Synthesis of all 10 research streams
│   ├── 03-judge-evaluations.md        # 5 judges' final verdicts
│   ├── 04-roadmap-21-day-mvp.md       # 21-day MVP plan
│   ├── 05-team-roles.md               # 10 specialized team roles
│   └── 06-acceptance-criteria.md      # Per-phase acceptance criteria
│
├── specs/                             # Detailed technical specifications
│   ├── autoloop-yml-schema.md          # autoloop.yml schema (verdict_loop, LLM providers, accuracy_metric)
│   ├── erc20-agent-token-spec.md      # ERC-20 agent token spec (V6 produces ERC-20, not ERC-721)
│   ├── v6-launchfactory-integration.md # V6 LaunchFactory selector recovery + integration
│   ├── mcp-bridge-spec.md             # Robinhood Trading MCP bridge spec
│   ├── provenance-oracle-spec.md      # Phase-2 Provenance Oracle (EIP-712)
│   ├── reflections-router-spec.md     # Phase-2 Slashable Reflections Router
│   ├── securities-law-posture.md      # §0.2 Securities-Law Compliance Posture
│   ├── robinhood-ecosystem-boundary.md # §0.1 Robinhood Ecosystem Boundary
│   └── bonding-curve-dual-support.md  # Legacy k=1.0344e6 + Current k=1.0344e9
│
├── handoff/                            # Handoff for GLM-5.3 coder agent
│   ├── AGENT_INSTRUCTIONS.md          # MAIN HANDOFF (read first)
│   ├── TEAM_COMPOSITION.md            # 10 specialized team roles
│   ├── PHASE_BREAKDOWN.md             # Parallel phase execution plan
│   ├── ACCEPTANCE_CRITERIA.md         # Per-phase acceptance criteria
│   └── COMMUNICATION_PROTOCOL.md      # Language policy + comms channels
│
├── infrastructure/                    # Infrastructure access packages
│   ├── GITHUB_EDUCATION.md            # GitHub Education benefits package
│   ├── NVIDIA_DEVELOPER.md            # NVIDIA Developer account
│   ├── AZURE.md                       # Azure for Builders
│   ├── AWS_BUILDER.md                 # AWS Builder ID
│   └── ACCESS_PROTOCOL.md             # How to request access
│
├── research/                          # Full research dossier (4000+ lines)
│   ├── WORKLOG.md                     # Complete 10-stream research worklog
│   ├── IDEAS_ROUND1.md                # 6 Round 1 ideas
│   ├── IDEAS_ROUND2.md                # 2 Round 2 candidates
│   ├── IDEAS_ROUND3_FINAL.md          # VibeForge Studio v2 (Round 3)
│   ├── IDEAS_GEM_PHASE.md             # 6 GEM-phase ideas
│   └── AGENT_OBSERVATORY_V1.md        # Original v1 spec (pre-judge-fixes)
│
└── reference/                         # Reference material
    ├── FOUNDER_RFPs.md                # Founder's verbatim RFPs (Oct 6, 2026)
    ├── DISCORD_FINDINGS.md            # Discord deep-dive (4,095 messages)
    ├── COMPETITIVE_ANALYSIS.md        # Pump.fun / Flap / Virtuals / Clanker
    └── REGULATORY_LANDSCAPE.md        # SEC, RH Jersey, MiCA, Howey
```

### The 5 Production Repositories (to be created by the coder agent)

| Repo | Language | License | Purpose |
|---|---|---|---|
| `agent-observatory-kernel` | Python | AGPL-3.0 | Verdict engine + autoloop runner |
| `agent-observatory-contracts` | Solidity | MIT | Phase-2 contracts (post-team-audit) |
| `agent-observatory-studio` | TypeScript / Next.js | MIT | Web UI + Privy wallet |
| `agent-observatory-mcp-bridge` | TypeScript | MIT | Robinhood Trading MCP bridge (optional, local) |
| `vibe-vibe-create-sdk` | TypeScript | MIT | SDK for vibe/vibe V6 LaunchFactory |

---

## Architecture

### Multi-Repo Structure (matches founder's Spark OS pattern)

```
┌────────────────────────────────────────────────────────────────────┐
│                    vibe/vibe V6 LaunchFactory                       │
│              (Robinhood Chain Testnet, chain ID 46630)              │
│              (ERC-20 agent-attested tokens launched here)          │
└──────────────────────────┬─────────────────────────────────────────┘
                           │
                           │ launchToken() + BuildLog event
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
        ▼                                     ▼
┌─────────────────────┐                ┌──────────────────────┐
│ agent-observatory-  │                │  vibe-vibe-create-   │
│ studio              │ ◄───────────── │  sdk                 │
│ (Next.js + Privy)   │                │  (15+ TS functions)  │
│ MIT License         │                │  MIT License         │
└─────────────────────┘                └──────────────────────┘
        │                                     │
        │ HTTP polling (5s)                    │ V6 selector recovery
        │ (NOT WebSocket — wss://             │ (24/86 decoded)
        │  rpc.testnet.chain.robinhood.com    │
        │  does NOT exist)                    │
        ▼                                     │
┌─────────────────────┐                     │
│ agent-observatory-  │                     │
│ kernel              │ ◄───────────────────┘
│ (Python, AGPL)      │
│                     │
│  • Subscribes to    │
│    V6 LaunchCreated │
│    events           │
│  • Calls LLM        │
│    (provider-       │
│    agnostic)        │
│  • Generates        │
│    verdicts         │
│  • Persists to      │
│    artifacts/       │
│    verdicts/        │
│    <launch>/        │
│    {input,          │
│     evidence,       │
│     verdict,        │
│     replay.html}    │
└─────────────────────┘
        │
        │ OPTIONAL (paper-trade by default)
        ▼
┌─────────────────────┐
│ agent-observatory-  │
│ mcp-bridge          │
│ (TypeScript, MIT)   │
│                     │
│  • LOCAL process    │
│    on operator's    │
│    machine          │
│  • Robinhood OAuth  │
│    (NOT EVM wallet) │
│  • EIP-712 typed-   │
│    data signing     │
│  • NEVER holds      │
│    operator         │
│    credentials      │
│  • Auto-rejects     │
│    anti-sniper      │
│    window buys      │
└─────────────────────┘
        │
        │ Robinhood Trading MCP
        │ (https://agent.robinhood.com/mcp/trading)
        │ (77 tools, 6 categories)
        ▼
┌─────────────────────────────────────────────┐
│ Robinhood Agentic Account                    │
│ (Robinhood Labs LLC as technology provider) │
│ • Trades settle HERE (not in ERC-6551)      │
│ • Holder's OWN account                       │
└─────────────────────────────────────────────┘
```

### Phase-2 Solidity Contracts (deferred to post-team-audit)

```
┌─────────────────────────────────────────────────────┐
│ agent-observatory-contracts (Solidity, MIT)       │
│                                                    │
│  Phase-2a: Provenance Oracle (~160 lines, EIP-712)│
│  Phase-2b: Per-Holder Commit-Reveal (~250 lines)  │
│  Phase-2c: Reflections Router (~150 lines)        │
│  Phase-2d: Slashable Stake (~80 lines)            │
│                                                    │
│  DEFERRED until V6 audit completes                │
│  (V6 NOT source-verified on Blockscout)          │
└─────────────────────────────────────────────────────┘
```

---

## Quick Start

### For the Coder Agent (GLM-5.3 or any senior coder)

1. **Read the handoff first**:
   ```bash
   cat handoff/AGENT_INSTRUCTIONS.md
   cat handoff/TEAM_COMPOSITION.md
   cat handoff/PHASE_BREAKDOWN.md
   ```

2. **Read the spec**:
   ```bash
   cat docs/01-specification-v2.md
   ```

3. **Read the research dossier** (for context):
   ```bash
   cat docs/02-research-dossier.md
   ```

4. **Set up the 5 production repositories** per `handoff/PHASE_BREAKDOWN.md` Phase 0.

5. **Start Phase 1** (vibe-vibe-create-sdk) per `handoff/PHASE_BREAKDOWN.md`.

### For Human Reviewers

1. **Read the executive summary** (`docs/00-executive-summary.md`)
2. **Read the spec** (`docs/01-specification-v2.md`) — especially §0 boundary statements
3. **Read the research dossier** (`docs/02-research-dossier.md`) for full context
4. **Read the judge evaluations** (`docs/03-judge-evaluations.md`) for the 5-judge panel's verdicts

---

## Documentation

### Core Documents

| Document | Purpose | Audience |
|---|---|---|
| `docs/00-executive-summary.md` | 1-page project overview | All stakeholders |
| `docs/01-specification-v2.md` | Complete specification | Coder agent + reviewers |
| `docs/02-research-dossier.md` | Synthesis of 10 research streams | Reviewers |
| `docs/03-judge-evaluations.md` | 5 judges' final verdicts | Reviewers |
| `docs/04-roadmap-21-day-mvp.md` | 21-day MVP plan | Coder agent |
| `docs/05-team-roles.md` | 10 specialized team roles | Coder agent |
| `docs/06-acceptance-criteria.md` | Per-phase acceptance criteria | Coder agent + QA |

### Handoff Documents (for coder agent)

| Document | Purpose |
|---|---|
| `handoff/AGENT_INSTRUCTIONS.md` | MAIN HANDOFF (read first) |
| `handoff/TEAM_COMPOSITION.md` | 10 specialized roles + solo-founder alternative |
| `handoff/PHASE_BREAKDOWN.md` | Parallel phase execution plan (Phase 0-8) |
| `handoff/ACCEPTANCE_CRITERIA.md` | Per-phase acceptance criteria (detailed) |
| `handoff/COMMUNICATION_PROTOCOL.md` | Language policy + comms channels |

### Infrastructure Documents

| Document | Purpose |
|---|---|
| `infrastructure/ACCESS_PROTOCOL.md` | How to request access |
| `infrastructure/GITHUB_EDUCATION.md` | GitHub Education benefits package |
| `infrastructure/NVIDIA_DEVELOPER.md` | NVIDIA Developer account |
| `infrastructure/AZURE.md` | Azure for Builders |
| `infrastructure/AWS_BUILDER.md` | AWS Builder ID |

### Research Documents (full primary-source dossier)

| Document | Lines | Content |
|---|---|---|
| `research/WORKLOG.md` | 4000+ | Complete 10-stream research worklog |
| `research/IDEAS_ROUND1.md` | ~700 | 6 Round 1 ideas (post-research) |
| `research/IDEAS_ROUND2.md` | ~400 | 2 Round 2 Golden Goal candidates |
| `research/IDEAS_ROUND3_FINAL.md` | ~400 | VibeForge Studio v2 (Round 3 synthesis) |
| `research/IDEAS_GEM_PHASE.md` | ~600 | 6 GEM-phase ideas (post-primary-source) |
| `research/AGENT_OBSERVATORY_V1.md` | ~280 | Original v1 spec (pre-judge-fixes) |

---

## Handoff for Coder Agent

The complete handoff for the GLM-5.3 coder agent (or any senior coder agent) is in `handoff/AGENT_INSTRUCTIONS.md`.

**Key constraints (non-negotiable)**:
1. Multi-repo structure (AGPL kernel + MIT adapters) — DO NOT use a monolith
2. Provider-agnostic LLM routing (6 providers with role separation)
3. File-first inspectable state (`artifacts/verdicts/<launch_address>/`)
4. Operator-in-control / fail-closed verification (NEVER hold operator credentials)
5. Per-holder commit-reveal (Howey fix)
6. Slash for inaccuracy (Numerai-pattern real-stakes)
7. ERC-20 agent token (V6 produces ERC-20, NOT ERC-721)
8. NO "agent token" / "bond" / "insurance" terminology
9. HTTP polling (NOT WebSocket — wss://rpc.testnet.chain.robinhood.com does NOT exist)
10. EIP-712 typed-data (modern standard, replaces EIP-191)

See `handoff/AGENT_INSTRUCTIONS.md` §2 for the complete list of 25 critical constraints.

---

## Infrastructure

The user has verified access to these infrastructure packages:

- **GitHub Education benefits package** — verified and accessible
- **NVIDIA Developer account** — verified and accessible
- **Azure for Builders** — verified and accessible
- **AWS Builder ID** — verified and accessible

See `infrastructure/ACCESS_PROTOCOL.md` for how to request access.

---

## License

This repository (documentation + specification + research) is licensed under **Creative Commons Attribution 4.0 International (CC-BY-4.0)**.

The 5 production repositories use the following licenses:
- `agent-observatory-kernel` (Python): **AGPL-3.0-only**
- `agent-observatory-contracts` (Solidity): **MIT**
- `agent-observatory-studio` (TypeScript/Next.js): **MIT**
- `agent-observatory-mcp-bridge` (TypeScript): **MIT**
- `vibe-vibe-create-sdk` (TypeScript): **MIT**

The AGPL/MIT license split matches the founder's Spark OS pattern (AGPL kernel + MIT adapters).

---

## Contributing

See `CONTRIBUTING.md` for contribution guidelines.

All contributions must be in **English** (Persian is OK in chat with the user, but must NOT leak into code or documentation).

---

## Security

See `SECURITY.md` for security policy.

**Critical security notes**:
1. NEVER commit secrets (GitHub PAT, Discord token, LLM API keys) to git
2. NEVER hold operator credentials in the MCP bridge (DPRK-PTSD-driven per §2.1 of AGENT_INSTRUCTIONS.md)
3. Rotate secrets quarterly
4. Use EU data residency for Reg S compliance (see `infrastructure/ACCESS_PROTOCOL.md` §5.2)
5. All Phase-2 Solidity contracts must pass Slither + Mythril before deployment

