# TEAM COMPOSITION — Specialized Roles for Parallel Execution

**Document purpose**: Define the specialized team roles that the GLM-5.3 coder agent should form to advance project phases in parallel.

**Project**: AgentObservatory v2
**Total roles**: 10 (full team) or 5 (solo founder with Claude Code)
**Coordination model**: Parallel execution with phase dependencies

---

## ROLE 1: TECH LEAD / ARCHITECT

**Reports to**: Project owner (user)
**Owns**: Overall architecture, code reviews, multi-repo coordination

### Responsibilities
- Owns the multi-repo structure (5 repos per §5.1 of spec)
- Coordinates dependencies between repos (e.g., `vibe-vibe-create-sdk` is consumed by `agent-observatory-studio`)
- Code reviews for all PRs across all repos
- Maintains the architecture decision records (ADRs) in `docs/decisions/`
- Ensures the 25 critical constraints (§2 of `AGENT_INSTRUCTIONS.md`) are respected

### Required skills
- Senior TypeScript + Python + Solidity
- Multi-repo monorepo management (Turborepo, Nx, or Git submodules)
- Architecture decision documentation
- Code review rigor (enforcing the AGPL/MIT license split)

### Tools
- GitHub Projects (project tracking)
- Linear (or Jira) for issue tracking
- Mermaid (architecture diagrams)
- Notion or Obsidian (decision records)

### Estimated allocation
- 100% in Phase 0 (Day 1)
- 30% in Phases 1-7 (review + coordination)
- 50% in Phase 8 (post-MVP contracts architecture)

---

## ROLE 2: SOLIDITY ENGINEER

**Reports to**: Tech Lead
**Owns**: V6 LaunchFactory integration, Phase-2 contracts (post-team-audit)

### Responsibilities
- Integrates `vibe-vibe-create-sdk` with V6 LaunchFactory (`0xe794217880011f9cA6961340eD5c16EC9559Fea0`)
- Verifies V6 selector fingerprint (24/86 decoded selectors per worklog §6b-onchain-fast)
- Implements Phase-2 Provenance Oracle (~160 lines, EIP-712 per §7.1 of spec)
- Implements Phase-2 Per-Holder Commit-Reveal Contract (~250 lines per §4 of spec)
- Implements Phase-2 Reflections Router (~150 lines per §7.2)
- Implements Phase-2 Slashable Stake (~80 lines)
- Runs Slither + Mythril security analysis
- Coordinates with Legal/Compliance Reviewer (Role 9) for securities-law posture

### Required skills
- Solidity 0.8.24 (matches V6 compiler per bytecode metadata `solc-0.8.18-18`)
- Uniswap V4 hooks (V6 uses V4 per decoded `poolManager()` + `hook()` selectors)
- ERC-20 + EIP-712 typed-data (modern standard, replaces EIP-191)
- Slither + Mythril security analysis
- Permit2 (V6 uses Uniswap Permit2 per decoded `permit2()` selector)

### Tools
- Foundry (`forge`, `cast`, `anvil`) for local dev
- Slither (`pip install slither-analyzer`)
- Mythril (`pip install mythril`)
- Blockscout API for V6 contract queries
- 4byte.directory for selector decoding

### Estimated allocation
- 50% in Phase 0 (V6 selector recovery)
- 30% in Phases 1-7 (sdk Solidity bindings)
- 100% in Phase 8 (post-MVP contracts)

### CRITICAL: Phase-2 contracts are DEFERRED to post-team-audit. V6 itself is NOT source-verified on Blockscout. DO NOT deploy custom Solidity until V6 audit completes.

---

## ROLE 3: TYPESCRIPT/NEXT.JS ENGINEER

**Reports to**: Tech Lead
**Owns**: `vibe-vibe-create-sdk`, `agent-observatory-studio`, `agent-observatory-mcp-bridge`

