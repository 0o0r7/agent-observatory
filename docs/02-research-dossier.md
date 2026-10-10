# Research Dossier — Synthesis of 10 Research Streams

**Document purpose**: Synthesis of all 10 research streams conducted during the project's research phase.

**Full primary-source research**: See `../research/WORKLOG.md` (4000+ lines) for the complete research dossier with verbatim quotes, URLs, dates, and analytical commentary.

## Research Streams (in order of execution)

### Stream 1: vibe/vibe Documentation Crawl (Round 1)
- **Method**: agent-browser navigation of SPA docs site
- **Scope**: 30 URLs crawled (21 documented pages + 1 undocumented testnet-app route `/builders`)
- **Key findings**:
  - vibe/vibe is NOT a chain — it's a permissionless launchpad DApp on Robinhood Chain Testnet (Arbitrum Orbit L2, chain ID 46630)
  - Native currency: ETH (test)
  - Post-graduation AMM: Uniswap V4 with permanently locked liquidity
  - 3 launchpad categories: Meme & Artcoins, Product & Utility, RWA & Stocks
  - Builder bar: "a working demo or MVP with evidence that it belongs to the submitting creator"
  - 5% of $VIBEVIBE supply to testnet participants (1.50% combined for product+RWA creators)

### Stream 2: GitHub Repository Analysis
- **Method**: GitHub API + HTML scraping
- **Scope**: 56 public repos on `vibeforge1111` (founder's GitHub)
- **Key findings**:
  - 31,479 contributions in last year (GitHub PRO)
  - Multi-repo Spark OS microservices (spark-cli, spark-intelligence-builder, spark-researcher, spark-character, spark-harness-core, spark-domain-chip-labs)
  - AGPL kernel + MIT adapters license pattern
  - `keep-codex-fast` (1.6K stars) — backup-first Codex skill
  - `seedify-agents-dashboard` — "Public Seedify Agent Observatory showing evidence-grounded Launchpad research, qualification, and builder-success workflows"
  - `founder-arena` — agent-vs-agent game ("Built for the age of AI agents. May the best algorithm win")
  - **`rr` is a FORK of `cvxv666/fomo-robinhood-radar`** (NOT founder's own tool)
  - **`2d-multiplayer-survival-game` is a FORK of `SeloSlav/vibe-coding-starter-pack-2d-multiplayer-survival`**

### Stream 3: Twitter/X Profile Analysis (Round 1)
- **Method**: Direct fetch of embedded `__INITIAL_DATA__` JSON + agent-browser
- **Scope**: 3 X profiles (@meta_alchemist, @neilmeintjes, @Jinz02) + @vibevibefun, @Spark_coded, @crypto_banter
- **Key findings**:
  - Founder's pin tweet: "stock + memes + products merged"
  - Founder's top engagement tweet (749 likes, 69K views): "the next meta is gonna be stock memes again"
  - Founder's 7 explicit builder requirements (October 6, 2026)
  - Neil's pinned self-intro (September 22, 2026) with builder recruitment
  - Jinz02's pinned onboarding tweet (October 4, 2026) with 4 canonical builder categories

### Stream 4: Calibration Research (post-user-rejection)
- **Method**: 3 parallel deep-research agents (founder deep dive, Twitter refresh, Discord + cultural)
- **Key findings**:
  - **DPRK hack of Seedify** (September 23, 2025): $1.2M stolen from cross-chain bridge; SFUND crashed 99.99% from $0.43 to ~zero; 64,000 holders affected
  - Founder's verbatim: *"DPRK/Lazarus decided to take everything we built over 4.5 years in one hack."*
  - **Phoenix Raise announcement** (September 24, 2025): vibe/vibe is the pre-existing roadmap permissionless launchpad product (beta-tested 1 week pre-hack) rebranded as the phoenix
  - **vibe/vibe is NOT a fresh post-hack pivot** — the launchpad was ready before the hack
  - **Karpathy's "vibe coding" tweet** (February 2, 2025) — Levent never publicly cited Karpathy

### Stream 5: Cultural + Economic Context Research
- **Method**: 7-task historical research
- **Key findings**:
  - **"Stock memes" thesis is DERIVATIVE** — Levent is ~13th articulation (after Yahoo Finance July 13, CryptoBriefing July 23, DefiPrime September 1, etc.)
  - **The ONLY novel element**: Three-pillar merge (stock pairs + products via vibe coding + memetic creativity via generative AI)
  - **Artificial Inu ($AI)**: largest stock-paired memecoin on Robinhood Chain, paired with tokenized NVDA, $112.71M market cap on October 6, 2026
  - **Web3 gaming has 80.8% annual failure rate** (BlockLeaders study of 2,817 Web3 games 2018-2023) — 4 shared failure modes
  - **Agent-vs-agent entertainment games: 0/1 success rate** (only Numerai succeeded, $400M AUM, real-stakes hedge-fund tournament)
  - **Pieter Levels**: $3M+/year from AI-assisted products; one game "$0 to $1M ARR in just 17 days"
  - **Phoenix narrative post-hack**: 80% of hacked projects NEVER fully recover (Immunefi CEO)

### Stream 6: On-chain + Bytecode Analysis (PRIMARY-SOURCE)
- **Method**: Bash + Python with web3.py + Blockscout API
- **Key findings**:
  - **V6 LaunchFactory is VERIFIED** at `0xe794217880011f9cA6961340eD5c16EC9559Fea0` (11,840 bytes bytecode)
  - **V6 source NOT verified on Blockscout** — no ABI, no Solidity source, no compiler metadata
  - **Solidity compiler**: solc 0.8.18 (from bytecode metadata tail `6f6c63430008180033`)
  - **24/86 function selectors decoded** (4byte.directory): `launchCount()`, `launchNonce(address)`, `creationFee()`, `treasury()`, `poolManager()`, `hook()` (Uniswap V4 hook!), `permit2()`, `locker()`, `tokenDeployer()`, `zap()`, `pendingOwner`, `acceptOwnership`, `renounceOwnership` (Ownable2Step), + selector `0x24e615b3` (no 4byte match — almost certainly `createLaunch(...)`)
  - **Creation fee = 0.0004 ETH** per launch (verified via decoded `creationFee()` accessor)
  - **`wss://rpc.testnet.chain.robinhood.com` DOES NOT EXIST** — Cloudflare→Envoy JSON-RPC-only proxy
  - **Robinhood Chain Testnet stats**: 301.6M+ txs, 24.6M+ addresses, 131.8M+ blocks (~4.2 years of 1s/block)

### Stream 7: Pump.fun + Robinhood Stock Token Legal Analysis (PRIMARY-SOURCE)
- **Method**: GitHub source + SEC EDGAR + Robinhood EU legal page
- **Key findings**:
  - **Pump.fun program ID**: `6EF8rrecthR5Dkzon8Nwu78hRvfCKubJ14M5uBEwF6P` (real ID — previous research had wrong ID)
  - **Pump.fun bonding curve**: Constant-product x·y=k (NOT linear) with synthetic reserves
  - **Pump.fun graduation**: Migrates to PumpSwap (pump.fun's own AMM, NOT Raydium) — LP tokens burnt
  - **Pump.fun anti-sniper**: NO dedicated anti-sniper (only flat 1% fee with 8 rotating recipients)
  - **Pump.fun tax routing**: NO custom tax (flat 1% only)
  - **Robinhood Stock Tokens = "tokenised debt securities"** issued by Robinhood Assets (Jersey) Limited
  - **SEC EDGAR CIK**: 0002142247 (Robinhood Assets Jersey)
  - **SEC Form 40-APP**: Filed 2026-07-14 (Investment Company Act of 1940 exemptive application)
  - **Investor eligibility**: NOT AVAILABLE IN US (EU retail only via Robinhood Europe UAB under MiCA)

### Stream 8: Time-Gap Refresh (October 7-10, 2026)
- **Method**: 5 parallel research agents (On-chain, Twitter, Discord, Competitive, Founder GitHub)
- **Key findings**:
  - **NEAR + Robinhood Chain integration**: REAL (early access October 7, full launch October 9)
  - **Robinhood Agents launched** (Hood Summit 2026, September 29, 2026) — 150K+ agentic accounts, 30M tool uses/day
  - **Robinhood Trading MCP** at `https://agent.robinhood.com/mcp/trading` (77 tools, 6 categories)
  - **Pump.fun Custom Pairs feature** launched October 9, 2026 — eliminates one of vibe/vibe's clearest differentiators
  - **Flap Protocol**: $39M Q3 revenue on same chain — direct competitor
  - **Karpathy declared "vibe coding" dead/outdated** — moved to "agentic engineering" (February 2026)
  - **SEC Innovation Exemption** (September 17, 2026): 5-year conditional sandbox for tokenized NMS stock

### Stream 9: Discord Deep-Dive (PRIMARY-SOURCE with user-provided token)
- **Method**: Discord API with user token (GET requests only; token rotated after use)
- **Scope**: 4,095 messages across 26 fetchable text channels (37-day window)
- **Key findings**:
  - **Builder Foundry launched October 8** — official channel for builder onboarding with 8 playbooks
  - **Robinhood Chain daily builder digest launched October 9** by LauraAM
  - **Founder went DARK after Sep 10 launch day** (25+ msgs on launch day, then quiet)
  - **110+ launches in 37 days** in #project-showcase
  - **ZERO showcases got a public team reply** — biggest amplification gap
  - **Bonding curve changed 1000x mid-flight** (September 5): legacy k=1.0344e6 (graduates at 0.005 ETH) → current k=1.0344e9 (graduates at 5 ETH)
  - **vibekit already exists** as community-built SDK (`npx vibevibekit init` on npm) by @riohaily
  - **8+ shipped builder products** with URLs (VibeGuard, Launch Intelligence, KICKER, Outlay, Plinth, Robinhood Ronin, VibeMarketFighters, vibekit)
  - **ZERO mentions of "VibeForge" or "SDK Studio"** in entire 4,095-message corpus — Blue ocean window

### Stream 10: Robinhood Agents API Verification + Founder Stance + Competitive Threat
- **Method**: 3 parallel fast verification agents
- **Key findings**:
  - **Robinhood Trading MCP is PUBLIC** (Streamable HTTP at `agent.robinhood.com/mcp/trading`, 77 tools)
  - **Robinhood in-app Agent Apps is CLOSED** (B2B-only, 11 curated data-source partners)
  - **Founder hasn't publicly endorsed Robinhood Agents** (zero attributable tweets)
  - **Founder's GitHub stars**: all 10 most-recent are Claude-Code-skill tools (research/taste/code-graph agent stack) — agents-that-RESEARCH, NOT agents-that-TRADE
  - **Robinhood Chain is permissionless HOST at chain layer + VERTICAL at agent-product layer** (in-app Robinhood Agents + Agent Apps + Trading MCP)
  - **THREAT LEVEL: MEDIUM** (not HIGH — Robinhood's Agent Apps is data-source-only, NOT a third-party agent install store... yet)

## Synthesis: 7 GEM-Level Theses

Based on all 10 research streams, the following 7 theses were synthesized:

1. **V6's V4-hook architecture + custom tax routing = first launchpad with "issuer-controlled managed launches" native** (Pump.fun has flat 1% with rotating recipients)
2. **Stock Tokens as "debt securities tracking underlying equities" + V6's bonding curve = "price discovery for debt securities"** (not fundraising)
3. **V6's anti-sniper tax window (first 20s, 99%→base) = first launchpad with native "trencher protection"** (Pump.fun has none)
4. **Vibe coding + custom tax = first launchpad with "launchpad-as-product"** (not speculation)
5. **Agent-vs-agent entertainment games have 0/1 success rate** (only Numerai real-stakes succeeded)
6. **Web3 gaming's 80.8% annual failure rate is driven by 4 patterns** (premature monetization, ponzinomics, bad game design, speculator-primacy)
7. **Karpathy's "vibe coding" was cognitive-experience framing; Levent operationalized it as commercial delivery framework**

## Final Synthesis: AgentObservatory v2

AgentObservatory v2 synthesizes the 7 theses + all 10 research streams + 5-judge evaluations into the Golden Goal documented in `01-specification-v2.md`.

The product:
- Embodies the actually-novel three-pillar merge (NOT derivative "stock memes" claim)
- Extends the founder's intellectual DNA (`seedify-agents-dashboard` pattern)
- Avoids all 4 Web3 gaming failure modes
- Avoids BitClout/reputation-market trap
- Avoids Mirror Protocol failure
- Embodies Numerai-pattern real-stakes (per-holder commit-reveal + slash for inaccuracy)
- Differentiates from all 5 competitors (Pump.fun, Flap, Virtuals, Clanker, Robinhood Agent Apps)
- Satisfies all 13 GEM criteria
- Satisfies all 7 explicit builder requirements from the founder's October 6, 2026 tweet
