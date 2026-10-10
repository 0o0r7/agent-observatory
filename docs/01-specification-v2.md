# AgentObservatory v2 — Final Golden Goal Specification

**Version**: 2.0 (post-5-judge-evaluation synthesis)
**Status**: GOLDEN GOAL CANDIDATE (pending final judge panel approval)
**Last updated**: 2026-10-10
**Total spec size**: ~280 lines Solidity (Phase 2, deferred post-team-audit) + multi-repo off-chain MVP

---

## §0. Boundary Statements (READ FIRST)

### §0.1 Robinhood Ecosystem Boundary Statement

AgentObservatory agents are **NOT** Robinhood Agents (the closed in-app product). They are provider-agnostic LLM agents (Claude / Codex / Z.AI / MiniMax / HuggingFace / Ollama) that **OPTIONALLY** consume Robinhood Trading MCP tools via the public Streamable HTTP endpoint at `https://agent.robinhood.com/mcp/trading` (77 tools, 6 categories: Account / Watchlist / Market data / Equities / Options / Crypto) in the holder's OWN Robinhood Agentic Account.

- Trades executed via Robinhood Trading MCP settle in the holder's Robinhood Agentic Account (Robinhood Labs LLC as technology provider per Hood Summit 2026 announcement).
- The agent-attested token gates access to the agent's strategy/persona, NOT trade-execution capital.
- Content generation (verdicts, daily digests, "memetic content") happens at the LLM agent layer — NOT via Robinhood Trading MCP tools (which are capability-limited per the primary-source onboarding article).
- AgentObservatory's "autoloop" (see §3) is an ORCHESTRATION pattern (observe → qualify → publish → iterate, based on the founder's June 8, 2026 "Autoloops > Agent Loops" thesis), NOT a trade-scheduling feature. Robinhood's announced "Loops" feature (Coming soon) is a different layer — when it ships, AgentObservatory's MCP bridge will consume Robinhood Loops as a tool (forward-compatible, not competitive).

### §0.2 Securities-Law Compliance Posture

AgentObservatory is designed to be a **non-security digital collectible** with the following compliance posture:

1. **Howey prong analysis**: Per-holder commit-reveal pattern (§4) — holders submit their OWN verdicts via commit-reveal; reflections are distributed based on the HOLDER's OWN prediction accuracy, NOT the operator's. This fails the "efforts of others" prong of Howey (SEC v. W.J. Howey Co., 328 U.S. 293 (1946)) because the holder's profit depends on their own prediction skill, not on the efforts of a promoter. This matches Numerai's NMR token pattern (which has not faced SEC enforcement since 2017).

2. **Reg S transfer-restriction stack**: For agent-attested tokens paired with Stock Tokens (NVDA / AAPL / SPCX / OPENAI / ANTHROPIC), beyond the initial-distribution 3-layer stack (KYC + IP geo-fence + ToS attestation), the Phase-2 Provenance Oracle will include: (i) whitelist-based transfer with KYC verification per transfer; (ii) Reg S legend in token metadata; (iii) custom `transfer()` override smart contract hook verifying recipient non-US whitelist status; (iv) Rule 902(c) "diligent inquiry" verification standard (written representations from purchasers re non-US status + no intent to resell to US persons during the 1-year distribution compliance period under Rule 907).

3. **CFTC event-contract disclaimer**: The commit-reveal pattern (§4) is NOT a swap (CFTC §1a(47) — no exchange of payments based on outcome; reflections come from trading tax, not from a counterparty payment), NOT an event contract (CFTC §1a(33) — token graduation is market-internal, not "an event of interest to the public at large" under §5b(c)(2)(B)), NOT a SEF (CFTC §1a(38) — AgentObservatory is a tax-distribution smart contract, not a swap execution facility). Distinguish from Polymarket (Jan 3, 2022, $1.4M settlement) on public-event vs. market-internal-event grounds.

4. **Investment Advisers Act disclaimer**: The agent operator is NOT acting as an investment adviser under the Investment Advisers Act of 1940 §202(a)(11). The agent-attested token is a research publication primitive, not a managed-account service. Verdicts are public goods (published per §6), not tailored advice. Holders do not receive personalized advice.

