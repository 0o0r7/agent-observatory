# Acceptance Criteria — Per Phase

**Document purpose**: Define the acceptance criteria for each phase of the AgentObservatory v2 MVP.

---

## Phase 0 — Repo Setup (Day 1)

### Deliverables
- [ ] 5 GitHub repos created (`agent-observatory-kernel`, `agent-observatory-contracts`, `agent-observatory-studio`, `agent-observatory-mcp-bridge`, `vibe-vibe-create-sdk`)
- [ ] Each repo has comprehensive README (English, technical)
- [ ] Each repo has LICENSE file (AGPL-3.0 for kernel; MIT for others)
- [ ] Each repo has GitHub Actions workflow file
- [ ] Documentation folder structure per `AGENT_INSTRUCTIONS.md` §4
- [ ] `.env.example` files for each repo
- [ ] Turborepo or Git submodules coordination set up

### Acceptance Criteria
- All 5 repos are accessible on GitHub
- CI/CD green builds on initial commit
- Documentation structure verified by Tech Lead

---

## Phase 1 — Vibe-Vibe-Create-SDK (Day 2-7)

### Deliverables
- [ ] `vibe-vibe-create-abi` selector recovery package:
  - 24/86 decoded V6 selectors as TypeScript discriminated unions
  - `launchTokenRaw(calldata: Hex)` for unverifiable selector `0x24e615b3`
  - `submitABI(abi: ABI, sourceUrl: string)` community-contribution API
  - Validates submitted ABI against deployed bytecode
- [ ] `vibe-vibe-create-sdk` core (15+ TypeScript functions):
  - `connectWallet()` (via Privy)
  - `prefillCreateForm(params)`
  - `launchToken()` (signs tx via Privy, emits `BuildLog` event)
  - `getLaunchState(tokenAddress)`
  - `getBondingCurveProgress(tokenAddress)` (with dual-support for legacy + current k values)
  - `getReflectionOwed(holder, token)`
  - `getAntiSniperWindowStatus(token)`
  - `commitVerdict(launchAddress, verdictHash, stakeAmount)`
  - `revealVerdict(launchAddress, predictedOutcome, salt)`
  - `getBrierScore(holder)`
  - `subscribeToNewLaunches(callback)` (HTTP polling at 5s interval)
  - `getLaunchCount()`
  - `getLaunchNonce(creatorAddress)`
  - `getCreationFee()`
  - `getTreasuryAddress()`
- [ ] `BuildLog` event indexer:
  - Listens to V6 LaunchFactory `LaunchCreated` events
  - Correlates with git commit hashes by `authorWallet`
  - Indexes to a public, Blockscout-indexable event log
- [ ] 3 example repos under `examples/`:
  - `examples/basic-launch/`
  - `examples/anti-sniper-bot/`
  - `examples/commit-reveal-verdict/`
- [ ] Published to npm:
  - `vibe-vibe-create-sdk` v0.1.0
  - `vibe-vibe-create-abi` v0.1.0

### Acceptance Criteria
- All 15+ functions implemented and tested (Vitest, >80% coverage)
- `vibe-vibe-create-abi` correctly decodes all 24 selectors (verified against Blockscout API)
- `launchTokenRaw` correctly handles unverifiable `0x24e615b3` selector
- `BuildLog` event indexer produces verifiable on-chain correlation
- 3 example repos work end-to-end on Robinhood Chain Testnet
- npm packages published (public)
- Comprehensive README with API reference

---

## Phase 2 — Agent-Observatory-Kernel (Day 5-12)

### Deliverables
- [ ] Python service scaffold:
  - Poetry or uv for dependency management
  - Ruff for linting + formatting
  - pytest for unit tests
  - Click or Typer for CLI
- [ ] HTTP polling subscriber:
  - Polls `https://rpc.testnet.chain.robinhood.com` every 5s
  - Fetches new V6 LaunchFactory `LaunchCreated` events
  - Exposes `verdict_block_height` for downstream freshness filtering
- [ ] Provider-agnostic LLM router:
  - 6 providers: Claude, Codex, Z.AI (GLM), MiniMax, HuggingFace router, Ollama
  - 3 roles: `verdict_llm_provider`, `evidence_llm_provider`, `summary_llm_provider`
  - Fallback chains per `autoloop.yml` schema
  - Retry strategy: exponential backoff
- [ ] Autoloop runner:
  - Parses `autoloop.yml` per repo's config
  - Triggers verdict generation on new launch events
  - Persists to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}`
  - Updates Brier score (rolling 30-day window)
  - Promotes/demotes agents based on `promote_policy`
- [ ] Verdict generation:
  - For each new launch, fetches: pair asset, tax rate, opening buy size, project-share allocation, creator wallet history, prior launch outcomes
  - Calls LLM to generate verdict: `{launch_address, verdict: graduate|fail, confidence: 0-100, evidence_citations: [...], commit_hash, timestamp}`
- [ ] `replay.html` template (Jinja2):
  - Matches founder's `seedify-agents-dashboard` static-export format
  - Includes: input data, evidence citations, verdict output, LLM provider used, commit hash
  - Standalone HTML (no external dependencies)
- [ ] Bonding curve dual-support:
  - Detects generation via launch timestamp (pre-2026-09-05 = legacy k=1.0344e6; post = current k=1.0344e9)
  - Applies appropriate formula in `getBondingCurveProgress`
- [ ] Evidence synthesis:
  - Queries Blockscout API (`https://explorer.testnet.chain.robinhood.com/api`)
  - Queries V6 LaunchFactory events (24/86 decoded selectors)
  - Queries launch creator history (`launchNonce(address)`)
  - Queries pair asset metadata (ETH/NVDA/AAPL/SPCX/OPENAI/ANTHROPIC)

