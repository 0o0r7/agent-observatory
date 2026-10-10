# PHASE BREAKDOWN — Parallel Execution Plan

**Document purpose**: Define the parallel phase execution plan for AgentObservatory v2.
**Total duration**: 21-day MVP (solo founder with Claude Code) OR 14-day MVP (5-engineer team)
**Coordination model**: Parallel execution with explicit phase dependencies

---

## DEPENDENCY GRAPH

```
Phase 0 (Day 1) — Repo Setup
  ├─→ Phase 1 (Day 2-7) — vibe-vibe-create-sdk + vibe-vibe-create-abi
  │     └─→ Phase 3 (Day 8-15) — agent-observatory-studio (depends on SDK)
  │     └─→ Phase 4 (Day 10-14) — agent-observatory-mcp-bridge (depends on SDK)
  │     └─→ Phase 6 (Day 16-17) — 3 demo agent-attested tokens (depends on SDK + Studio)
  ├─→ Phase 2 (Day 5-12) — agent-observatory-kernel (parallel with Phase 1)
  │     └─→ Phase 6 (Day 16-17) — demo agents (depends on kernel for verdicts)
  │     └─→ Phase 8 (post-MVP) — Phase-2 contracts (depends on kernel design)
  ├─→ Phase 5 (Day 13-18) — agent-observatory-contracts Solidity scaffolding
  │     └─→ Phase 8 (post-MVP) — Phase-2 contracts deployment
  └─→ Phase 7 (Day 19-21) — Discord bot + GitHub repo finalization (depends on all prior)
```

**Key parallel opportunities**:
- Phase 1 (SDK) + Phase 2 (Kernel) can run in parallel after Phase 0
- Phase 3 (Studio) + Phase 4 (MCP bridge) can run in parallel after Phase 1
- Phase 5 (Solidity scaffolding) can run in parallel with all others (no MVP dependency)

---

## PHASE 0 — REPO SETUP (Day 1)

**Owner**: Tech Lead (Role 1)
**Estimated effort**: 1 day
**Dependencies**: None

### Tasks

1. Create the 5 repositories on GitHub (per §5.1 of spec):
   - `agent-observatory-kernel` (Python, AGPL-3.0)
   - `agent-observatory-contracts` (Solidity, MIT)
   - `agent-observatory-studio` (Next.js, MIT)
   - `agent-observatory-mcp-bridge` (TypeScript, MIT)
   - `vibe-vibe-create-sdk` (TypeScript, MIT)

2. Set up monorepo coordination (choose one):
   - Turborepo (recommended for TypeScript-heavy)
   - Git submodules (recommended for cross-language)
   - Separate repos with shared GitHub Organization (recommended for license isolation)

3. Set up CI/CD for each repo:
   - GitHub Actions workflow YAML
   - Test + lint + build on every PR
   - Dependabot for dependency updates

4. Set up the documentation structure (per `AGENT_INSTRUCTIONS.md`):
   - `docs/` folder with spec, research dossier, roadmap, team roles, acceptance criteria
   - `handoff/` folder with agent instructions, team composition, phase breakdown, communication protocol
   - `infrastructure/` folder with GitHub Education, NVIDIA, Azure, AWS Builder docs
   - `research/` folder with worklog (4000+ lines), ideas (Round 1, 2, 3, GEM phase), v1 spec
   - `specs/` folder with autoloop-yml-schema, erc20-agent-token, v6-launchfactory-integration, mcp-bridge, provenance-oracle, reflections-router, securities-law-posture, robinhood-ecosystem-boundary, bonding-curve-dual-support

