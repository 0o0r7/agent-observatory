# Round 2 Ideas — Golden Goal Candidates (post-Round-1-judge-feedback)

Task ID: 3-ideas-round2
Agent: Main Orchestrator (ideator, iterating on judge feedback)

## Synthesis of Round 1 Judge Feedback (the input to Round 2)

### The 5 judges' CORE non-negotiable requirements (must satisfy to be Golden Goal):

| Judge | Non-negotiable | Source quote |
|---|---|---|
| J1 Protocol Eng | Zero custom Solidity contracts in MVP (audit surface = 0); any custom contract must be deferred to Phase 2 post-team-audit, ~150 lines, EVM-native primitives only | "the builder would deploy unaudited Solidity on top of unaudited Solidity" |
| J2 Tokenomics | Token must have **real cash flows** (not pure speculation); anti-sybil via **slashable-stake pattern**; amplify $VIBEVIBE not compete with it; reject "reputation markets" (BitClout pattern) | "the design amplifies $VIBEVIBE rather than competing — ETH-paired guild tokens send the platform's 20% share to the native sink, which... triggers buyback + half-burn + half-to-holders" |
| J3 Strategist | **Verbatim thesis embodiment**: "stock + memes + products merged" (founder tweet 2026-10-06 16:48 UTC); must create shareable artifacts the team can quote-tweet (breaks founder's self-amplification mode); honors "finish, stick, ship" value | "the ONLY idea that is the literal embodiment of the founder's verbatim thesis" |
| J4 DevRel | Onboarding tax ≤ 7 days; ship a thin `vibe-vibe-create-sdk` npm package as cross-builder network effect; Discord burden ≤ 30 Q/mo | "ship a `vibe-vibe-create-sdk` npm package with ~10-15 thin TypeScript functions" |
| J5 Mechanism | Token must have **real underlying cash flows** (resist degenerate Nash equilibrium); **opens the closed vibe-viber flywheel** (95% NFT fees → AI-stock basket); anti-sybil via non-free gate (NOT free test ETH); seasonal reset for anti-collusion | "the only idea whose token has real underlying cash flows... structurally resists the degenerate-financialization Nash equilibrium" |

### Ideas killed in Round 1 (NOT to be revived):
- Idea 4 (Spark Scout Manifest) — extractive reputation market, 2 vetos (J2 + J5)
- Idea 5 (Agent Arena original) — custom-contract headline feature + 1-2 month onboarding tax + 2 vetos (J1 + J4); BUT the seasonal-tournament mechanic survives as a transplantable component

### Ideas kept alive for Round 2 synthesis:
- Idea 1 (StockMeme Forge) — strategic/protocol strong; mechanism weak (spam Nash equilibrium from $0 launch cost)
- Idea 3 (Guild Forge) — only idea with 0 vetos; needs slashable XP + custom-contract defer + guilds contract discovery
- Idea 6 (Ritual Composer) — easiest MVP; thinnest thesis fit; mechanism-clean (planning tool, not speculation)

### The 5 judges' concrete improvement suggestions (must integrate):

1. **J1**: Ship a "StockMeme Provenance Oracle" as Phase 2 — ~150-line immutable Solidity, ~50K gas one-time, hashes (LLM prompt + image-gen seed + IPFS CID + EIP-191 operator signature) into `bytes32 provenanceHash` at launch. Uses only `keccak256`, `address`, `uint256`, `bytes32`. Self-audits with Slither+Mythril in an afternoon.

2. **J2**: Add "guild-bond + slashable XP" — guild members lock 0.1% of supply for 30 days; locked balance = XP weight AND slashable if anti-sybil oracle flags wallet as fake-account cluster. Turns free attack into paid attack with downside.

3. **J3**: Add "Stock Meme of the Day" curation pipeline consuming founder's `rr` repo data (resolved wallets, on-chain tape, AI verdicts — worklog §I) to surface top-performing stock-meme tokens daily; auto-generate X-post-ready daily digest image. Daily cadence the team can retweet; gives Neil a daily artifact for Crypto Banter distribution.

4. **J4**: Ship `vibe-vibe-create-sdk` npm package (~10-15 thin TypeScript functions: `connectWallet()`, `prefillCreateForm(params)`, `launchToken()`, `getGuildXP(address)`, `getBondingCurveProgress(tokenAddress)`, `getReflectionOwed(holder, token)`). 2-day founder investment, drops every idea's tax by 50%+.

5. **J5**: Add seasonal tournament with Tamagotchi-style decay — 4-week seasons, top 32 by staked $SPARK enter, bottom 16 tokens auto-burned (treasury rerouted to top 16 holders), Charged vibe-viber holders vote wild-card entries. Addresses anti-sybil (stake non-free), anti-collusion (seasonal reset), long-term playability (seasons replay).

---

## Round 2 Candidate A — "VibeForge Studio" (the composite Golden Goal)

### One-line
A web studio for crafting + launching "stock meme" tokens on vibe/vibe — combines generative-AI meme creation (Idea 1), pre-launch ritual visualization (Idea 6), Charged vibe-viber anti-spam gate (J5 transplant from Agent Arena), daily curation pipeline using founder's `rr` repo (J3), zero custom-contract MVP (J1), thin `vibe-vibe-create-sdk` (J4), and seasonal showcase with Charged-holder voting (J5 seasonal mechanic).

### Why this is the Golden Goal candidate
This is the **only idea** that satisfies ALL 5 judges' non-negotiable requirements simultaneously:
- **J1**: Zero custom Solidity in MVP (uses V6 /create flow's immutable creator-configured settings only). Phase-2 adds the Provenance Oracle (~150 lines, EVM-native primitives only, self-audits in an afternoon).
- **J2**: Real cash flows: project-tax 80% split (40% treasury / 40% pair-token reflections / 20% burn). Pair-token reflections distribute trading-tax receipts back to stock-pair-token holders — actual yield from real trading activity, not speculation. When $VIBEVIBE pool activates, creators can switch pair to $VIBEVIBE → triggers native sink → buyback + burn (amplifies $VIBEVIBE).
- **J3**: Verbatim thesis embodiment — stock pair + generative-AI meme + vibe-coded product (the studio itself) = "stock + memes + products merged". Daily "Stock Meme of the Day" digest image gives the team a quotable X cadence.
- **J4**: Ship `vibe-vibe-create-sdk` as the studio's first deliverable (Day 1-2). Onboarding tax = 2-3 days total. Discord burden = 20-30 Q/mo (predictable form-filling questions).
- **J5**: Anti-sybil via Charged vibe-viber gate (launching a stock meme requires holding a Charged NFT — non-free, since acquiring a Charged vibe-viber requires XP progression on the platform's live NFT system). Real cash flows via pair-token reflections. Seasonal "Stock Meme of the Season" tournament with Charged-vibe-viber-holder wild-card votes opens the closed vibe-viber flywheel (95% NFT trading fees → AI-stock basket becomes a function of which memes the Charged holders backed).

### Architecture (every component respects J1's zero-custom-contract rule)

**Off-chain only (MVP):**
- Frontend: Next.js 16 + viem + Tailwind + shadcn/ui
- LLM: Claude 3.5 Sonnet (concept → name/ticker/tagline)
- Image gen: DALL-E 3 ($0.04/image) or self-hosted SDXL ($0 GPU amortized)
- IPFS: web3.storage or Pinata (CID pinned to token metadata URI)
- Ritual simulator: TypeScript simulation of V6 bonding curve + project-tax + graduation mechanics (J1 says: must reverse-engineer the actual bonding-curve formula, NOT guess — mitigation: founder publishes formula via `vibe-vibe-create-sdk` or we scrape from V6 LaunchFactory bytecode)
- Daily curation pipeline: cron job querying Blockscout API for top-10 stock-meme tokens by 24h volume; renders daily digest image via canvas; auto-posts to a self-hosted RSS feed that the team can retweet

**On-chain (Phase 2, post-team-audit):**
- StockMeme Provenance Oracle (~150 lines Solidity, ~50K gas one-time per launch):
  ```solidity
  function registerProvenance(
      address token,
      bytes32 promptHash,
      bytes32 imageSeedHash,
      bytes32 ipfsCidHash,
      bytes memory operatorSig  // EIP-191
  ) external {
      require(block.chainid == 46630, "Robinhood Chain Testnet only");
      bytes32 provenanceHash = keccak256(abi.encodePacked(
          token, promptHash, imageSeedHash, ipfsCidHash
      ));
      // store provenanceHash[token] = provenanceHash
      // emit ProvenanceRegistered(token, provenanceHash, msg.sender, operatorAddr)
  }
  ```
  - EVM-native primitives only (keccak256, abi.encodePacked, address, bytes32)
  - No external calls, no loops over arrays, no reentrancy surface
  - Self-audits with Slither + Mythril in an afternoon
  - Compatible with V6 LaunchFactory (called as a separate external contract, doesn't modify V6 internals)

**Anti-sybil gate (J5 transplant from Agent Arena seasonal mechanic):**
- Frontend checks: does connected wallet hold ≥1 Charged vibe-viber?
- If yes: enable Launch button
- If no: show "Get a Charged vibe-viber to launch" + link to vibevibe.fun/vibe-vibers
- This is OFF-CHAIN enforcement in MVP (no custom Solidity); becomes ON-CHAIN in Phase 2 via the Provenance Oracle requiring the operator's vibe-viber token ID in the EIP-191 signed message

**Seasonal showcase (J5 seasonal tournament mechanic):**
- 4-week "Stock Meme of the Season" tournament
- Top 32 stock-meme tokens by 30-day trading volume auto-qualify
- Charged vibe-viber holders vote 8 wild-card entries (4 per vibe-viber level tier)
- Top 3 winners get: featured placement on /builders leaderboard, retweet from @vibevibefun, inclusion in the daily digest image for 1 week
- Off-chain in MVP (uses existing /builders leaderboard data via Blockscout); Phase 2 can add an on-chain voting contract (deferred)

### MVP scope (eligibility bar from /docs/programs/eligibility)
Working demo + GitHub repo + authorship evidence:

1. `vibe-vibe-create-sdk` npm package (10-15 thin TypeScript functions, J4's spec)
2. VibeForge Studio web app: pick stock pair → describe concept → generate name/ticker/tagline/image → ritual visualization → 1-click launch via /create flow (manual review before signing)
3. Daily curation pipeline: cron job + daily digest image auto-generated
4. 3 demo stock meme tokens launched on testnet (NVDA "GPU Hoarder", OPENAI "Sam's Brain", ANTHROPIC "Dario's Constitution")
5. GitHub repo with authorship evidence (commit history, license, README)
6. Demo Discord bot slash-command `/vibeforge-launch` that pre-fills the /create flow

### Token launch params (per launch)
- Pair: chosen stock (NVDA/AAPL/SPCX/OPENAI/ANTHROPIC) or graduated vibe/vibe token
- Tax: 2% (immutable at creation per worklog §E)
- 80% project share split: 40% treasury / 40% pair-token reflections / 20% burn
- 20% platform share: native ETH → sink; when $VIBEVIBE active → 80% buyback + half-burn + half-to-VIBEVIBE holders
- Graduation airdrop: opt-in Fomo traders (0.5% supply) + $SPARK holders (0.5% supply) + Charged vibe-viber holders (1% supply)
- Opening buy: 0% (no creator atomic buy — closes J5's "creator defection advantage" Prisoner's Dilemma)

### Risks identified and mitigated

| Risk | Source | Mitigation |
|---|---|---|
| Image-gen cost ($0.04/image, spam attack) | J5 veto on Idea 1 | Charged vibe-viber gate makes launch non-free (gated by NFT XP progression) |
| Stock pairs are ERC-20 → bypass native sink → never trigger $VIBEVIBE buyback | J2 condition on Idea 1 | Phase 2: add a "switch pair to $VIBEVIBE" post-graduation tool (when $VIBEVIBE pool active). MVP can also offer "$VIBEVIBE pair" as a launch option from Day 1 once token deploys |
| V6 bonding-curve formula undocumented | J1 condition on Idea 6 | Reverse-engineer from V6 LaunchFactory bytecode (worklog §A: `0xe794217880011f9cA6961340eD5c16EC9559Fea0`); publish via `vibe-vibe-create-sdk` |
| Guilds contract address unknown | J1 condition on Idea 3 | Out of scope — VibeForge doesn't depend on Guilds contract. Phase-2 integration can use it later |
| Self-dealing via pre-bought stock tokens | J2 condition on Idea 1 | Pair-token reflections distribute tax receipts to ALL pair-token holders pro-rata, so any operator who pre-buys stock tokens to manipulate also pays tax to other holders; opening buy disabled (no atomic-buy exemption) |
| Charged vibe-viber collection not yet live (worklog §G: "Coming on mainnet") | Inherent platform risk | MVP uses off-chain wallet-balance check on the V1 soulbound collection (if already deployed on testnet) OR a "waitlist mode" until mainnet — clearly documented |
| $VIBEVIBE not yet deployed (worklog §F) | Inherent platform risk | MVP tax flows route to ETH sink + project treasury (existing V6 behavior). $VIBEVIBE amplification is Phase-2 bonus, not MVP requirement |
| Founder's `rr` repo is private/proprietary | J3 suggestion depends on `rr` data | `rr` is publicly listed on founder's GitHub (worklog §I). Use the publicly-listed API endpoint (Telegram bot + API per the repo description "Site + Telegram bot + API. Runs on $0/month") |

### Differentiation summary
- Pump.fun: no generative-AI flow + no stock pairs + no provenance + no Charged-NFT gate
- Believe: no AI flow + no stock pairs + no seasonal tournament
- Moonshot: no AI flow + no provenance
- Clanker: AI flow but no stock pairs + no Charged-NFT gate
- Raydium LaunchLab: no AI flow + no stock pairs
- Every launchpad above: no `vibe-vibe-create-sdk` (open SDK as cross-builder network effect)

---

## Round 2 Candidate B — "Guild Forge Platinum" (refined Idea 3)

### One-line
The Round-1 top pick of J2 (only idea with 0 vetos), refined with all 5 judges' conditions: guild dashboard + guild-token launch + slashable-XP guild-bond + Charged-vibe-viber XP bridge + zero-custom-contract MVP (custom Guild Reflections Router deferred to Phase 2 post-team-audit) + `vibe-vibe-create-sdk` published first.

### Why this is also a Golden Goal candidate
Guild Forge was the **only idea with 0 vetos** across the entire Round 1 panel. It satisfies:
- J1: Defer custom Guild Reflections Router to Phase 2; MVP is pure indexer + Discord bot + embeddable widget (zero Solidity)
- J2: Top pick — Guild Reflections Router extends V6 pull-based reflection system coherently; ETH-pair guild tokens trigger native sink → $VIBEVIBE buyback
- J3: Direct amplification of Neil's flagship Guilds feature (his top tweet 383 likes)
- J4: ~2 weeks onboarding tax; ~30-50 Discord Q/mo (acceptable); gets stagger-tier treatment ("founder-attention")
- J5: Vibe-viber Soulbound→Charged→AI-stock-basket is the natural XP substrate for guild progression (worklog §G); seasonal Charged-vibe-viber status can flow from guild XP

### Architecture (zero custom Solidity in MVP)

**Off-chain MVP:**
- Frontend: Next.js + shadcn/ui + Tailwind
- Discord bot: TypeScript / discord.js; `/guild register <@role>`, `/guild status`, `/guild leaderboard`
- Indexer: TypeScript polling Blockscout API for Guilds events (Guilds contract address TBD — mitigation: scrape from chain via foundational Guild Factory address, OR DM the team for the address)
- Embeddable widget: React `<iframe>` for guild websites showing guild name + XP + rank + member count
- `vibe-vibe-create-sdk` published as Day 1-2 deliverable (J4 condition)
- Guild-token launch via V6 /create flow: 3% tax, 80% project share split (50% treasury / 30% pair-token reflections / 20% project-token reflections)

**Phase-2 custom contract (deferred to post-team-audit per J1):**
- Guild Reflections Router (~250 lines Solidity): receives pair-token + project-token reflection distributions from V6, redistributes to guild members pro-rata by XP weight
- Slashable-stake pattern: guild members lock 0.1% of supply for 30 days; locked balance = XP weight; slashable if guildmaster's anti-sybil oracle flags wallet as fake-account cluster (J2 condition)
- Audit consideration: pull-based distribution only (matches V6's existing pattern), SafeERC20 everywhere, snapshot rounding for pro-rata math, reentrancy guard on claim function

### MVP scope (eligibility bar)
Working demo + GitHub repo + authorship evidence:

1. `vibe-vibe-create-sdk` npm package (10-15 thin functions, J4's spec)
2. Discord bot slash-command: `/guild register`, `/guild status`, `/guild leaderboard`
3. Web dashboard: list of all registered guilds, top 100 leaderboard, search
4. Embeddable widget
5. One demo guild token launched on testnet
6. GitHub repo + authorship evidence + Discord bot in the official `discord.gg/vibevibebuilders`

### Token launch params (per guild)
- Pair: ETH (or $VIBEVIBE once deployed)
- Tax: 3% (immutable)
- 80% project share: 50% treasury / 30% pair-token reflections / 20% project-token reflections
- 20% platform share: native ETH → sink; when $VIBEVIBE active → 80% buyback + half-burn + half-to-VIBEVIBE holders
- Graduation airdrop: opt-in Fomo traders (1% supply) + Charged vibe-viber holders (1% supply) + $SPARK holders (1% supply)
- Opening buy: 1% (demonstrates skin-in-game without dominating)

### Differentiation
- No launchpad offers third-party guild tooling
- Discord community dashboards (Statbot, MEE6) exist but aren't crypto-guild-aware
- Guild-token-as-reflection-router is a novel economic primitive (J2 says it's the strongest tokenomics of all 6 Round-1 ideas)

### Risks identified and mitigated

| Risk | Source | Mitigation |
|---|---|---|
| Guilds contract address unknown | J1 condition | DM Neil (his pinned tweet 2026-09-22 asks for GitHub links and offers to connect); or scrape from chain via foundational Guild Factory search |
| Founder's bandwidth (1 technical person) | J4 condition | Tier as "founder-attention" project; publish `vibe-vibe-create-sdk` first to reduce his direct support burden; offload Q&A to GitHub Issues on the builder repo |
| Custom Guild Reflections Router audit | J1 condition | Defer to Phase 2; MVP ships without it (token still works via V6's existing pull-based reflection system — just distributed to all holders, not guild-pro-rata) |
| XP source may be volume-based (wash-trading becomes dominant strategy) | J5 condition | Verify XP source BEFORE shipping Phase 2; if volume-based, gate reflection distribution on Charged vibe-viber status (non-volume signal) instead |

---

## Side-by-side comparison: A vs B

| Criterion | A: VibeForge Studio | B: Guild Forge Platinum |
|---|---|---|
| Founder thesis fit ("stock+memes+products merged") | ★★★★★ (literal) | ★★★ (social application only) |
| Token real cash flows | ★★★★ (pair-token reflections) | ★★★★★ (router extends V6 cleanly — J2's top reason) |
| Anti-sybil elegance | ★★★★ (Charged NFT gate) | ★★★★★ (slashable stake — J2's preferred pattern) |
| Zero custom contracts in MVP | ★★★★★ (true) | ★★★★★ (true) |
| Phase-2 custom contract complexity | ~150 lines (Provenance Oracle) | ~250 lines (Reflections Router) |
| Onboarding tax | 2-3 days | 2 weeks |
| Discord burden | 20-30 Q/mo | 30-50 Q/mo |
| Cross-builder network effect | Medium (SDK + daily digest as cross-idea leverage) | High (SDK + Discord bot infrastructure reusable) |
| Daily social artifact for team amplification | ★★★★★ (daily digest image) | ★★★ (weekly guild leaderboard) |
| Amplifies $VIBEVIBE | ★★★ (Phase-2 pair switch to $VIBEVIBE) | ★★★★★ (ETH pair → native sink → $VIBEVIBE buyback from Day 1) |
| Opens closed vibe-viber flywheel | ★★★★★ (seasonal Charged-holder voting) | ★★★★ (guild XP → Charged status bridge) |
| Anti-financialization | ★★★★ (real pair-token reflections + provenance) | ★★★★★ (slashable stake + non-volume XP) |
| Round-1 verdict history | 2 top picks (J1 + J3), 1 veto (J5) | 1 top pick (J2), 0 vetos |

**Recommendation**: A and B are BOTH viable Golden Goal candidates. A wins on thesis embodiment + shareability + cross-idea leverage. B wins on tokenomics coherence + round-1 consensus + anti-financialization.