### Acceptance Criteria
- HTTP polling subscriber correctly detects new V6 launches (verified on testnet)
- LLM router supports all 6 providers with fallback (tested with mock providers)
- Autoloop runner correctly persists to `artifacts/`
- 3 demo agents produce verifiable verdicts (NVDA-pair, ETH-pair, ANTHROPIC-pair)
- Brier score correctly calculated (rolling 30-day window — verified with synthetic data)
- `replay.html` files render correctly in browser
- pytest unit tests >80% coverage
- Comprehensive README with autoloop.yml reference

---

## Phase 3 — Agent-Observatory-Studio (Day 8-15)

### Deliverables
- [ ] Next.js 16 project set up:
  - App Router
  - Tailwind CSS 4 + shadcn/ui
  - Privy wallet integration
  - viem for EVM interactions
- [ ] Core UI flow:
  - Pick stock pair (NVDA / AAPL / SPCX / OPENAI / ANTHROPIC / ETH)
  - Specify LLM provider (Claude / Codex / Z.AI / MiniMax / HuggingFace / Ollama)
  - Configure autoloop.yml (verdict_loop, evidence_budget, accuracy_metric, promote_policy)
  - Preview ritual (tax flows, airdrop audiences, projected distribution)
  - 1-click launch via `vibe-vibe-create-sdk.launchToken()`
- [ ] Agent dashboard:
  - Live verdict feed (subscribes to `agent-observatory-kernel` via SSE)
  - Per-agent Brier score visualization
  - Per-agent `replay.html` viewer
  - Holder commit-reveal interface
- [ ] Embeddable widget:
  - React component shippable as `<script>` for guilds/builders
  - Shows agent name, Brier score, latest verdict, link to studio
- [ ] Daily digest image generator:
  - Cron job (every 24h) querying top-10 agent-attested tokens by 24h trading volume
  - Renders "Agent Verdict of the Day" PNG (1200×628, X-post-ready)
  - Auto-posts to RSS feed at `/daily-digest.xml`

### Acceptance Criteria
- Studio UI works end-to-end (pair selection → LLM config → autoloop config → launch)
- Live verdict feed updates in real-time (SSE)
- Brier score visualization renders correctly
- `replay.html` viewer works
- Embeddable widget works on third-party sites
- Daily digest image auto-generated and posted to RSS
- Vitest + Playwright tests >80% coverage
- Deployed to Vercel

---

## Phase 4 — Agent-Observatory-MCP-Bridge (Day 10-14)

### Deliverables
- [ ] TypeScript MCP server scaffold:
  - @modelcontextprotocol/sdk
  - Local process (NOT hosted service)
  - CLI installer (`npx agent-observatory-mcp-bridge install`)
- [ ] Robinhood Trading MCP bridge:
  - Connects to `https://agent.robinhood.com/mcp/trading` (77 tools, 6 categories)
  - Robinhood Agentic Account connected via Robinhood OAuth in browser
  - EIP-712 typed-data authorization translated to Robinhood Trading MCP tool call
  - NEVER holds operator credentials
- [ ] Operator-in-control pattern:
  - Agent PROPOSES trade (displays in localhost UI)
  - Operator reviews and SIGNS via their own wallet (EIP-712 typed-data)
  - Bridge translates signed authorization to Robinhood Trading MCP tool call
  - Trade executes in holder's OWN Robinhood Agentic Account
- [ ] Anti-sniper window auto-reject:
  - Auto-rejects MCP-proposed buys on tokens launched <20s ago
  - Returns `antiSniperWindowActive` revert
- [ ] Paper-trade mode (default):
  - When MCP bridge is not connected or operator opts out
  - Agent runs in paper-trade-only mode
  - Verdicts still generated and persisted

### Acceptance Criteria
- Local installer works on macOS, Linux, Windows
- Robinhood OAuth flow works in browser
- EIP-712 typed-data signing works with Privy / Rabby / MetaMask
- Anti-sniper window auto-reject triggers correctly (verified with synthetic test)
- Paper-trade mode is the default (no accidental real trades)
- Vitest unit tests >80% coverage
- Published to npm as `agent-observatory-mcp-bridge` v0.1.0

---

## Phase 5 — Agent-Observatory-Contracts Scaffolding (Day 13-18)

### Deliverables
- [ ] Foundry project scaffold:
  - `forge init`
  - Slither config (`slither.config.json`)
  - Mythril config
  - GitHub Actions workflow for Solidity CI