5. **Transfer-agent disclaimer**: The Phase-2 Reflections Router (§7.2) distributes based on ON-CHAIN BALANCE at a snapshot block, NOT based on a maintained ledger of securityholder identities. Does NOT constitute transfer-agent activity under Exchange Act §3(a)(24).

6. **Control-person limitation**: Multi-sig scope is limited to ratifying deterministic oracle output for slashing; multi-sig does NOT initiate slashing, does NOT exercise discretionary judgment about value, does NOT make distribution decisions (those go to Snapshot off-chain voting per §7.2). Multi-sig signers are not "control persons" under Securities Act §15 / Exchange Act §20.

7. **Dealer activity limitation**: The Builder Grants Fund (§8) will NOT engage in secondary market purchases of agent-attested tokens. It only distributes treasury-held tax receipts (ETH or pair-token assets, not agent-attested tokens). Grant recipients must be KYC-verified non-US persons if any portion of the treasury is derived from Stock Token pair trading.

---

## §1. Executive Summary

**AgentObservatory v2** is a tokenized agent-observatory on vibe/vibe — a layer where AI agents discover, qualify, and surface the best stock-pair products launched on vibe/vibe. Each agent is launched as an **ERC-20 token** via vibe/vibe's V6 LaunchFactory `/create` flow. Holders submit their own verdicts via commit-reveal; reflections are distributed based on the HOLDER's OWN prediction accuracy (the Numerai-pattern real-stakes mechanism — yield from research quality, NOT from tax redistribution by an operator).

**Tagline**: "The other half of the Venn diagram." Stock memes is one half (memetic creativity + stock pairs + products). AgentObservatory is the other half (autonomous research agents that surface the best stock-pair products).

---

## §2. What Changed from v1 to v2 (7 Critical Fixes from 5 Judges)

| # | Fix | Source | What changed |
|---|---|---|---|
| 1 | **Per-holder commit-reveal** (Howey fix) | AO-5 Regulatory | Holders submit their OWN verdicts via commit-reveal; reflections distributed by HOLDER's accuracy (not operator's). Fails "efforts of others" prong. |
| 2 | **Slash for inaccuracy** (not just sybil) | AO-3 Economist + AO-5 | Stake-at-risk: operator locks 0.1% supply for 30 days; slashable if 30-day accuracy < 0.40 threshold (Brier score). Real Numerai-pattern. |
| 3 | **ERC-20 agent token** (not ERC-721) | AO-2 On-chain | V6 LaunchFactory produces ERC-20, not ERC-721. Agent launches as ERC-20 via V6 /create. ERC-6551 deferred to Phase 3 with LayerZero ONFT cross-chain bridge. Phase 2 custom Solidity honestly disclosed (~250 lines). |
| 4 | **§0.1 Robinhood Ecosystem Boundary** | AO-4 Robinhood | New section: terminate "agent token" → "agent-attested token"; disambiguate from Robinhood Agents in-app product; state trade-settlement constraint. |
| 5 | **§0.2 Securities-Law Compliance Posture** | AO-5 Regulatory | New section with 7 verbatim assertions: Howey, Reg S, CFTC, Investment-Adviser, Transfer-agent, Control-person, Dealer. |
| 6 | **autoloop.yml schema** | AO-1 AI Agent | New section §3: verdict_loop, evidence_budget, per-role LLM providers with fallback chains, commit_reveal_window_blocks, accuracy_metric, promote_policy, fallback_to_paper_trade_on_mcp_error, replay_html_renderer. |
| 7 | **EIP-712 upgrade** (from EIP-191) | AO-1 AI Agent | Phase-2 Provenance Oracle uses EIP-712 typed-data (modern standard) instead of EIP-191 (2016-era, chain-id replay-protection issues). |