5. Set up Secrets management:
   - GitHub Actions secrets: `RPC_URL`, `DISCORD_TOKEN`, `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `ZAI_API_KEY`, `MINIMAX_API_KEY`, `HUGGINGFACE_TOKEN`
   - .env.example for local development

### Deliverables
- 5 GitHub repos with initial commit (README.md + LICENSE)
- CI/CD configured (green builds)
- Documentation structure in place
- `.env.example` files for each repo

### Acceptance criteria
- All 5 repos exist and are accessible
- README.md in each repo (English, comprehensive)
- LICENSE file in each repo (AGPL-3.0 for kernel; MIT for others)
- GitHub Actions workflow file in each repo
- Documentation folder structure per `AGENT_INSTRUCTIONS.md` §4

---

## PHASE 1 — VIBE-VIBE-CREATE-SDK (Day 2-7)

**Owner**: TypeScript/Next.js Engineer (Role 3)
**Estimated effort**: 6 days
**Dependencies**: Phase 0

### Tasks

1. Implement `vibe-vibe-create-abi` selector recovery package:
   - 24/86 decoded V6 selectors as TypeScript discriminated unions (per worklog §6b-onchain-fast)
   - `launchTokenRaw(calldata: Hex)` for unverifiable selector `0x24e615b3`
   - `submitABI(abi: ABI, sourceUrl: string)` community-contribution API
   - Validates submitted ABI against deployed bytecode (re-computes selectors)

2. Implement `vibe-vibe-create-sdk` core (15+ TypeScript functions):
   - `connectWallet()` (via Privy)
   - `prefillCreateForm(params)` (token name/ticker/image/description/pair/tax/allocations/airdrop)
   - `launchToken()` (signs tx via Privy, emits `BuildLog` event)
   - `getLaunchState(tokenAddress)` (Bonding/Bonded/Graduating/Graduated)
   - `getBondingCurveProgress(tokenAddress)` (with dual-support for legacy + current k values per §9 of spec)
   - `getReflectionOwed(holder, token)`
   - `getAntiSniperWindowStatus(token)` (first 20s, sliding 99%→base)
   - `commitVerdict(launchAddress, verdictHash, stakeAmount)` (per §4.1 of spec)
   - `revealVerdict(launchAddress, predictedOutcome, salt)` (per §4.2)
   - `getBrierScore(holder)` (rolling 30-day accuracy)
   - `subscribeToNewLaunches(callback)` (HTTP polling at 5s interval — NOT WebSocket)
   - `getLaunchCount()` (uses decoded `launchCount()` selector)
   - `getLaunchNonce(creatorAddress)` (uses decoded `launchNonce(address)` selector)
   - `getCreationFee()` (uses decoded `creationFee()` selector — 0.0004 ETH)
   - `getTreasuryAddress()` (uses decoded `treasury()` selector)

3. Implement `BuildLog` event indexer (per J4 Round-2 strengthening suggestion):
   - Listens to V6 LaunchFactory `LaunchCreated` events
   - Correlates with git commit hashes by `authorWallet`
   - Indexes to a public, Blockscout-indexable event log

4. Write 3 example repos under `examples/`:
   - `examples/basic-launch/` (one-click token launch)
   - `examples/anti-sniper-bot/` (use `getAntiSniperWindowStatus` to detect snipable launches)
   - `examples/commit-reveal-verdict/` (use `commitVerdict` + `revealVerdict`)

5. Publish to npm:
   - `vibe-vibe-create-sdk` package
   - `vibe-vibe-create-abi` package

### Deliverables
- `vibe-vibe-create-sdk` v0.1.0 on npm
- `vibe-vibe-create-abi` v0.1.0 on npm
- 3 example repos
- Comprehensive README with API reference
- Vitest unit tests (>80% coverage)

### Acceptance criteria
- All 15+ functions implemented and tested
- `vibe-vibe-create-abi` correctly decodes all 24 selectors
- `launchTokenRaw` correctly handles unverifiable `0x24e615b3` selector
- `BuildLog` event indexer produces verifiable on-chain correlation
- 3 example repos work end-to-end on Robinhood Chain Testnet
- npm packages published (public)

---

## PHASE 2 — AGENT-OBSERVATORY-KERNEL (Day 5-12, parallel with Phase 1)

**Owner**: Python Engineer (Role 4) + AI/LLM Engineer (Role 5)
**Estimated effort**: 8 days
**Dependencies**: Phase 0

### Tasks

1. Set up Python service scaffold:
   - Poetry or uv for dependency management
   - Ruff for linting + formatting
   - pytest for unit tests
   - Click or Typer for CLI

2. Implement HTTP polling subscriber (NOT WebSocket per worklog §6b-onchain-fast):
   - Polls `https://rpc.testnet.chain.robinhood.com` every 5s
   - Fetches new V6 LaunchFactory `LaunchCreated` events
   - Exposes `verdict_block_height` for downstream freshness filtering
   - 50-block kernel lag at 5s HTTP polling cadence (acknowledged in `artifacts/`)

3. Implement provider-agnostic LLM router (per `specs/autoloop-yml-schema.md`):
   - 6 providers: Claude, Codex, Z.AI (GLM), MiniMax, HuggingFace router, Ollama
   - 3 roles: `verdict_llm_provider`, `evidence_llm_provider`, `summary_llm_provider`
   - Fallback chains per `autoloop.yml` schema
   - Retry strategy: exponential backoff