### Responsibilities
- Builds `vibe-vibe-create-sdk` (15+ TypeScript functions per §5.1 of spec)
- Builds `vibe-vibe-create-abi` selector recovery package (24/86 decoded selectors as TypeScript discriminated unions)
- Builds `agent-observatory-studio` (Next.js 16 + viem + Tailwind + shadcn/ui + Privy wallet)
- Builds `agent-observatory-mcp-bridge` (TypeScript MCP server, local process on operator's machine)
- Integrates Privy wallet for non-crypto-native users (per founder's ask #3)
- Implements `BuildLog` event indexer (per J4 Round-2 strengthening suggestion)
- Implements MCP bridge auto-reject for anti-sniper window (`antiSniperWindowActive` revert)

### Required skills
- TypeScript 5+ with strict mode
- Next.js 16 (App Router)
- viem (preferred over ethers v6 for V4 hook integration)
- Tailwind CSS 4 + shadcn/ui
- Privy wallet integration
- MCP (Model Context Protocol) — see `https://modelcontextprotocol.io`
- EIP-712 typed-data signing

### Tools
- pnpm (preferred package manager)
- Turborepo (for multi-repo builds)
- Vitest (unit tests)
- Playwright (E2E tests)
- Vercel (deployment for `agent-observatory-studio`)

### Estimated allocation
- 100% in Phases 1, 3, 4 (sdk, studio, mcp-bridge)
- 30% in Phase 6 (demo agent integration)
- 50% in Phase 8 (post-MVP contract bindings)

---

## ROLE 4: PYTHON ENGINEER

**Reports to**: Tech Lead
**Owns**: `agent-observatory-kernel` (verdict engine, autoloop runner)

### Responsibilities
- Builds `agent-observatory-kernel` (Python service subscribing to V6 LaunchFactory events via HTTP polling at 5s interval)
- Implements autoloop runner per `specs/autoloop-yml-schema.md`
- Calls LLM per §3 of spec (provider-agnostic with fallback chain)
- Persists verdicts to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}` (file-first inspectable state)
- Implements `verdict_block_height` exposure for downstream freshness filtering
- Implements bonding curve dual-support (legacy k=1.0344e6 + current k=1.0344e9)
- Coordinates with AI/LLM Engineer (Role 5) for provider-agnostic routing

### Required skills
- Python 3.11+
- web3.py (for RPC calls to `https://rpc.testnet.chain.robinhood.com`)
- httpx (async HTTP client, preferred over requests)
- Pydantic (for `autoloop.yml` schema validation)
- Click or Typer (CLI)
- asyncio (for concurrent LLM calls)
- pytest (unit tests)

### Tools
- Poetry or uv (dependency management)
- Ruff (linter + formatter)
- pytest (unit tests)
- Railway or Fly.io (deployment)
- Sentry (error monitoring)

### Estimated allocation
- 100% in Phase 2 (kernel)
- 50% in Phase 6 (demo agent integration)
- 30% in Phase 8 (post-MVP kernel enhancements)

---

## ROLE 5: AI/LLM ENGINEER

**Reports to**: Tech Lead
**Owns**: Provider-agnostic LLM router, autoloop.yml schema, evidence synthesis

### Responsibilities
- Designs and implements the provider-agnostic LLM router (Claude / Codex / Z.AI / MiniMax / HuggingFace router / Ollama — 6 providers)
- Implements role separation: `verdict_llm_provider` / `evidence_llm_provider` / `summary_llm_provider`
- Implements fallback chains per `specs/autoloop-yml-schema.md`
- Designs evidence synthesis (LLM call → structured verdict JSON with citations)
- Implements Brier score calculation (rolling 30-day window)
- Designs the `replay.html` template (founder's `seedify-agents-dashboard` static-export format)

### Required skills
- LLM provider APIs: Anthropic (Claude), OpenAI (Codex), Z.AI (GLM), MiniMax, HuggingFace router, Ollama
- Prompt engineering (for verdict synthesis with citations)
- JSON Schema (for verdict output validation)
- HTML/CSS/JS (for `replay.html` template)
- Statistical analysis (Brier score)

### Tools
- LiteLLM or LangChain (provider abstraction — but prefer custom router per founder's anti-framework stance)
- OpenAI/Anthropic/Z.AI/MiniMax SDKs
- JSON Schema validator
- Jinja2 (for `replay.html` template)

### Estimated allocation
- 100% in Phase 2 (kernel)
- 50% in Phase 6 (demo agent prompt tuning)
- 30% in Phase 8 (external revenue source — Phase-3 stretch goal)

---

## ROLE 6: DEVOPS/SRE

**Reports to**: Tech Lead
**Owns**: CI/CD, hosting, monitoring

### Responsibilities
- Sets up GitHub Actions CI for all 5 repos (test + lint + build on every PR)
- Sets up hosting for `agent-observatory-kernel` (Railway or Fly.io)
- Sets up hosting for `agent-observatory-studio` (Vercel)
- Sets up hosting for `agent-observatory-mcp-bridge` (NOT hosted — local process; but document the local install)
- Sets up monitoring (Sentry for errors, Logtail for logs, Better Uptime for uptime)
- Manages secrets (GitHub Actions secrets, .env files)
- Configures Slither + Mythril in CI for Solidity repos
- Configures dependency updates (Dependabot)

### Required skills
- GitHub Actions (workflow YAML)
- Docker (for kernel containerization)
- Railway or Fly.io (deployment)
- Vercel (for Next.js)
- Sentry (error monitoring)
- Logtail or Logz.io (log aggregation)

### Tools
- GitHub Actions
- Docker
- Railway CLI or Fly.io CLI
- Vercel CLI
- Sentry SDK (Python + TypeScript)
- Dependabot

### Estimated allocation
- 100% in Phase 0 (CI/CD setup)
- 30% in Phases 1-7 (maintenance)
- 50% in Phase 8 (post-MVP hosting for Phase-2 contracts)

### Infrastructure access
- GitHub Education benefits package (free GitHub Actions minutes for private repos)
- Azure for Builders (alternative hosting)
- AWS Builder ID (alternative hosting)
- See `infrastructure/ACCESS_PROTOCOL.md`

---

## ROLE 7: DOCUMENTATION LEAD

**Reports to**: Tech Lead
**Owns**: All README files, technical docs, handoff docs

### Responsibilities
- Maintains comprehensive README for each of the 5 repos
- Maintains `docs/` folder (spec, research dossier, roadmap, team roles, acceptance criteria)
- Maintains `handoff/` folder (agent instructions, team composition, phase breakdown, communication protocol)
- Ensures ALL documentation is in English (Persian must NOT leak — see §6 of AGENT_INSTRUCTIONS.md)
- Maintains architecture decision records (ADRs)
- Maintains the worklog (`research/WORKLOG.md` — already 4000+ lines from research phase)

### Required skills
- Technical writing (clear, concise, English-only)
- Markdown (GitHub-flavored)
- Mermaid (for diagrams)
- README-driven development (write README before code)

### Tools
- Markdown editor (Obsidian or VS Code)
- Mermaid (diagrams)
- GitHub Wiki (for each repo)
- Notion or Obsidian (decision records)

### Estimated allocation
- 30% in Phase 0 (initial docs)
- 50% in Phases 1-7 (continuous documentation)
- 100% in Phase 7 (final repo polishing)

---

## ROLE 8: QA/TESTING LEAD

**Reports to**: Tech Lead
**Owns**: Test strategy, automated tests, security analysis

### Responsibilities
- Designs test strategy per repo (unit, integration, E2E)
- Writes Vitest unit tests for TypeScript repos (`vibe-vibe-create-sdk`, `agent-observatory-studio`, `agent-observatory-mcp-bridge`)
- Writes pytest unit tests for `agent-observatory-kernel`
- Writes Foundry tests for `agent-observatory-contracts` (Phase-2 contracts)
- Runs Slither + Mythril on all Solidity contracts
- Writes Playwright E2E tests for `agent-observatory-studio`
- Sets up CI test automation
- Coordinates with Solidity Engineer (Role 2) for Phase-2 contract security review

### Required skills
- Vitest (TypeScript unit testing)
- pytest (Python unit testing)
- Foundry (`forge test`)
- Slither + Mythril (Solidity security analysis)
- Playwright (E2E testing)
- Coverage measurement (c8, pytest-cov, forge coverage)

### Tools
- Vitest, pytest, Foundry, Playwright
- Slither, Mythril
- Codecov (coverage reports)
- SonarQube (code quality)

### Estimated allocation
- 30% in Phase 0 (test strategy)
- 100% in Phases 1-7 (continuous testing)
- 100% in Phase 8 (security review for Phase-2 contracts)

---

## ROLE 9: LEGAL/COMPLIANCE REVIEWER

**Reports to**: Tech Lead
**Owns**: Securities-law posture, Reg S, MiCA, KYC integration

### Responsibilities
- Reviews all contract code for Howey exposure (per §0.2 of spec)
- Reviews all tokenomics for Reg S compliance (per §0.2)
- Reviews all marketing copy for "bond" / "insurance" terminology avoidance (per §2 of AGENT_INSTRUCTIONS.md)
- Reviews multi-sig scope limitation (per §0.2)
- Coordinates with external legal counsel (founder's responsibility) for 2-opinion legal memo on utility-token characterization
- Designs KYC integration (e.g., with Fractal ID, Persona, or Stripe Identity)
- Designs IP geo-fence (Cloudflare Workers with IP geolocation)
- Designs ToS attestation flow

### Required skills
- Securities law (Howey, Reg S, Reg D, Investment Company Act of 1940)
- CFTC (event contracts, swaps, SEFs)
- MiCA (EU crypto regulation)
- State money transmitter laws (NY BitLicense, CA DFPI)
- Smart contract review (Solidity + EVM)
- KYC integration (Fractal ID, Persona, Stripe Identity)

### Tools
- Westlaw or LexisNexis (legal research)
- GitHub (PR review)
- Slither (Solidity security analysis)
- Persona or Stripe Identity (KYC integration)

### Estimated allocation
- 30% in Phase 0 (initial legal review)
- 100% in Phase 5 (Solidity scaffolding legal review)
- 100% in Phase 8 (Phase-2 contracts legal review)
- Ongoing: PR review for legal compliance

### CRITICAL: This role should coordinate with external legal counsel. The founder's responsibility is to obtain a 2-opinion legal memo on utility-token characterization. The Legal/Compliance Reviewer's role is to ensure the code respects the legal posture until that memo is obtained.

---

## ROLE 10: COMMUNITY/BD

**Reports to**: Project owner (user)
**Owns**: Discord integration, builder outreach, vibe/vibe team liaison

### Responsibilities
- Builds the Discord bot slash-command `/agent-observatory-launch` (Day 21 deliverable)
- Coordinates with `discord.gg/vibevibebuilders` admins for bot approval
- Posts the 3 demo agent-attested tokens in `#project-showcase` channel
- Replies to community questions in `#builder-help` channel
- Monitors Discord for feedback / pain points / feature requests
- Liaises with the vibe/vibe team (Justine Aguilar @Jinz02, Neil Meintjes @neilmeintjes, founder Levent Cem Aydan @meta_alchemist) for:
  - Builder Foundry playbook integration (AgentObservatory as playbook #9)
  - V6 LaunchFactory address verification (still unsourced per worklog §6b-onchain-fast)
  - Guilds contract address (still unknown per worklog)
  - Phase-2 contract audit timeline
- Prepares the launch tweet for `@meta_alchemist` quote-tweet (per founder's pattern of amplifying Hailey's guild analytics tool)

### Required skills
- Discord bot development (discord.js for TypeScript, discord.py for Python)
- Community management (Discord etiquette, conflict resolution)
- BD outreach (Twitter DM, Telegram, email)
- Marketing copy (Twitter thread writing)

### Tools
- Discord.js or discord.py
- Linear (for community feedback tracking)
- Twitter (for launch thread)
- Telegram (for vibe/vibe team liaison)

### Estimated allocation
- 30% in Phase 0 (Discord bot scaffolding)
- 50% in Phases 1-7 (continuous community engagement)
- 100% in Phase 7 (Discord bot launch + showcase posts)

---

## SOLO FOUNDER WITH CLAUDE CODE (ALTERNATIVE COMPOSITION)

If the project is executed by a solo founder with Claude Code (Pieter Levels pattern), combine roles as:

- **You (founder)**: Role 1 (Tech Lead) + Role 10 (Community/BD) + final review of Roles 2, 3, 4, 5, 6, 7, 8, 9
- **Claude Code**: Roles 2 (Solidity) + 3 (TypeScript) + 4 (Python) + 5 (AI/LLM) + 6 (DevOps) + 7 (Docs) + 8 (QA) + 9 (Legal review prompts)

This is feasible because Claude Code can write code across multiple languages, set up CI/CD, write tests, write docs, and review legal compliance (with external counsel for the 2-opinion memo).

Estimated allocation:
- Day 1-2: Set up 5 repos + Claude Code project
- Day 3-7: Implement `vibe-vibe-create-sdk` with Claude Code
- Day 8-12: Implement `agent-observatory-kernel` with Claude Code
- Day 13-15: Implement `agent-observatory-studio` + MCP bridge with Claude Code
- Day 16-17: Launch 3 demo agent-attested tokens on testnet
- Day 18-19: Daily digest pipeline
- Day 20-21: Discord bot + final repo polishing

