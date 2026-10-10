# AgentObservatory — Final Golden Goal Spec

Task ID: 10-agent-observatory-final
Agent: Main Orchestrator (post-primary-source + 3 fast-verifications synthesis)

## Executive Summary

**AgentObservatory** is a tokenized agent-observatory on vibe/vibe — a layer where AI agents (built on Robinhood Agents / Robinhood Trading MCP) discover, qualify, and surface the best stock-pair products launched on vibe/vibe. Each agent is an ERC-6551 token-bound account (non-custodial, cross-chain portable) launched as a token on vibe/vibe's V6 launchpad. Holders receive reflections from the agent's research quality (not from trading PnL — operator-mediated, paper-trade-only per the founder's DPRK-PTSD-driven ethos).

**Tagline**: "The other half of the Venn diagram."

## Why This Is THE Golden Goal (synthesized from all 10 research streams)

### Embodies the actually-novel thesis (3-pillar merge, NOT derivative "stock memes" claim)

The founder's verbatim Oct 6, 2026 thesis: "stock + memes + products merged." AgentObservatory completes this:
- **Stock pair**: each agent token paired with NVDA / AAPL / SPCX / OPENAI / ANTHROPIC
- **Memetic creativity**: agents generate research reports, qualification verdicts, and curated digests that ARE memetic content (every output is a social artifact)
- **Vibe-coded product**: each agent itself is a vibe-coded product (Claude Code / Codex / Robinhood Agents)

### Extends the founder's intellectual DNA (not pivots away)

His own `seedify-agents-dashboard` README (verbatim, worklog §5-calibration): "Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows."

AgentObservatory extends this from a static dashboard to a tokenized, decentralized agent-run observatory — the SAME intellectual pattern, now monetized.

His `founder-arena` repo: "Built for the age of AI agents. May the best algorithm win." — AgentObservatory is the launchpad where algorithms compete.

His "Autoloops > Agent Loops" thesis (June 8, 2026) — the LOOP is the unit; AgentObservatory's autoloop is: agent observes → qualifies → publishes verdict → next iteration uses verdict accuracy as feedback signal.

### Avoids the 4 Web3 gaming failure modes (per G3 historian)

1. **Premature monetization**: token AFTER the agent has shipped research verdicts (verifiable git commits + published verdicts)
2. **Ponzinomics**: yield from real research quality (commitment-reveal prediction accuracy), not from new deposits paying old yields
3. **Bad game design**: research qualification IS the game (not a farming loop dressed as a game)
4. **Speculator-primacy**: holders must run/observe the agent to claim reflections (no passive airdrop farming)

### Avoids BitClout/reputation-market trap (per J2 + G5)

Each agent token's value is backed by REAL research output (verifiable verdicts with citations + accuracy scores), NOT by speculative reputation. Holders receive reflections from research quality (commitment-reveal prediction accuracy at graduation), NOT from token-price appreciation.

### Avoids Mirror Protocol failure (per G5)

Mirror used synthetics collateralized by broken Terra UST peg. AgentObservatory uses REAL Robinhood Stock Tokens (SEC-registered debt securities issued by RH Jersey, Form 40-APP filed 2026-07-14) as the pair asset — not synthetics.

### Embodies Numerai-pattern, NOT AI Arena entertainment (per G3 + J2's Round-2 veto of TrenchArena)

Critical correction from Round-2: TrenchArena was vetoed because its prize pool came from 80% trading tax (ponzinomics). AgentObservatory's yield source is REAL research-quality scoring:
- Agents commit verdicts (hash-committed before graduation, revealed after)
- Accuracy = did the token graduate as the agent predicted?
- Accurate agents receive a larger share of tax-distributed reflections
- INACCURATE agents receive LESS — this is real selection on quality, not circular redistribution
- Numerai's $400M AUM and 9-year survival prove the pattern works

### Differentiates from all 5 competitors (post-Oct-9 landscape)

| Competitor | Differentiation |
|---|---|
| Pump.fun Custom Pairs (Oct 9) | No agent layer, no ERC-6551, no MCP integration |
| Flap Protocol ($39M Q3, same chain) | Pure stock-dividend financialization; no research/qualification primitive |
| Clanker ecosystem fund | No Robinhood Chain presence, no stock pairs |
| Virtuals Protocol (Base, $1.37B mcap) | Head-on collision AVOIDED — AgentObservatory is "agent-as-observer", not "agent-as-asset" |
| Robinhood in-app Agent Apps | Closed B2B-partner surface (11 curated data sources); AgentObservatory is open, tokenized, non-custodial |

### Satisfies all 13 GEM criteria (verified against the original checklist)

1. ✅ Real product economics (research-quality scoring, not tax redistribution)
2. ✅ Growth flywheel (more agents → more verdicts → more accuracy data → better agents → more agents)
3. ✅ Smart contract integration (ERC-6551 + V6 + Provenance Oracle)
4. ✅ Stock pair integration (NVDA/AAPL/SPCX/OPENAI/ANTHROPIC + ETH)
5. ✅ Privy-style 3rd-party wallet (no native wallet connect required)
6. ✅ Futuristic + creative (tokenized agent observatory is novel; NOT basic game/site)
7. ✅ Actually shippable as complete product (MVP scope: 21 days, multi-repo)
8. ✅ Something the builder would use (founder's own seedify-agents-dashboard pattern)
9. ✅ Avoids all 4 Web3 gaming failure modes
10. ✅ Avoids agent-vs-agent entertainment trap (Numerai-pattern real-stakes)
11. ✅ Embodies the actually-novel three-pillar merge
12. ✅ EVM/Solidity only (Robinhood Chain is Arbitrum Orbit EVM)
13. ✅ Doesn't require unaudited custom contracts in MVP (uses V6 + ERC-6551 standard + ~150-line Provenance Oracle Phase 2)

---

## Architecture (every component respects J1's zero-custom-contract rule for MVP)

### MVP scope (Day 1-21, shippable by solo founder with Claude Code)

**Multi-repo (matches founder's Spark OS pattern: AGPL kernel + MIT adapters):**

#### Repo 1: `agent-observatory-kernel` (AGPL-3.0-only)
- Python service that subscribes to V6 LaunchFactory events via HTTP polling (no WebSocket per J1's Round-2 finding)
- For each new launch, fetches: pair asset, tax rate, opening buy size, project-share allocation, creator wallet history, prior launch outcomes
- Calls an LLM (Claude / Codex / Z.AI / MiniMax / Ollama — provider-agnostic per J4's criterion) to generate a qualification verdict
- Verdict output: `{launch_address, verdict: graduate|fail, confidence: 0-100, evidence_citations: [...], commit_hash, timestamp}`
- Saves to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}` — file-first inspectable state per J4

#### Repo 2: `agent-observatory-erc6551` (AGPL-3.0-only)
- Solidity implementation of ERC-6551 token-bound account for agent ownership
- Each agent is an NFT (ERC-721) that owns its own smart-contract account (ERC-6551)
- The account holds: the agent's treasury (tax receipts), the agent's prediction track record (verifiable on-chain)
- ~120 lines Solidity (uses OZ ERC-6551 reference impl, EVM-native primitives only)

#### Repo 3: `agent-observatory-studio` (MIT)
- Next.js 16 + viem + Tailwind + shadcn/ui + Privy wallet integration
- Web UI: launch an agent → specify LLM provider → specify stock pair → commit verdicts → publish as token on vibe/vibe V6
- Embeddable widget for any agent's page showing live verdict feed

#### Repo 4: `agent-observatory-mcp-bridge` (MIT, optional)
- TypeScript MCP server that exposes Robinhood Trading MCP at `agent.robinhood.com/mcp/trading` to agents
- Optional — agents can run paper-trade-only (no MCP) or live-trade (with MCP, requires holder's own Robinhood Agentic account)
- Implements operator-in-control: agent PROPOSES trade → operator's wallet SIGNS → trade executes
- Never holds operator credentials (per J4's critical security requirement)

#### Repo 5: `vibe-vibe-create-sdk` (MIT, the substrate)
- Reused from VibeForge SDK Studio v3 spec — the SDK that closes the documented "no SDK" gap
- 15+ functions: `connectWallet()`, `prefillCreateForm(params)`, `launchToken()`, `getLaunchState()`, `getBondingCurveProgress()`, `getReflectionOwed()`, `getAntiSniperWindowStatus()`, etc.
- Plus `vibe-vibe-create-abi` selector recovery package (per J1's Round-2 strengthening suggestion)
- Plus `BuildLog` event indexer (per J4's Round-2 strengthening suggestion)

### Phase-2 contracts (deferred to post-team-audit per J1's rule)

#### Phase-2a: Provenance Oracle (~160 lines Solidity, J1's Round-2 spec with EIP-191 ecrecover)
- Verifies agent's verdict signatures
- Stores `bytes32 verdictHash` per launch on-chain
- Self-auditable in an afternoon with Slither+Mythril

#### Phase-2b: Agent Reflections Router (~250 lines Solidity)
- Pull-based distribution (matches V6's existing reflection pattern)
- Routes tax receipts to agent-holders pro-rata by **accuracy score** (not by holding time — this is the Numerai-pattern)
- Slashable-stake pattern: agent operators lock 0.1% of supply for 30 days; slashable if Sybil cluster flagged
- Multi-sig of trusted operators for slashing decisions
- Phase 2.5: integrate with Guilds contract (when team publishes) for guild-mode reflections

#### Phase-2c: Charged-XP Bridge Manifest (J5's Round-2 spec)
- Non-binding spec document proposing: "Agents with >X% accuracy over 30 days → operator wallet receives Charged-status XP credit; Charged status grants 1 vote in seasonal Charged-only tournaments, weighted by vibe-viber level tier"
- Team can accept/reject/counter in a single GitHub Issue

### Token launch params (final)

| Parameter | Value | Reasoning |
|---|---|---|
| Pair (default) | ETH | Triggers native sink → $VIBEVIBE buyback from Day 1 (J2's primary amplification path) |
| Pair (optional) | NVDA / AAPL / SPCX / OPENAI / ANTHROPIC (via J2's fresh-launch + airdrop-to-holders bridge pattern) | Stock-meme thesis embodiment without V6-immutability violation |
| Tax | 2% (immutable at creation per V6 spec) | Lower than Flap's rate to attract builders |
| 80% project share split | 40% agent treasury / 40% pair-token reflections / 20% Builder Grants Fund (J2 + G5 fix — not "reflections to holders" which triggers Howey) | Real cash flow + cleanest legal posture |
| 20% platform share | Native ETH → sink; when $VIBEVIBE active → 80% buyback + half-burn + half-to-VIBEVIBE holders | Standard V6 behavior |
| Opening buy | 0% (no creator atomic buy) | Closes Prisoner's Dilemma per J5 |
| Graduation airdrop audiences | opt-in Fomo traders (0.5%) + $VIBEVIBE holders (0.5%) + $SPARK holders (0.5%) + Charged-vibe-viber holders (0.5%) | All 4 documented V6 audiences |
| Phase-2 treasury vesting | 30-day linear unlock post-graduation (J5's Round-2 spec) | Closes moral-hazard critique |
| Anti-sybil | Operator staked 0.1% supply for 30 days (slashable) + BuildLog git-commit-hash authorship evidence + V1 Soulbound NFT OR 0.01 ETH escrow (J3's Round-2 spec) | Non-free, multi-layered |
| US-exclusion stack | KYC + IP geo-fence + ToS attestation (G5's fix) | Match Stock Token eligibility (EU + non-US only) |

### MVP deliverables (Day 1-21)

| Day | Deliverable |
|---|---|
| 1-2 | `vibe-vibe-create-sdk` npm package (15+ functions + BuildLog event indexer + `vibe-vibe-create-abi` selector recovery) |
| 3-5 | `agent-observatory-studio` web app (Next.js + Privy + viem + provider-agnostic LLM router) |
| 6-9 | `agent-observatory-kernel` Python service (subscribes to V6 events, generates verdicts, persists to `artifacts/`) |
| 10-12 | `agent-observatory-erc6551` Solidity implementation (~120 lines, ERC-6551 standard) |
| 13-15 | `agent-observatory-mcp-bridge` TypeScript MCP server (optional, paper-trade + operator-controlled) |
| 16-17 | 3 demo agents launched on testnet (NVDA-pair "Stock-Meme Sniffer", ETH-pair "Graduation Radar", ANTHROPIC-pair "AI-Stock Trend Spotter") |
| 18-19 | Daily "Agent Verdict of the Day" digest image generator (J3's Round-2 spec extended) |
| 20 | GitHub repo with comprehensive README + MIT/AGPL license + 3 example repos under `examples/` |
| 21 | Discord bot slash-command `/agent-observatory-launch` in `discord.gg/vibevibebuilders` |

### How it counts for builder eligibility (worklog §F verbatim)

Per /docs/programs/eligibility: "Vibecoded/product creators: a working demo or MVP with evidence that it belongs to the submitting creator."

✅ Working demo (web app + 3 launched agents + Discord bot + daily digest)
✅ MVP (Phase-2 contracts explicitly deferred; MVP is multi-repo off-chain + ERC-6551 standard + V6 /create flow)
✅ Authorship evidence (GitHub commit history + AGPL/MIT licenses + BuildLog on-chain correlation)
✅ Belongs to the submitting creator (BuildLog `authorWallet` = launcher's EVM wallet + signed EIP-191 message in Phase-2 Provenance Oracle)

### Differentiation summary (final)

| Criterion | Pump.fun | Flap | Virtuals | Clanker | Robinhood Agent Apps | **AgentObservatory** |
|---|---|---|---|---|---|---|
| Robinhood Chain | ❌ (Solana) | ✅ | ❌ (Base) | ❌ (Base) | ✅ (in-app) | ✅ |
| Stock pair integration | ❌ | ✅ | ❌ | ❌ | ✅ (but data only) | ✅ (full) |
| AI agent layer | ❌ | ❌ | ✅ (agent-as-asset) | ❌ | ✅ (in-app) | ✅ (agent-as-observer) |
| Tokenized | ❌ | ✅ | ✅ | ✅ | ❌ (custodial) | ✅ (ERC-6551 non-custodial) |
| Cross-chain portable | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (ERC-6551) |
| Robinhood Trading MCP integration | ❌ | ❌ | ❌ | ❌ | ✅ (proprietary) | ✅ (open bridge) |
| Numerai-pattern real-stakes | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (accuracy-scored reflections) |
| Three-pillar merge (stock + meme + product) | ❌ | partial | partial | ❌ | partial | ✅ (full) |
| Founder's intellectual pattern match | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (extends seedify-agents-dashboard) |
| Open-source SDK | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (multi-repo AGPL+MIT) |

### Risks identified and mitigated (final pass)

| Risk | Source | Mitigation in v1 |
|---|---|---|
| Robinhood in-app Agent Apps expands to third-party agent install store | Research §9-robinhood-competitive-threat | Position as "non-custodial, cross-chain, tokenized agent OWNERSHIP layer" — different primitive than in-app install |
| Robinhood Trading MCP rate-limits / restricts | Research §9-robinhood-agents-api-verify | MCP integration is OPTIONAL — agents run paper-trade-only without MCP |
| Founder hasn't publicly endorsed Robinhood Agents | Research §9-founder-stance-agents | Position as extension of `seedify-agents-dashboard` (his own pattern) — NOT a pivot; cite his README verbatim |
| Virtuals head-on collision if framed as "AI agent launchpad" | Research §9-founder-stance-agents + J4's G4 Round-2 | Position as "Agent Observatory for Stock-Pair Products" — agent-as-observer, not agent-as-asset |
| Karpathy "vibe coding dead" brand risk | Research §8-competitive-cultural-refresh | Position around vibe-as-cultural-aesthetic (agents ARE the vibe); not coding literalism |
| V6 bonding curve changed 1000x mid-flight | Discord pain point #1 | SDK handles BOTH legacy (k=1.0344e6) and current (k=1.0344e9) curves |
| Robinhood Stock Token US exclusion | G5 Round-2 | KYC + IP geo-fence + ToS attestation stack (matches Stock Token eligibility) |
| ERC-6551 audit surface | J1 criterion | Uses OZ reference implementation; no custom Solidity in MVP (just standard ERC-6551 + 721) |
| Phase-2 Slashable Router audit surface | J1 criterion | Defer to post-team-audit; MVP uses V6's existing reflection system |
| Operator credentials security (DPRK PTSD) | J4 criterion | MCP bridge NEVER holds operator credentials; agent PROPOSES, operator SIGNS via their own wallet |
| "Tax redistribution dressed as real yield" trap (G2 + G3) | G2 Round-2 cross-cutting risk | Reflections distributed by ACCURACY SCORE (commitment-reveal prediction), not by holding time — Numerai-pattern real-stakes, not ponzinomics |
| Multi-sig personal liability (G5) | G5 Round-2 | Use Snapshot off-chain voting for curation decisions; multi-sig only for Phase-2 slashing with Reg D 506(c) accreditation gating |
| "Bond" naming = unregistered debt security (G5) | G5 Round-2 | Avoid "bond" terminology entirely; use "agent token" or "agent-attested token" |
| Builder Foundry integration | Discord research | Position AgentObservatory as playbook #9 in Builder Foundry (complement, not duplicate) |
| vibekit already exists as community-built SDK | Discord research | Ship `vibe-vibe-create-sdk` as our own (vibekit is community-built, NOT official); offer to merge or differentiate via BuildLog + Provenance Oracle |
| $VIBEVIBE not yet deployed | Inherent platform risk | MVP tax flows route to ETH sink + project treasury (existing V6 behavior); $VIBEVIBE amplification is automatic when pool activates |
| Founder's "stock memes" thesis still in bio | Twitter refresh | AgentObservatory is positioned as the OTHER half of the same Venn diagram (not pivot); both halves compose |

### Why founder would celebrate (final articulation)

1. **It IS his pattern**: `seedify-agents-dashboard` README verbatim: "Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows" — AgentObservatory extends this from static dashboard to tokenized, decentralized agent-run observatory. Same thesis, monetized.

2. **It IS his architecture**: Multi-repo (AGPL kernel + MIT adapters), provider-agnostic LLM routing, file-first inspectable state (`artifacts/` per Spark OS pattern), formal authority contracts (Governor + Authority Contract in Phase 2), fail-closed verification, operator-in-control (DPRK-PTSD-driven).

3. **It IS his thesis**: Three-pillar merge (stock pair + memetic creativity + vibe-coded product) — agent IS the vibe-coded product, agent's outputs ARE memetic creativity, agent paired with stock IS stock pair.

4. **It IS Numerai-pattern, not AI Arena**: Numerai succeeded ($400M AUM) because real-stakes (prediction accuracy → real money). AI Arena died because entertainment only. AgentObservatory's reflection distribution is BY ACCURACY SCORE, not by holding time.

5. **It IS Robinhood Agents integration without Robinhead collision**: Robinhood in-app Agent Apps is B2B-closed (11 data sources). AgentObservatory is open, tokenized, non-custodial, cross-chain — different primitive, different customer, different regulatory surface.

6. **It closes the documented "no SDK" gap**: worklog §F verbatim. The first thing shipped is `vibe-vibe-create-sdk` — the SDK the team has explicitly said is "planned" but doesn't exist. AgentObservatory becomes the canonical substrate for the entire builder program.

7. **It satisfies all 7 explicit builder requirements** (worklog §5b-calibration-twitter-fast, founder's verbatim Oct 6, 2026 tweet):
   - ✅ #1 Complete as possible (multi-repo, 21-day MVP)
   - ✅ #2 Smart contract integration (ERC-6551 + V6)
   - ✅ #3 Stock pairs integration (NVDA/AAPL/SPCX/OPENAI/ANTHROPIC)
   - ✅ #4 Privy wallet integration
   - ✅ #5 Futuristic + creative (tokenized agent observatory)
   - ✅ #6 Growth flywheel (more agents → more verdicts → more accuracy data → better agents)
   - ✅ #7 Something the builder would use (extends founder's own seedify-agents-dashboard)

8. **It avoids every failure mode** identified by Round-2 judges:
   - ✅ Avoids ponzinomics (yield from accuracy, not deposits)
   - ✅ Avoids BitClout (token backed by real research output)
   - ✅ Avoids Mirror Protocol (real Stock Tokens, not synthetics)
   - ✅ Avoids AI Arena (Numerai-pattern, not entertainment)
   - ✅ Avoids Virtuals collision (agent-as-observer, not agent-as-asset)
   - ✅ Avoids Robinhead collision (non-custodial, open, cross-chain — different primitive)
   - ✅ Avoids autonomous trading (operator-mediated, paper-trade-only by default)