4. Implement autoloop runner:
   - Parses `autoloop.yml` per repo's config
   - Triggers verdict generation on new launch events
   - Persists to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}`
   - Updates Brier score (rolling 30-day window)
   - Promotes/demotes agents based on `promote_policy` per `autoloop.yml`

5. Implement verdict generation:
   - For each new launch, fetches: pair asset, tax rate, opening buy size, project-share allocation, creator wallet history, prior launch outcomes
   - Calls LLM (verdict_llm_provider) to generate verdict: `{launch_address, verdict: graduate|fail, confidence: 0-100, evidence_citations: [...], commit_hash, timestamp}`
   - Persists to `artifacts/verdicts/<launch_address>/`

6. Implement `replay.html` template:
   - Jinja2 template matching founder's `seedify-agents-dashboard` static-export format
   - Includes: input data, evidence citations, verdict output, LLM provider used, commit hash
   - Standalone HTML (no external dependencies) — file-first inspectable state

7. Implement bonding curve dual-support:
   - Detects generation via launch timestamp (pre-2026-09-05 = legacy k=1.0344e6; post = current k=1.0344e9)
   - Applies appropriate formula in `getBondingCurveProgress`

8. Implement evidence synthesis:
   - Queries Blockscout API (`https://explorer.testnet.chain.robinhood.com/api`)
   - Queries V6 LaunchFactory events (24/86 decoded selectors)
   - Queries launch creator history (`launchNonce(address)`)
   - Queries pair asset metadata (ETH/NVDA/AAPL/SPCX/OPENAI/ANTHROPIC)

### Deliverables
- `agent-observatory-kernel` v0.1.0 on PyPI (or GitHub Packages)
- 3 demo agents (NVDA-pair "Stock-Meme Sniffer", ETH-pair "Graduation Radar", ANTHROPIC-pair "AI-Stock Trend Spotter")
- Comprehensive README with autoloop.yml reference
- pytest unit tests (>80% coverage)
- 3 demo `replay.html` files in `artifacts/verdicts/`

### Acceptance criteria
- HTTP polling subscriber correctly detects new V6 launches
- LLM router supports all 6 providers with fallback
- Autoloop runner correctly persists to `artifacts/`
- 3 demo agents produce verifiable verdicts
- Brier score correctly calculated (rolling 30-day window)
- `replay.html` files render correctly in browser

---

## PHASE 3 — AGENT-OBSERVATORY-STUDIO (Day 8-15, parallel with Phase 2)

**Owner**: TypeScript/Next.js Engineer (Role 3)
**Estimated effort**: 8 days
**Dependencies**: Phase 1 (vibe-vibe-create-sdk)

### Tasks