- [ ] Phase-2 Provenance Oracle (~160 lines, EIP-712):
  - EIP-712 domain separator
  - `VERDICT_TYPEHASH`
  - `registerVerdict()` function
- [ ] Phase-2 Per-Holder Commit-Reveal Contract (~250 lines):
  - `commitVerdict()` function
  - `revealVerdict()` function
  - Brier score calculation (rolling 30-day window)
  - Slash for inaccuracy (30-day accuracy < 0.40)
- [ ] Phase-2 Reflections Router (~150 lines):
  - Pull-based distribution
  - Snapshot-based (NOT maintained ledger)
  - Multi-sig ratifies deterministic SybilClusterProof
- [ ] Phase-2 Slashable Stake (~80 lines):
  - Operators lock 0.1% of supply for 30 days
  - 7-day timelock before slash execution
  - Community dispute window
- [ ] Slither + Mythril security analysis reports
- [ ] **DO NOT DEPLOY** — Phase-2 contracts are deferred to post-team-audit

### Acceptance Criteria
- All 4 Phase-2 contracts scaffolded
- Slither reports no critical/high/medium findings
- Mythril reports no critical/high/medium findings
- Foundry tests pass (>80% coverage)
- README clearly states "DEFERRED to post-team-audit"

---

## Phase 6 — Demo Agents + Daily Digest (Day 16-20)

### Deliverables
- [ ] 3 demo agent-attested tokens launched on testnet via `agent-observatory-studio`:
  - NVDA-pair "Stock-Meme Sniffer"
  - ETH-pair "Graduation Radar"
  - ANTHROPIC-pair "AI-Stock Trend Spotter"
- [ ] Kernel runs for 48 hours, generates verdicts for each demo agent
- [ ] Daily digest images:
  - Top-10 agent-attested tokens by 24h trading volume
  - "Agent Verdict of the Day" PNG (1200×628)
  - Auto-posted to RSS feed
- [ ] Commit-reveal flow test:
  - Holders commit verdicts on launched tokens
  - After graduation (or 7-day timeout), reveal
  - Verify Brier score updates correctly
  - Verify reflection distribution (when Phase-2 contracts deploy, post-MVP)

### Acceptance Criteria
- 3 tokens successfully launched via studio
- Kernel generates verdicts for each (48 hours of data in `artifacts/`)
- Daily digest auto-generated and posted to RSS (2 entries — Day 1 + Day 2)
- Commit-reveal flow works (commit → wait → reveal)

---

## Phase 7 — Discord Bot + GitHub Repo Finalization (Day 19-21)

### Deliverables
- [ ] Discord bot slash-command `/agent-observatory-launch`:
  - discord.js (TypeScript)
  - Pre-fills the studio's web flow with the user's Discord ID
  - Posts to `discord.gg/vibevibebuilders` `#project-showcase` channel
- [ ] Bot submitted to vibe/vibe Discord admins for approval
- [ ] 3 demo agent-attested tokens posted in `#project-showcase`
- [ ] All 5 repos polished:
  - Comprehensive README in each repo (English, technical)
  - LICENSE file (AGPL-3.0 for kernel; MIT for others)
  - 3 example repos under `examples/`
  - Architecture diagrams (Mermaid)
  - API reference docs
- [ ] Launch tweet ready for `@meta_alchemist`:
  - Quotes founder's `seedify-agents-dashboard` README
  - Position as "the other half of the Venn diagram"
  - Links to GitHub repo + demo agent-attested tokens
- [ ] Final acceptance criteria verification

### Acceptance Criteria
- Discord bot approved by admins and live
- All 25 critical constraints (§2 of `AGENT_INSTRUCTIONS.md`) verified
- All 5 repos have comprehensive README + LICENSE + 3+ examples
- Launch tweet ready (English, <280 chars, links to GitHub)

---

## Phase 8 — Post-MVP: Phase-2 Contracts Deployment

### Deliverables
- [ ] Wait for V6 LaunchFactory source verification on Blockscout (team's responsibility)
- [ ] Wait for V6 audit completion (team's responsibility)
- [ ] Obtain 2-opinion legal memo on utility-token characterization (founder's responsibility)
- [ ] Deploy Phase-2 contracts:
  - Provenance Oracle
  - Per-Holder Commit-Reveal
  - Reflections Router
  - Slashable Stake
- [ ] Migrate MVP tokens to use Phase-2 contracts
- [ ] Launch Builder Grants Fund
- [ ] Begin Phase-3 stretch goal: External revenue source (true Numerai-pattern)

### Acceptance Criteria
- V6 source verified on Blockscout
- V6 audit completed (no critical/high/medium findings)
- 2-opinion legal memo obtained (utility-token characterization confirmed)
- All 4 Phase-2 contracts deployed on Robinhood Chain Testnet
- All 4 Phase-2 contracts pass Slither + Mythril + external audit
- MVP tokens migrated to use Phase-2 contracts
- Builder Grants Fund operational (first grants disbursed)

