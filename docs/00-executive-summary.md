# AgentObservatory v2 — Executive Summary

**Version**: 2.0 (post-5-judge-evaluation synthesis)
**Status**: GOLDEN GOAL CANDIDATE (pending final judge panel approval)
**Last updated**: 2026-10-10

---

## What is AgentObservatory v2?

A **tokenized agent-observatory on vibe/vibe** — a layer where AI agents discover, qualify, and surface the best stock-pair products launched on vibe/vibe (Robinhood Chain Testnet, Arbitrum Orbit L2, chain ID 46630).

Each agent is launched as an **ERC-20 token** via vibe/vibe's V6 LaunchFactory `/create` flow. Holders submit their own verdicts via commit-reveal; reflections are distributed based on the HOLDER's OWN prediction accuracy (Numerai-pattern real-stakes — yield from research quality, NOT from tax redistribution by an operator).

**Tagline**: "The other half of the Venn diagram."

- Stock memes is one half (memetic creativity + stock pairs + products)
- AgentObservatory is the other half (autonomous research agents that surface the best stock-pair products)

---

## Why This Project?

The founder of vibe/vibe (Levent Cem Aydan, @meta_alchemist) articulated the following thesis (October 6, 2026):

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

---

## Founder's Intellectual Pattern Match

The founder's GitHub (`vibeforge1111`, 31K+ contributions/year, 56 public repos) demonstrates consistent architectural taste:

- Multi-repo microservices with formal authority contracts (Governor + ledger + lifecycle + evolution)
- AGPL kernel + MIT adapters license split
- Provider-agnostic LLM routing (Claude / Codex / Z.AI / MiniMax / HuggingFace / Ollama)
- File-first inspectable state (`artifacts/`)
- Proposal-first self-edit with operator gates
- Fail-closed verification
- Evidence over prose

AgentObservatory v2 extends this pattern — specifically extending the founder's own `seedify-agents-dashboard` README: *"Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows"*.

---

## How It Works (Plain Language)

1. **Operator creates an AI agent** using Claude Code, Codex, or similar AI coding tools
2. **Agent is launched as an ERC-20 token** on vibe/vibe via the V6 LaunchFactory `/create` flow (paired with ETH or a Robinhood Stock Token like NVDA)
3. **Agent subscribes to V6 LaunchFactory events** via HTTP polling (every 5 seconds)
4. **For each new launch detected**, the agent:
   - Fetches launch parameters (pair, tax, opening buy, allocations)
   - Fetches creator wallet history
   - Calls an LLM (provider-agnostic — Claude, Codex, Z.AI, MiniMax, HuggingFace, or Ollama)
   - Generates a verdict: graduate or fail (with confidence score, evidence citations)
   - Persists to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}`
5. **Holders of the agent token submit their own verdicts** via commit-reveal (hash-committed before graduation, revealed after)
6. **After graduation**, holders who revealed correct verdicts receive reflections pro-rata by their accuracy (Numerai-pattern real-stakes)
7. **Operators lock 0.1% of supply for 30 days**; slashable if their 30-day accuracy < 0.40 (Brier score)
8. **Optional**: agent can place paper trades or live trades via Robinhood Trading MCP (operator-in-control — agent PROPOSES, operator SIGNS via their own wallet)

---

## Key Differentiators

| Criterion | Pump.fun | Flap | Virtuals | Clanker | Robinhood Agent Apps | **AgentObservatory v2** |
|---|---|---|---|---|---|---|
| Robinhood Chain | ❌ (Solana) | ✅ | ❌ (Base) | ❌ (Base) | ✅ (in-app) | ✅ |
| Stock pair integration | ❌ | ✅ | ❌ | ❌ | ✅ (data only) | ✅ (full) |
| AI agent layer | ❌ | ❌ | ✅ (agent-as-asset) | ❌ | ✅ (in-app) | ✅ (agent-as-observer) |
| Tokenized | ❌ | ✅ | ✅ | ✅ | ❌ (custodial) | ✅ (ERC-20 via V6) |
| Robinhood Trading MCP integration | ❌ | ❌ | ❌ | ❌ | ✅ (proprietary) | ✅ (open bridge) |
| Numerai-pattern real-stakes (per-holder commit-reveal + slash for inaccuracy) | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Three-pillar merge (stock + meme + product) | ❌ | partial | partial | ❌ | partial | ✅ (full) |
| Founder's intellectual pattern match | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (extends seedify-agents-dashboard) |
| Open-source SDK | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (multi-repo AGPL+MIT) |
| Securities-law compliance posture | ❌ | partial | partial | ❌ | ❌ | ✅ (§0.2 7 assertions) |

---

## Architecture (Multi-Repo)

| Repo | Language | License | Purpose |
|---|---|---|---|
| `agent-observatory-kernel` | Python | AGPL-3.0 | Verdict engine + autoloop runner |
| `agent-observatory-contracts` | Solidity | MIT | Phase-2 contracts (post-team-audit) |
| `agent-observatory-studio` | TypeScript / Next.js | MIT | Web UI + Privy wallet |
| `agent-observatory-mcp-bridge` | TypeScript | MIT | Robinhood Trading MCP bridge (optional, local) |
| `vibe-vibe-create-sdk` | TypeScript | MIT | SDK for vibe/vibe V6 LaunchFactory |

---

## Roadmap (21-Day MVP)

| Day | Deliverable |
|---|---|
| 1-2 | `vibe-vibe-create-sdk` npm package (15+ functions + BuildLog event indexer + `vibe-vibe-create-abi` selector recovery) |
| 3-5 | `agent-observatory-studio` web app (Next.js + Privy + viem + provider-agnostic LLM router) |
| 6-9 | `agent-observatory-kernel` Python service (subscribes to V6 events via HTTP polling, generates verdicts, persists to `artifacts/`) |
| 10-12 | `agent-observatory-contracts` Solidity scaffolding (Phase-2 contracts deferred; scaffolding + Slither config only in MVP) |
| 13-15 | `agent-observatory-mcp-bridge` TypeScript MCP server (optional, paper-trade + operator-controlled) |
| 16-17 | 3 demo agent-attested tokens launched on testnet (NVDA-pair "Stock-Meme Sniffer", ETH-pair "Graduation Radar", ANTHROPIC-pair "AI-Stock Trend Spotter") |
| 18-19 | Daily "Agent Verdict of the Day" digest image generator |
| 20 | GitHub repo with comprehensive README + MIT/AGPL license + 3 example repos under `examples/` |
| 21 | Discord bot slash-command `/agent-observatory-launch` in `discord.gg/vibevibebuilders` |

---

## Read More

- **Full specification**: `docs/01-specification-v2.md`
- **Research dossier**: `docs/02-research-dossier.md`
- **Handoff for coder agent**: `handoff/AGENT_INSTRUCTIONS.md`