1. Set up Next.js 16 project:
   - App Router
   - Tailwind CSS 4 + shadcn/ui
   - Privy wallet integration (per founder's ask #3)
   - viem for EVM interactions

2. Implement core UI flow:
   - Pick stock pair (NVDA / AAPL / SPCX / OPENAI / ANTHROPIC / ETH)
   - Specify LLM provider (Claude / Codex / Z.AI / MiniMax / HuggingFace / Ollama)
   - Configure autoloop.yml (verdict_loop, evidence_budget, accuracy_metric, promote_policy)
   - Preview ritual (tax flows, airdrop audiences, projected distribution)
   - 1-click launch via `vibe-vibe-create-sdk.launchToken()`

3. Implement agent dashboard:
   - Live verdict feed (subscribes to `agent-observatory-kernel` via SSE)
   - Per-agent Brier score visualization
   - Per-agent `replay.html` viewer
   - Holder commit-reveal interface (per §4 of spec)

4. Implement embeddable widget:
   - React component shippable as `<script>` for guilds/builders to embed on their own sites
   - Shows agent name, Brier score, latest verdict, link to studio

5. Implement daily digest image generator:
   - Cron job (every 24h) querying top-10 agent-attested tokens by 24h trading volume
   - Renders "Agent Verdict of the Day" PNG image (1200×628, X-post-ready)
   - Auto-posts to RSS feed at `/daily-digest.xml`

### Deliverables
- `agent-observatory-studio` deployed to Vercel
- Comprehensive README with deployment guide
- Vitest + Playwright tests (>80% coverage)
- 3 demo agent-attested tokens launched on testnet via the studio

### Acceptance criteria
- Studio UI works end-to-end (pair selection → LLM config → autoloop config → launch)
- Live verdict feed updates in real-time
- Brier score visualization renders correctly
- `replay.html` viewer works
- Embeddable widget works on third-party sites
- Daily digest image auto-generated and posted to RSS

---

## PHASE 4 — AGENT-OBSERVATORY-MCP-BRIDGE (Day 10-14, parallel with Phase 3)

**Owner**: TypeScript/Next.js Engineer (Role 3)
**Estimated effort**: 5 days
**Dependencies**: Phase 1 (vibe-vibe-create-sdk)

### Tasks

1. Set up TypeScript MCP server scaffold:
   - @modelcontextprotocol/sdk
   - Local process (NOT hosted service per §2.3 of AGENT_INSTRUCTIONS.md)
   - CLI installer (`npx agent-observatory-mcp-bridge install`)

2. Implement Robinhood Trading MCP bridge:
   - Connects to `https://agent.robinhood.com/mcp/trading` (77 tools, 6 categories)
   - Robinhood Agentic Account connected via Robinhood OAuth in browser (NOT via EVM wallet signature per §2.3)
   - EIP-712 typed-data authorization translated to Robinhood Trading MCP tool call
   - NEVER holds operator credentials (per §2.1 constraint #5)

3. Implement operator-in-control pattern:
   - Agent PROPOSES trade (displays in localhost UI)
   - Operator reviews and SIGNS via their own wallet (EIP-712 typed-data)
   - Bridge translates signed authorization to Robinhood Trading MCP tool call
   - Trade executes in holder's OWN Robinhood Agentic Account

4. Implement anti-sniper window auto-reject:
   - Auto-rejects MCP-proposed buys on tokens launched <20s ago
   - Returns `antiSniperWindowActive` revert
   - Prevents accidental 99% tax exposure (per AO-2 risk R-C)

5. Implement paper-trade mode (default):
   - When MCP bridge is not connected or operator opts out
   - Agent runs in paper-trade-only mode (no real trades)
   - Verdicts still generated and persisted

### Deliverables
- `agent-observatory-mcp-bridge` v0.1.0 on npm
- Comprehensive README with local install guide
- Vitest unit tests (>80% coverage)
- Anti-sniper window auto-reject verified

### Acceptance criteria
- Local installer works on macOS, Linux, Windows
- Robinhood OAuth flow works in browser
- EIP-712 typed-data signing works with Privy / Rabby / MetaMask
- Anti-sniper window auto-reject triggers correctly
- Paper-trade mode is the default (no accidental real trades)

---

## PHASE 5 — AGENT-OBSERVATORY-CONTRACTS SCAFFOLDING (Day 13-18)

**Owner**: Solidity Engineer (Role 2) + Legal/Compliance Reviewer (Role 9)
**Estimated effort**: 6 days
**Dependencies**: Phase 0

### Tasks

1. Set up Foundry project scaffold:
   - `forge init`
   - Slither config (`slither.config.json`)
   - Mythril config
   - GitHub Actions workflow for Solidity CI

2. Implement Phase-2 Provenance Oracle (~160 lines, EIP-712 per §7.1 of spec):
   - EIP-712 domain separator
   - `VERDICT_TYPEHASH`
   - `registerVerdict()` function
   - Self-auditable with Slither + Mythril

3. Implement Phase-2 Per-Holder Commit-Reveal Contract (~250 lines per §4 of spec):
   - `commitVerdict()` function
   - `revealVerdict()` function
   - Brier score calculation (rolling 30-day window)
   - Slash for inaccuracy (30-day accuracy < 0.40)

4. Implement Phase-2 Reflections Router (~150 lines per §7.2):
   - Pull-based distribution
   - Snapshot-based (NOT maintained ledger — avoids transfer-agent characterization)
   - Multi-sig ratifies deterministic SybilClusterProof (does NOT initiate slashing)

5. Implement Phase-2 Slashable Stake (~80 lines):
   - Operators lock 0.1% of supply for 30 days
   - 7-day timelock before slash execution
   - Community dispute window

6. Run Slither + Mythril security analysis on all contracts

7. **DO NOT DEPLOY** — Phase-2 contracts are deferred to post-team-audit per §2.3 constraint (V6 itself is NOT source-verified on Blockscout per worklog §6b-onchain-fast)

### Deliverables
- `agent-observatory-contracts` repo with 4 Phase-2 contract scaffolds
- Slither + Mythril security analysis reports
- Comprehensive README with deployment guide (DEFERRED)
- Foundry tests (>80% coverage)

### Acceptance criteria
- All 4 Phase-2 contracts scaffolded (Provenance Oracle, Commit-Reveal, Reflections Router, Slashable Stake)
- Slither reports no critical/high/medium findings
- Mythril reports no critical/high/medium findings
- Foundry tests pass
- README clearly states "DEFERRED to post-team-audit"

---

## PHASE 6 — DEMO AGENTS + DAILY DIGEST (Day 16-20)

**Owner**: Python Engineer (Role 4) + TypeScript/Next.js Engineer (Role 3)
**Estimated effort**: 5 days
**Dependencies**: Phases 1, 2, 3

### Tasks

1. Launch 3 demo agent-attested tokens on testnet via `agent-observatory-studio`:
   - NVDA-pair "Stock-Meme Sniffer" — agent that observes NVDA-paired launches
   - ETH-pair "Graduation Radar" — agent that predicts graduation probability
   - ANTHROPIC-pair "AI-Stock Trend Spotter" — agent that spots AI-stock trends

2. Run kernel for 48 hours, generate verdicts for each demo agent

3. Generate daily digest images:
   - Top-10 agent-attested tokens by 24h trading volume
   - "Agent Verdict of the Day" PNG (1200×628)
   - Auto-posted to RSS feed

4. Test commit-reveal flow:
   - Holders commit verdicts on launched tokens
   - After graduation (or 7-day timeout), reveal
   - Verify Brier score updates correctly
   - Verify reflection distribution (when Phase-2 contracts deploy, post-MVP)

### Deliverables
- 3 demo agent-attested tokens live on testnet
- 48 hours of verdict data in `artifacts/`
- 2 daily digest images (Day 1 + Day 2)
- RSS feed with 2 entries

### Acceptance criteria
- 3 tokens successfully launched via studio
- Kernel generates verdicts for each
- Daily digest auto-generated and posted to RSS
- Commit-reveal flow works (commit → wait → reveal)

---

## PHASE 7 — DISCORD BOT + GITHUB REPO FINALIZATION (Day 19-21)

**Owner**: Community/BD (Role 10) + Documentation Lead (Role 7)
**Estimated effort**: 3 days
**Dependencies**: All prior phases

### Tasks

1. Build Discord bot slash-command `/agent-observatory-launch`:
   - discord.js (TypeScript)
   - Pre-fills the studio's web flow with the user's Discord ID
   - Posts to `discord.gg/vibevibebuilders` `#project-showcase` channel

2. Submit bot to vibe/vibe Discord admins for approval

3. Post the 3 demo agent-attested tokens in `#project-showcase`

4. Polish all 5 repos:
   - Comprehensive README in each repo (English, technical)
   - LICENSE file (AGPL-3.0 for kernel; MIT for others)
   - 3 example repos under `examples/`
   - Architecture diagrams (Mermaid)
   - API reference docs

5. Prepare the launch tweet for `@meta_alchemist`:
   - Quote the founder's `seedify-agents-dashboard` README: "Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows"
   - Position as "the other half of the Venn diagram"
   - Link to GitHub repo + demo agent-attested tokens

6. Final acceptance criteria verification (per `docs/06-acceptance-criteria.md`)

### Deliverables
- Discord bot slash-command live in `discord.gg/vibevibebuilders`
- 3 demo agent-attested tokens posted in `#project-showcase`
- All 5 repos polished with comprehensive READMEs
- Launch tweet ready for `@meta_alchemist`

### Acceptance criteria
- Discord bot approved by admins and live
- All 25 critical constraints (§2 of AGENT_INSTRUCTIONS.md) verified
- All 5 repos have comprehensive README + LICENSE + 3+ examples
- Launch tweet ready

---

## PHASE 8 — POST-MVP: PHASE-2 CONTRACTS DEPLOYMENT

**Owner**: Solidity Engineer (Role 2) + Legal/Compliance Reviewer (Role 9)
**Estimated effort**: TBD (depends on V6 audit timeline)
**Dependencies**: V6 audit completion + 2-opinion legal memo

### Tasks

1. Wait for V6 LaunchFactory source verification on Blockscout (team's responsibility)
2. Wait for V6 audit completion (team's responsibility)
3. Obtain 2-opinion legal memo on utility-token characterization (founder's responsibility)
4. Deploy Phase-2 contracts:
   - Provenance Oracle
   - Per-Holder Commit-Reveal
   - Reflections Router
   - Slashable Stake
5. Migrate MVP tokens to use Phase-2 contracts
6. Launch Builder Grants Fund (per §8 of spec)
7. Begin Phase-3 stretch goal: External revenue source (true Numerai-pattern)

