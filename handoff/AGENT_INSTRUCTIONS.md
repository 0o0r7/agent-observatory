# AGENT INSTRUCTIONS — GLM-5.3 Coder Agent

**Document purpose**: Complete handoff for the GLM-5.3 coder agent (or any senior coder agent) to execute the AgentObservatory v2 project independently.

**Project**: AgentObservatory v2 — Tokenized Agent Observatory on vibe/vibe (Robinhood Chain Testnet)
**Estimated effort**: 21-day MVP, 1-2 senior engineers OR 1 solo founder with Claude Code
**Repository**: This repository contains the full specification + research dossier + handoff.

---

## 1. PROJECT OVERVIEW

AgentObservatory v2 is a tokenized agent-observatory on the vibe/vibe launchpad (deployed on Robinhood Chain Testnet, an Arbitrum Orbit L2 with chain ID 46630). The product allows AI agents to discover, qualify, and surface the best stock-pair products launched on vibe/vibe. Each agent is launched as an ERC-20 token via vibe/vibe's V6 LaunchFactory `/create` flow. Holders submit their own verdicts via commit-reveal; reflections are distributed based on the HOLDER's OWN prediction accuracy (Numerai-pattern real-stakes).

**Read these documents FIRST** (in order):
1. `docs/01-specification-v2.md` — the complete specification (READ FIRST, especially §0 boundary statements)
2. `docs/02-research-dossier.md` — synthesis of all 10 research streams
3. `docs/04-roadmap-21-day-mvp.md` — 21-day MVP plan
4. `docs/05-team-roles.md` — specialized team roles for parallel execution
5. `docs/06-acceptance-criteria.md` — per-phase acceptance criteria
6. `handoff/PHASE_BREAKDOWN.md` — parallel phase execution plan
7. `handoff/TEAM_COMPOSITION.md` — how to form your specialized team
8. `handoff/COMMUNICATION_PROTOCOL.md` — how your team communicates

---

## 2. CRITICAL CONSTRAINTS (NON-NEGOTIABLE)

These constraints come from the founder's documented preferences and the 5-judge evaluation panel. Violating any of these will likely cause the founder to reject the project:

### §2.1 Architectural Constraints (from founder's GitHub pattern)

1. **Multi-repo structure** — DO NOT use a monolith. Split into 5 repos: `agent-observatory-kernel` (AGPL), `agent-observatory-contracts` (MIT, deployable artifacts), `agent-observatory-studio` (MIT), `agent-observatory-mcp-bridge` (MIT), `vibe-vibe-create-sdk` (MIT). The founder's Spark OS uses this exact pattern.

2. **AGPL kernel + MIT adapters** — The "kernel" (runtime that processes verdicts) is AGPL-3.0; the "adapters" (UI, SDK, MCP bridge) are MIT. This is the founder's license-split rule.

3. **Provider-agnostic LLM routing** — DO NOT lock to Claude. The LLM router must support 6 providers with role separation: Claude, Codex, Z.AI (GLM), MiniMax, HuggingFace router, Ollama. See `specs/autoloop-yml-schema.md` for the per-role fallback chain.