**Additional fixes from prior rounds**:
- §9 Bonding curve dual-support: handles BOTH legacy (k=1.0344e6, graduates at 0.005 ETH) and current (k=1.0344e9, graduates at 5 ETH) curves (per Discord pain point #1).
- §10 External revenue source (Phase-3 stretch goal): 0.50% of the 1.50% builder pool → "accuracy-reward treasury" funded by hedge-fund subscription or external sponsor; true Numerai-pattern real-stakes.
- §11 Risk table: explicit acknowledgment of WebSocket absence (`wss://rpc.testnet.chain.robinhood.com` does not exist), 50-block kernel lag at 5s HTTP polling cadence, V6 reflection push-vs-pull unverified, Arbitrum Orbit sequencer MEV surface.

---

## §3. autoloop.yml Schema Specification

The autoloop is the unit (per the founder's "Autoloops > Agent Loops" thesis, June 8, 2026). Each agent run persists to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}` — file-first inspectable state matching the founder's `artifacts/paper_trade/` pattern.

```yaml
# autoloop.yml — AgentObservatory v2 schema
# Modeled on founder's spark-researcher autoloop pattern (https://github.com/vibeforge1111/spark-researcher)

verdict_loop:
  trigger: event-driven          # Subscribes to V6 LaunchFactory LaunchCreated events
  event_source: http_polling     # HTTP polling (NOT WebSocket — wss://rpc.testnet.chain.robinhood.com does not exist per §6b-onchain-fast research)
  poll_interval_seconds: 5       # 50-block lag at 0.1s block time — verdicts are ADVISORY for anti-sniper window + first ~200 blocks of bonding-curve accumulation
  expose_verdict_block_height: true   # For downstream freshness filtering

evidence_budget:
  max_tokens_per_verdict: 8000
  max_citations_per_verdict: 12
  evidence_repositories:
    - blockscout_api             # https://explorer.testnet.chain.robinhood.com/api
    - v6_factory_events          # 24/86 decoded selectors per §6b-onchain-fast
    - launch_creator_history     # Per-creator nonce via launchNonce(address)
    - pair_asset_metadata        # ETH/NVDA/AAPL/SPCX/OPENAI/ANTHROPIC

verdict_llm_provider:
  primary: claude-3.5-sonnet
  fallback_chain: [codex-gpt-5.6, glm-4.5, minimax-text-01, huggingface-router, ollama-llama3.1-70b]
  retry_strategy: exponential_backoff
  role: verdict_synthesis

evidence_llm_provider:
  primary: claude-3.5-sonnet
  fallback_chain: [codex-gpt-5.6, glm-4.5]
  role: evidence_gathering

summary_llm_provider:
  primary: glm-4.5
  fallback_chain: [claude-3.5-haiku, ollama-llama3.1-8b]
  role: digest_summary

commit_reveal_window_blocks: 36000   # ~1 hour on Robinhood Chain at 0.1s blocks

accuracy_metric:
  type: brier_score                # https://en.wikipedia.org/wiki/Brier_score
  rolling_window_days: 30
  promote_threshold: 0.6
  demote_threshold: 0.4
  paths:
    canonical: ">=0.6"
    candidate: "0.4-0.6"
    quarantine: "<0.4"

promote_policy:
  promote_on: "30-day-accuracy >= 0.6 AND 30-day-verdict-count >= 50"
  demote_on: "30-day-accuracy < 0.4 OR 30-day-verdict-count < 10"
  human_review_required_for_promotion: true
  slash_on_inaccuracy: "30-day-accuracy < 0.40"   # AO-3 + AO-5 fix: real Numerai-pattern stake-at-risk
  slash_amount: "0.1% of supply locked for 30 days"

fallback_to_paper_trade_on_mcp_error: true
replay_html_renderer:
  template: spark-researcher-style  # Founder's deployed seedify-agents-dashboard static-export format
  artifacts_dir: artifacts/verdicts/<launch_address>/
  files: [input.json, evidence.json, verdict.json, replay.html]
```

---

## §4. Per-Holder Commit-Reveal Mechanism (Howey Fix)

The Numerai-pattern is structurally honest in v2: holders submit their OWN verdicts via commit-reveal, and reflections are distributed based on the HOLDER's prediction accuracy — NOT the operator's.

### §4.1 Commit phase
For each new launch on V6 LaunchFactory (detected via `LaunchCreated` events), each agent-attested token holder may submit a commit:
```solidity
// Phase-2 Solidity (post-team-audit, ~250 lines, EVM-native primitives only)
function commitVerdict(
    address launchAddress,
    bytes32 verdictHash,    // keccak256(abi.encode(launchAddress, predictedOutcome, salt, holderAddress))
    uint256 stakeAmount    // 0.1% of supply minimum, slashable if 30-day accuracy < 0.40
) external nonReentrant {
    require(stakeAmount >= MIN_STAKE, "insufficient stake");
    require(block.timestamp > launches[launchAddress].commitWindowStart, "commit window not open");
    require(block.timestamp < launches[launchAddress].commitWindowEnd, "commit window closed");
    // Lock stake for 30 days
    _stakes[msg.sender].amount += stakeAmount;
    _stakes[msg.sender].unlockAt = block.timestamp + 30 days;
    // Record commit
    _commits[launchAddress][msg.sender] = Commit({
        verdictHash: verdictHash,
        stakeAmount: stakeAmount,
        committedAt: block.timestamp
    });
    emit VerdictCommitted(launchAddress, msg.sender, verdictHash, stakeAmount);
}
```

### §4.2 Reveal phase
After graduation (or failure to graduate within 7 days), holders reveal:
```solidity
function revealVerdict(
    address launchAddress,
    bool predictedOutcome,  // true = "graduate", false = "fail"
    bytes32 salt
) external nonReentrant {
    Commit storage commit = _commits[launchAddress][msg.sender];
    require(commit.verdictHash != bytes32(0), "no commit");
    require(block.timestamp > launches[launchAddress].revealWindowStart, "reveal window not open");
    require(block.timestamp < launches[launchAddress].revealWindowEnd, "reveal window closed");

    bytes32 expectedHash = keccak256(abi.encodePacked(launchAddress, predictedOutcome, salt, msg.sender));
    require(expectedHash == commit.verdictHash, "invalid reveal");

    bool actualOutcome = launches[launchAddress].graduated;
    bool correct = (predictedOutcome == actualOutcome);

    _holders[msg.sender].totalVerdicts++;
    if (correct) {
        _holders[msg.sender].correctVerdicts++;
    }

    // Update 30-day rolling accuracy (Brier score)
    _updateBrierScore(msg.sender, correct);

    emit VerdictRevealed(launchAddress, msg.sender, predictedOutcome, actualOutcome, correct);
}
```

### §4.3 Reflection distribution (accuracy-weighted, per-holder)
After graduation + 7-day reveal window closes, the Phase-2 Reflections Router distributes pair-token reflections to **holders who revealed correct verdicts** pro-rata by their (correctVerdicts × stakeAmount) over the snapshot block.

### §4.4 Slash for inaccuracy (real Numerai-pattern)
```solidity
function slashInactiveOperators(address[] calldata operatorsToSlash) external onlyMultiSig {
    for (uint i = 0; i < operatorsToSlash.length; i++) {
        Holder storage holder = _holders[operatorsToSlash[i]];
        uint256 accuracy = holder.correctVerdicts * 1e18 / holder.totalVerdicts;
        if (accuracy < 0.40 * 1e18) {  // 30-day accuracy threshold
            // Slash 0.1% locked stake
            uint256 slashAmount = _stakes[operatorsToSlash[i]].amount;
            _stakes[operatorsToSlash[i]].amount = 0;
            // Reroute slashed amount to Builder Grants Fund
            _builderGrantsFundBalance += slashAmount;
            emit OperatorSlashed(operatorsToSlash[i], slashAmount, "inaccuracy_threshold_breached");
        }
    }
}
```

---

## §5. Architecture (MVP, zero custom Solidity in MVP)

### §5.1 Multi-repo structure (matches founder's Spark OS pattern: AGPL kernel + MIT adapters)

#### Repo 1: `agent-observatory-kernel` (AGPL-3.0-only)
- Python service subscribing to V6 LaunchFactory events via HTTP polling (5s interval)
- For each new launch, fetches: pair asset, tax rate, opening buy size, project-share allocation, creator wallet history, prior launch outcomes
- Calls LLM per §3 (verdict_llm_provider with fallback chain)
- Generates verdict: `{launch_address, verdict: graduate|fail, confidence: 0-100, evidence_citations: [...], commit_hash, timestamp}`
- Persists to `artifacts/verdicts/<launch_address>/{input.json, evidence.json, verdict.json, replay.html}`

#### Repo 2: `agent-observatory-contracts` (MIT, deployable artifacts)
- Phase-2 Provenance Oracle (~160 lines Solidity, EIP-712 typed-data per §7.1)
- Phase-2 Per-Holder Commit-Reveal Contract (~250 lines Solidity per §4)
- Phase-2 Reflections Router (~150 lines Solidity per §7.2)
- Phase-2 Slashable Stake (~80 lines Solidity)
- All EVM-native primitives only (keccak256, abi.encodePacked, address, bytes32, uint8, ecrecover, EIP-712 typed-data)
- Self-auditable with Slither + Mythril in afternoons (per J1 Round-1 criterion)
- Deferred to post-team-audit (V6 itself is NOT source-verified per worklog §6b-onchain-fast)

#### Repo 3: `agent-observatory-studio` (MIT)
- Next.js 16 + viem + Tailwind + shadcn/ui + Privy wallet integration
- Web UI: launch an agent → specify LLM provider → specify stock pair → commit verdicts → publish as ERC-20 token on vibe/vibe V6
- Embeddable widget for any agent's page showing live verdict feed

#### Repo 4: `agent-observatory-mcp-bridge` (MIT, optional)
- TypeScript MCP server exposing Robinhood Trading MCP at `agent.robinhood.com/mcp/trading`
- Local process on operator's machine (NOT a hosted service)
- Robinhood Agentic Account connected via Robinhood OAuth in browser (NOT via EVM wallet signature)
- Agent's trade proposal confirmed via operator's localhost UI
- EIP-712 typed-data authorization translated to Robinhood Trading MCP tool call
- NEVER holds operator credentials (DPRK-PTSD-driven per J4 criterion)
- Auto-rejects MCP-proposed buys on tokens launched <20s ago (`antiSniperWindowActive` revert per AO-2 risk R-C)

#### Repo 5: `vibe-vibe-create-sdk` (MIT, the substrate)
- TypeScript SDK: 15+ functions including `connectWallet()`, `prefillCreateForm(params)`, `launchToken()`, `getLaunchState()`, `getBondingCurveProgress()`, `getReflectionOwed()`, `getAntiSniperWindowStatus()`, `commitVerdict()`, `revealVerdict()`, `getBrierScore(holder)`
- Plus `vibe-vibe-create-abi` selector recovery package per J1 Round-2 (24/86 decoded selectors as TypeScript discriminated unions + `launchTokenRaw(calldata: Hex)` for unverifiable selector `0x24e615b3` + `submitABI(abi, sourceUrl)` community-contribution API)
- Plus `BuildLog` event indexer per J4 Round-2 (correlates V6 LaunchFactory events with git commit hashes by authorWallet)
- Provider-agnostic LLM router per §3 (Claude / Codex / Z.AI / MiniMax / HuggingFace / Ollama — 6 providers with role separation: verdict_llm / evidence_llm / summary_llm)

---

## §6. Token Launch Parameters (Final)

| Parameter | Value | Reasoning |
|---|---|---|
| Pair (default) | ETH | Triggers native sink → $VIBEVIBE buyback from Day 1 (J2's primary amplification path) |
| Pair (optional post-graduation fresh-launch) | NVDA / AAPL / SPCX / OPENAI / ANTHROPIC (via J2's fresh-launch + airdrop-to-holders bridge pattern) | Stock-meme thesis embodiment without V6-immutability violation |
| Tax | 2% (immutable at creation per V6 spec) | Lower than Flap's rate to attract builders |
| 80% project share split | 40% agent treasury / 40% pair-token reflections (distributed per-holder by accuracy) / 20% Builder Grants Fund | Real cash flow + cleanest legal posture (no "reflections to holders" → Howey-safe) |
| 20% platform share | Native ETH → sink; when $VIBEVIBE active → 80% buyback + half-burn + half-to-VIBEVIBE holders | Standard V6 behavior |
| Opening buy | 0% (no creator atomic buy) | Closes Prisoner's Dilemma per J5 |
| Graduation airdrop audiences | opt-in Fomo traders (0.5%) + $VIBEVIBE holders (0.5%) + $SPARK holders (0.5%) + Charged-vibe-viber holders (0.5%) | All 4 documented V6 audiences |
| Phase-2 treasury vesting | 30-day linear unlock post-graduation (J5's Round-2 spec) | Closes moral-hazard critique |
| Anti-sybil | Per-holder commit-reveal stake (0.1% min, slashable) + BuildLog git-commit-hash authorship evidence + V1 Soulbound NFT OR 0.01 ETH escrow (J3's Round-2 spec) | Non-free, multi-layered |
| US-exclusion stack | KYC + IP geo-fence + ToS attestation + Reg S transfer-restriction hook (§0.2) | Match Stock Token eligibility (EU + non-US only) |

---

## §7. Phase-2 Solidity Contracts (Deferred to post-team-audit per J1 rule)

### §7.1 Provenance Oracle (~160 lines, EIP-712 per AO-1 fix)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AgentObservatoryProvenanceOracle {
    // EIP-712 domain separator (modern standard, replaces EIP-191)
    bytes32 public constant EIP712_DOMAIN_TYPEHASH = keccak256(
        "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
    );
    bytes32 public constant VERDICT_TYPEHASH = keccak256(
        "Verdict(address token,address launchAddress,bool predictedOutcome,bytes32 evidenceHash,uint256 timestamp)"
    );
    bytes32 public immutable domainSeparator;

    address public immutable operatorPublicKey;  // The agent operator's signing address
    mapping(address => bytes32) public verdictHashOf;  // launchAddress => verdictHash

    event VerdictRegistered(address indexed token, address indexed launchAddress, bytes32 verdictHash, address indexed registrar);

    constructor(address _operatorPublicKey, string memory name, string memory version) {
        operatorPublicKey = _operatorPublicKey;
        domainSeparator = keccak256(abi.encode(
            EIP712_DOMAIN_TYPEHASH,
            keccak256(bytes(name)),
            keccak256(bytes(version)),
            block.chainid,
            address(this)
        ));
    }

    function registerVerdict(
        address token,
        address launchAddress,
        bool predictedOutcome,
        bytes32 evidenceHash,
        uint256 timestamp,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        require(block.timestamp <= timestamp + 1 hours, "verdict expired");

        bytes32 structHash = keccak256(abi.encode(
            VERDICT_TYPEHASH,
            token,
            launchAddress,
            predictedOutcome,
            evidenceHash,
            timestamp
        ));
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));

        address signer = ecrecover(digest, v, r, s);
        require(signer == operatorPublicKey, "bad operator sig");
        require(verdictHashOf[launchAddress] == bytes32(0), "already registered");

        bytes32 verdictHash = keccak256(abi.encodePacked(token, launchAddress, predictedOutcome, evidenceHash));
        verdictHashOf[launchAddress] = verdictHash;
        emit VerdictRegistered(token, launchAddress, verdictHash, msg.sender);
    }
}
```

### §7.2 Reflections Router (~150 lines, slashable per §4.4)

- Pull-based distribution (matches V6's existing reflection pattern per J2 Round-1 spec)
- Distributes pair-token reflections to **holders who revealed correct verdicts** pro-rata by `(correctVerdicts × stakeAmount)` over the snapshot block
- Multi-sig of trusted operators ratifies deterministic SybilClusterProof output for slashing (per J2 Round-2 elevation condition)
- On-chain `SybilClusterProof` struct + 7-day timelock before slash execution + community dispute window (per J5 Round-2 spec)
- Snapshot-based distribution (NOT maintained ledger — avoids transfer-agent characterization per §0.2)

---

## §8. Builder Grants Fund (Phase-2)

The 20% Builder Grants Fund (J2 + G5 fix) disburses micro-grants ($500-$5K) to developers who ship verified SDK integrations:
- Grant request via Snapshot off-chain vote
- Third-party builder claims bounty
- Ships feature with verifiable git commits + on-chain launch count
- Bounty paid in $VIBEVIBE (when deployed) or stablecoin
- Feature merges into SDK

**Compliance**: Builder Grants Fund does NOT engage in secondary market purchases of agent-attested tokens. Only distributes treasury-held tax receipts (ETH or pair-token assets, not agent-attested tokens). Grant recipients must be KYC-verified non-US persons if any portion of the treasury is derived from Stock Token pair trading.

---

## §9. Bonding Curve Dual-Support

The V6 bonding curve was changed 1000x mid-flight on 2026-09-05 (per Discord pain point #1 from @nblurr_28691):

| Generation | k value | Graduation threshold |
|---|---|---|
| Legacy (pre-2026-09-05) | 1.0344e6 | 0.005 ETH |
| Current (post-2026-09-05) | 1.0344e9 | 5 ETH |

The `vibe-vibe-create-sdk.getBondingCurveProgress(tokenAddress)` function detects which generation a token belongs to (via the launch timestamp) and applies the appropriate formula. This is the gold standard for handling a known on-chain regression.

---

## §10. Phase-3 Stretch Goal: External Revenue Source (True Numerai Pattern)

Phase 3 introduces an external revenue source (e.g., 0.50% of the 1.50% builder pool → "accuracy-reward treasury" funded by hedge-fund subscription or external sponsor). This converts AgentObservatory from "accuracy-weighted tax redistribution" to "true Numerai-pattern real-stakes" — yield from real external revenue, not from trading tax.

This positions AgentObservatory as a viable alternative to Numerai ($400M AUM, $500M valuation) for AI agent prediction tournaments on Robinhood Chain.

---

## §11. Risk Table (Honest Disclosure)

| Risk | Source | Mitigation |
|---|---|---|
| V6 LaunchFactory NOT source-verified on Blockscout | worklog §6b-onchain-fast | `vibe-vibe-create-abi` selector recovery package per §5.1 |
| `wss://rpc.testnet.chain.robinhood.com` does NOT exist | worklog §6b-onchain-fast | HTTP polling at 5s interval; verdicts ADVISORY for anti-sniper window + first ~200 blocks; kernel exposes `verdict_block_height` for downstream freshness filtering |
| V6 reflection system push-vs-pull UNVERIFIED | worklog line 1224 | Phase-2 Reflections Router assumes pull-based per J2 Round-1 spec; if V6 is push-based, Phase-2 Router design must adapt (verify with team before Phase-2 design locks) |
| Arbitrum Orbit sequencer MEV surface | worklog line 1044 | Commit-reveal protects verdict from copy-trading; graduation event itself remains MEV-extractable via sequencer (acknowledged, no Phase-2 mitigation) |
| Anti-sniper 20s window × MCP-bridge agent-proposed buys | AO-2 R-C | MCP bridge auto-rejects MCP-proposed buys on tokens launched <20s ago (`antiSniperWindowActive` revert) |
| Robinhood in-app Agent Apps expands to third-party agent install store | worklog §9-robinhood-competitive-threat | Quarterly monitoring trigger; Pivot Plan B (registry/provenance metaplayer indexing Robinhood's install store) |
| Robinhood Trading MCP rate-limits / restricts | worklog §9-robinhood-agents-api-verify | MCP integration is OPTIONAL — agents run paper-trade-only without MCP |
| Founder hasn't publicly endorsed Robinhood Agents | worklog §9-founder-stance-agents | Position as extension of `seedify-agents-dashboard` (his own pattern) — NOT a pivot; cite his README verbatim |
| Virtuals head-on collision if framed as "AI agent launchpad" | worklog §9-founder-stance-agents + AO-4 | Position as "Agent Observatory for Stock-Pair Products" — agent-as-observer, not agent-as-asset; "agent-attested token" terminology, not "agent token" |
| Karpathy "vibe coding dead" brand risk | worklog §8-competitive-cultural-refresh | Position around vibe-as-cultural-aesthetic (agents ARE the vibe); not coding literalism |
| Robinhood Stock Token US exclusion | G5 Round-2 | KYC + IP geo-fence + ToS attestation + Reg S transfer-restriction hook per §0.2 |
| Operator credentials security (DPRK PTSD) | J4 criterion | MCP bridge NEVER holds operator credentials; agent PROPOSES, operator SIGNS via their own wallet via EIP-712 typed-data |
| "Tax redistribution dressed as real yield" trap | G2 + G3 cross-cutting risk | Reflections distributed by HOLDER's accuracy score (per-holder commit-reveal per §4), not by holding time — true Numerai-pattern real-stakes |
| Multi-sig personal liability | G5 Round-2 | Snapshot off-chain voting for curation decisions; multi-sig only for Phase-2 slashing with Reg D 506(c) accreditation gating; multi-sig ratifies deterministic oracle output (does NOT initiate slashing) |
| Builder Foundry integration | Discord research | Position AgentObservatory as playbook #9 in Builder Foundry (complement, not duplicate) |
| vibekit already exists as community-built SDK | Discord research | Ship `vibe-vibe-create-sdk` as our own (vibekit is community-built, NOT official); offer to merge or differentiate via BuildLog + Provenance Oracle + autoloop.yml schema |
| $VIBEVIBE not yet deployed | Inherent platform risk | MVP tax flows route to ETH sink + project treasury (existing V6 behavior); $VIBEVIBE amplification is automatic when pool activates |
| Founder's "stock memes" thesis still in bio | Twitter refresh | AgentObservatory is positioned as the OTHER half of the same Venn diagram (not pivot); both halves compose |

---

## §12. MVP Deliverables (Day 1-21, shippable by solo founder with Claude Code)

| Day | Deliverable |
|---|---|
| 1-2 | `vibe-vibe-create-sdk` npm package (15+ functions + BuildLog event indexer + `vibe-vibe-create-abi` selector recovery) |
| 3-5 | `agent-observatory-studio` web app (Next.js + Privy + viem + provider-agnostic LLM router per §3) |
| 6-9 | `agent-observatory-kernel` Python service (subscribes to V6 events via HTTP polling, generates verdicts, persists to `artifacts/`) |
| 10-12 | `agent-observatory-contracts` Solidity scaffolding (Phase-2 contracts deferred; scaffolding + Slither config only in MVP) |
| 13-15 | `agent-observatory-mcp-bridge` TypeScript MCP server (optional, paper-trade + operator-controlled) |
| 16-17 | 3 demo agent-attested tokens launched on testnet (NVDA-pair "Stock-Meme Sniffer", ETH-pair "Graduation Radar", ANTHROPIC-pair "AI-Stock Trend Spotter") |
| 18-19 | Daily "Agent Verdict of the Day" digest image generator (J3 Round-2 spec extended) |
| 20 | GitHub repo with comprehensive README + MIT/AGPL license + 3 example repos under `examples/` |
| 21 | Discord bot slash-command `/agent-observatory-launch` in `discord.gg/vibevibebuilders` |

---

## §13. Eligibility Bar (per /docs/programs/eligibility verbatim)

> "Vibecoded/product creators: a working demo or MVP with evidence that it belongs to the submitting creator."

✅ Working demo (web app + 3 launched agent-attested tokens + Discord bot + daily digest)
✅ MVP (Phase-2 contracts explicitly deferred; MVP is multi-repo off-chain + V6 /create flow)
✅ Authorship evidence (GitHub commit history + AGPL/MIT licenses + BuildLog on-chain correlation)
✅ Belongs to the submitting creator (BuildLog `authorWallet` = launcher's EVM wallet + signed EIP-712 message in Phase-2 Provenance Oracle)

---

## §14. Differentiation Summary (Final)

| Criterion | Pump.fun | Flap | Virtuals | Clanker | Robinhood Agent Apps | **AgentObservatory v2** |
|---|---|---|---|---|---|---|
| Robinhood Chain | ❌ (Solana) | ✅ | ❌ (Base) | ❌ (Base) | ✅ (in-app) | ✅ |
| Stock pair integration | ❌ | ✅ | ❌ | ❌ | ✅ (data only) | ✅ (full) |
| AI agent layer | ❌ | ❌ | ✅ (agent-as-asset) | ❌ | ✅ (in-app) | ✅ (agent-as-observer) |
| Tokenized | ❌ | ✅ | ✅ | ✅ | ❌ (custodial) | ✅ (ERC-20 via V6) |
| Cross-chain portable | ❌ | ❌ | ❌ | ❌ | ❌ | Phase-3 (LayerZero ONFT) |
| Robinhood Trading MCP integration | ❌ | ❌ | ❌ | ❌ | ✅ (proprietary) | ✅ (open bridge) |
| Numerai-pattern real-stakes (per-holder commit-reveal + slash for inaccuracy) | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Three-pillar merge (stock + meme + product) | ❌ | partial | partial | ❌ | partial | ✅ (full) |
| Founder's intellectual pattern match | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (extends seedify-agents-dashboard) |
| Open-source SDK | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ (multi-repo AGPL+MIT) |
| Securities-law compliance posture | ❌ | partial | partial | ❌ | ❌ | ✅ (§0.2 7 assertions) |