4. **File-first inspectable state** — Every agent run MUST persist to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}`. This matches the founder's `artifacts/paper_trade/` pattern in his `spark-researcher` repo.

5. **Operator-in-control / fail-closed verification** — The agent NEVER holds operator credentials. The agent PROPOSES, the operator SIGNS via their own wallet (EIP-712 typed-data). This is the founder's DPRK-PTSD-driven rule (the 2025-09-23 DPRK/Lazarus hack of Seedify bridge was via a stolen developer private key).

6. **Evidence over prose** — Verdict outputs MUST include `evidence_citations` (URLs + quotes), `commit_hash`, and `replay.html`. NOT just text.

7. **Autoloop, not one-shot** — The agent's verdict loop MUST specify a `autoloop.yml` schema with feedback signals (verdict accuracy → next iteration's prompt refinement). See `specs/autoloop-yml-schema.md`. The founder's June 8, 2026 thesis: "Autoloops > Agent Loops" — the LOOP is the unit, not the agent.

### §2.2 Legal/Regulatory Constraints (from AO-5 Regulatory judge)

8. **NO "agent token" terminology** — Use "agent-attested token" or "agent-curated token" only. The "agent token" framing risks Virtuals head-on collision (Virtuals owns the "AI agent launchpad" category on Base, $1.37B mcap).

9. **Per-holder commit-reveal (Howey fix)** — Holders submit their OWN verdicts via commit-reveal. Reflections are distributed based on the HOLDER's prediction accuracy, NOT the operator's. This fails the "efforts of others" prong of Howey.

10. **Slash for inaccuracy (Numerai-pattern)** — Operators lock 0.1% of supply for 30 days; slashable if 30-day accuracy < 0.40 (Brier score). NOT just slash for sybil.

11. **Reg S transfer-restriction stack** — For tokens paired with Robinhood Stock Tokens, add: (i) whitelist-based transfer with KYC per transfer; (ii) Reg S legend in token metadata; (iii) custom `transfer()` override smart contract hook verifying recipient non-US whitelist status; (iv) Rule 902(c) "diligent inquiry" verification.

12. **US-exclusion stack** — KYC + IP geo-fence + ToS attestation. NOT just Privy wallet. (Robinhood Stock Tokens are EU + non-US only — US retail AND US accredited both excluded.)

13. **NO "bond" terminology** — Use "agent-attested token" or "agent-curated token". "Bond" risks debt-security classification under Securities Act §3(a)(10).

14. **NO "insurance" terminology** — Slashing is a "staking penalty", NOT an insurance payout. (State insurance commissioners under McCarran-Ferguson 15 U.S.C. §1011.)

15. **Snapshot-based distribution** — Phase-2 Reflections Router distributes based on ON-CHAIN BALANCE at snapshot block. NOT a maintained ledger of securityholder identities. (Avoids transfer-agent characterization under Exchange Act §3(a)(24).)

16. **Multi-sig scope limitation** — Multi-sig ONLY ratifies deterministic oracle output for slashing. Multi-sig does NOT initiate slashing, does NOT exercise discretionary judgment. (Avoids control-person liability under Securities Act §15 / Exchange Act §20.)

### §2.3 On-chain Constraints (from AO-2 On-chain judge)

17. **V6 LaunchFactory produces ERC-20, NOT ERC-721** — DO NOT use ERC-721 for the agent token. Agent launches as ERC-20 via V6 /create flow. ERC-6551 token-bound accounts are deferred to Phase 3 (with LayerZero ONFT cross-chain bridge).

18. **V6 LaunchFactory is NOT source-verified on Blockscout** — Use `vibe-vibe-create-abi` selector recovery package (24/86 decoded selectors as TypeScript discriminated unions + `launchTokenRaw(calldata: Hex)` for unverifiable selector `0x24e615b3`).

19. **WebSocket does NOT exist on Robinhood Chain Testnet** — `wss://rpc.testnet.chain.robinhood.com` returns 400. Use HTTP polling at 5s interval. Verdicts are ADVISORY for anti-sniper window + first ~200 blocks of bonding-curve accumulation. Kernel MUST expose `verdict_block_height` for downstream freshness filtering.

20. **Bonding curve dual-support** — Handle BOTH legacy (k=1.0344e6, graduates at 0.005 ETH) and current (k=1.0344e9, graduates at 5 ETH) curves. Detect generation via launch timestamp.

21. **Anti-sniper window auto-reject** — MCP bridge MUST auto-reject MCP-proposed buys on tokens launched <20s ago (`antiSniperWindowActive` revert). Otherwise operator pays 99% tax.

### §2.4 Ecosystem Constraints (from AO-4 Robinhood judge)

22. **AgentObservatory agents are NOT Robinhood Agents** — They are provider-agnostic LLM agents that OPTIONALLY consume Robinhood Trading MCP tools via the public Streamable HTTP endpoint at `https://agent.robinhood.com/mcp/trading` (77 tools, 6 categories). Trades settle in the holder's OWN Robinhood Agentic Account.

23. **MCP bridge runs as LOCAL process on operator's machine** — NOT a hosted service. Robinhood Agentic Account connected via Robinhood OAuth in browser (NOT via EVM wallet signature). EIP-712 typed-data authorization translated to Robinhood Trading MCP tool call.

24. **Content generation happens at LLM agent layer** — NOT via Robinhood Trading MCP tools (which are capability-limited per primary-source onboarding article: CANNOT generate external content, post to social media).

25. **Position as extension of `seedify-agents-dashboard`** — The founder's own README: "Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows." DO NOT position as a pivot from "stock memes" thesis. Position as "the other half of the Venn diagram."

---

## 3. PROJECT PHASES (21-DAY MVP)

See `handoff/PHASE_BREAKDOWN.md` for the complete parallel execution plan. Summary:

- **Phase 0 (Day 1)**: Repo setup, dev environment, initial scaffolding
- **Phase 1 (Day 2-7)**: `vibe-vibe-create-sdk` + `vibe-vibe-create-abi`
- **Phase 2 (Day 5-12, parallel)**: `agent-observatory-kernel` + autoloop runner
- **Phase 3 (Day 8-15, parallel)**: `agent-observatory-studio` + Privy integration
- **Phase 4 (Day 10-14, parallel)**: `agent-observatory-mcp-bridge`
- **Phase 5 (Day 13-18)**: `agent-observatory-contracts` Solidity scaffolding (Phase-2 contracts deferred; scaffolding + Slither config only in MVP)
- **Phase 6 (Day 16-20)**: 3 demo agent-attested tokens + daily digest pipeline
- **Phase 7 (Day 19-21)**: Discord bot + GitHub repo finalization
- **Phase 8 (Post-MVP)**: Phase-2 contracts (Slashable Router, Per-Holder Commit-Reveal, Provenance Oracle with EIP-712, Reflections Router)

---

## 4. TEAM COMPOSITION

See `handoff/TEAM_COMPOSITION.md` for the complete specialized team roles. Recommended team:

1. **Tech Lead / Architect** — owns overall architecture, code reviews, multi-repo coordination
2. **Solidity Engineer** — V6 integration, Phase-2 contracts (post-audit)
3. **TypeScript/Next.js Engineer** — `vibe-vibe-create-sdk`, `agent-observatory-studio`, MCP bridge
4. **Python Engineer** — `agent-observatory-kernel` (verdict engine, autoloop runner)
5. **AI/LLM Engineer** — provider-agnostic LLM router, autoloop.yml schema, evidence synthesis
6. **DevOps/SRE** — CI/CD, hosting (Railway/Vercel/AWS), monitoring
7. **Documentation Lead** — README, technical docs, handoff docs
8. **QA/Testing Lead** — Slither+Mythril for Solidity, Jest for TypeScript, pytest for Python
9. **Legal/Compliance Reviewer** — securities-law posture, Reg S, MiCA, KYC integration
10. **Community/BD** — Discord integration, builder outreach, vibe/vibe team liaison

For solo founder with Claude Code: combine roles 1+2+3+4+5 (you); 6+7+8+9+10 (Claude Code assistance + founder review).

---

## 5. INFRASTRUCTURE ACCESS

The user has verified access to these infrastructure packages (see `infrastructure/ACCESS_PROTOCOL.md` for how to request access):

- **GitHub Education benefits package** — verified and accessible
- **NVIDIA Developer account** — verified and accessible
- **Azure for Builders** — verified and accessible
- **AWS Builder ID** — verified and accessible

Use these for: CI/CD runners (GitHub Actions free for students), GPU compute (NVIDIA for local LLM via Ollama), cloud hosting (Azure App Service or AWS Elastic Beanstalk for kernel service), monitoring (Azure Monitor or AWS CloudWatch).

---

## 6. COMMUNICATION PROTOCOL

See `handoff/COMMUNICATION_PROTOCOL.md`. Summary:

- **Persian is OK in chat** between user and coder agent (for clearer execution-flow understanding)
- **English ONLY in code and project documentation** — Persian must NOT leak into code or docs
- **All commit messages, PR titles, PR descriptions, README files, code comments, variable names, type names, file names = English**

---

## 7. ACCEPTANCE CRITERIA

See `docs/06-acceptance-criteria.md` for the complete per-phase acceptance criteria. Summary:

- All 5 repos with MIT/AGPL license split, comprehensive README, 3+ example repos under `examples/`
- 3 demo agent-attested tokens launched on testnet (NVDA-pair, ETH-pair, ANTHROPIC-pair)
- Daily "Agent Verdict of the Day" digest image auto-generated and posted to RSS feed
- Discord bot slash-command `/agent-observatory-launch` in `discord.gg/vibevibebuilders`
- Phase-2 contracts SCAFFOLDED (not deployed — deferred to post-team-audit)
- All 25 critical constraints (§2) verified

---

## 8. NEXT STEPS

1. Read `docs/01-specification-v2.md` IN FULL — especially §0 boundary statements and §2 (what changed from v1 to v2).
2. Read `docs/02-research-dossier.md` for the full context (founder's intellectual DNA, Robinhood Agents reality, regulatory landscape, competitive landscape).
3. Read `handoff/PHASE_BREAKDOWN.md` and `handoff/TEAM_COMPOSITION.md` to plan your team.
4. Set up the 5 repos with the multi-repo structure per §5.1 of the spec.
5. Start with Phase 0 (Day 1): repo setup + dev environment + initial scaffolding.
6. Iterate per the 21-day MVP plan.

If you encounter any blocker, consult the worklog at `research/WORKLOG.md` — it contains the full 4000+ line research dossier with all primary-source URLs.

**Good luck. The user has invested significant effort in the research phase; execute with care.**

