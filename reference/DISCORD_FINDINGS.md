# Discord Deep-Dive Findings (4,095 messages, 37-day window)

**Source**: discord.gg/vibevibebuilders (guild_id `1541735368670314556`)
**Window**: 2026-09-02 → 2026-10-09 (~37 days)
**Total messages fetched**: 4,095 across 26 fetchable text channels
**403-forbidden channels**: #build-lab, #launch-runway, #mainnet-how-to-launch, #guild-leader-help, #robinhood-alpha, #archive-foundory-start-here

## Guild Stats

- **Guild name**: vibe/vibe builders
- **Member count**: 1,294 (up from 1,085 in prior research, +19%)
- **Online**: 157
- **Premium tier**: 3 (boosted)

## Top Channels by Message Count

| Channel | Messages | First | Last |
|---|---|---|---|
| #global-chat | 3,300 | 2026-09-04 | 2026-10-09 |
| #share-your-content | 427 | 2026-09-02 | 2026-10-09 |
| #project-showcase | 180 | 2026-09-02 | 2026-10-09 |
| #builder-help | 94 | 2026-09-02 | 2026-10-09 |
| #bug-reports | 54 | 2026-09-02 | 2026-09-16 |
| #build-chat | 15 | 2026-10-02 | 2026-10-09 |
| #announcements | 3 | 2026-09-02 | 2026-10-09 |

## Team Activity (last 30 days)

- **176 team messages** total across 4 active voices:
  - `@adramelekh.` (38 msgs)
  - `@justine1588` = Jinz02 (66 msgs)
  - `@lauraam1049` (3 msgs) — runs Builder Foundry
  - `@nam0110220` (1 msg)
- **Founder @meta_alchemist went DARK after Sep 10 launch day** (25+ msgs on launch day, then quiet)
- **Neil, Jumperz NEVER appeared in fetched channels** (only in private 403 channels)

## Key Announcements

- **Builder Foundry launched Oct 8** — official channel for builder onboarding with 8 playbooks on Google Drive, structured stage roles, weekly AMA sessions
- **Robinhood Chain daily builder digest launched Oct 9** by `@lauraam1049` (LauraAM) — posted in `#robinhood-chain-newsfeed` every morning
- **Bug intake moved to Google Form on Sep 16** — team overwhelmed

## Top Shipped Products (with URLs)

| Product | Builder | URL | Category |
|---|---|---|---|
| **vibekit** | @riohaily | github.com/0xnesQuit/vibekit + npm | dev tool / SDK (closest community analog to VibeForge) |
| **VibeGuard** | @sahmedonchain | github.com/sahmedonchain/vibeguard | risk/analytics |
| **Launch Intelligence** | @c00.sol (Torvian) | launch-intelligence-staging-staging.up.railway.app + github.com/itstorvian/vibevibe-testnet-indexer | risk/analytics + open-source indexer |
| **KICKER ($KICKER)** | @xxxmnkey | kickerhq.vercel.app + github.com/sirkicker/kicker | on-chain game |
| **Outlay** | @rouma5123 | outlay-theta.vercel.app + github.com/dmetagame/outlay | stock/RWA |
| **Plinth** | @kducky123 | useplinth.vercel.app | stock/RWA basket (5 tokenized stocks) |
| **Robinhood Ronin** | @harunguyen | (1,992 fully on-chain pixel warriors, SVG in bytecode) | NFT |
| **VibeMarketFighters** | @fortimes | vibe-market-fighters-game.fcat123.workers.dev | on-chain game |

## Pain Points (with verbatim quotes)

1. **Bonding curve changed 1000x mid-flight, penalizing new builders** — @nblurr_28691 (2026-09-05): *"Two curves, one leaderboard... invariants differ by exactly 1000x: legacy k = 1.0344e6 (graduates at 0.005 ETH) current k = 1.0344e9 (graduates at 5 ETH)... This make every new builder penalised ! 31.62x more ETH is needed to achieve same results as before contracts update... Not fair for new builders/traders."*

2. **Token deploy failures / PLAN_QUOTED_BLOCK_STALE** — @ducmanh84 (2026-09-13): *"Failed A transaction safety check could not be completed before the wallet opened..."*

3. **Buy/sell transactions silently fail** — @kamrul422 (2026-09-10): *"Whenever I try to buy a token, the purchase doesn't go through. And when I try to sell a token, the sell transaction also fails."*

4. **Discover / graduated section broken for days** — @bona_ventures (2026-09-12): *"the graduated section under discover haven't been working for days now, and that has been my best profit making angle."*

5. **Mobile/Android instability** — @jhondurux (2026-09-13): *"Please stabilize your website experience for Android sir, I want to try your website anywhere but the website is often like this"*

## Recurring Feature Requests (NOT shipped)

1. **Customizable quick-buy/sell presets** — @siva4810 (2026-09-11)
2. **Take-profit / stop-loss on token market page** — @artespraticas (2026-10-07)
3. **Custom smart-contract writing (founder promised workshops, NOT delivered)** — @kezuflow (2026-09-10)
4. **Auto-router for SPCX** — @priyabhartibarh (2026-09-11)
5. **Separate stocks tab in UI** — @betta2093 (2026-09-12)
6. **3D rigged Vibe Vibers assets for game devs** — @ben_w3 (2026-09-25, no team reply)

## Critical Finding: VibeForge / SDK Studio is INVISIBLE

- **ZERO mentions of "VibeForge" or "SDK Studio"** in 4,095 messages
- A builder (@riohaily) already shipped `vibekit` (`npx vibevibekit init`) on npm
- Multiple builders explicitly ask for SDK/integration help, NO public team answer:
  - @ifeolayeni (Oct 9, no team reply): *"I've integrated Privy into GAPCALL... what's the best way to let users buy or swap $GAP without leaving the app?"*
  - @kezuflow (Sep 10): *"could we atleast write our own smart contracts..."* — founder replied, promised workshops, NOT delivered

## Critical Finding: ZERO RFPs in Discord

- Team has issued **ZERO RFPs / grants / bounty programs** in Discord in 37 days
- Search for "RFP" / "request for proposal" / "grant program" / "Builders program" all returned 0 hits
- **AgentObservatory would be the FIRST** formal builder program in Discord

## Critical Finding: ZERO showcases got team reply

- **110+ launches in 37 days** in #project-showcase
- **ZERO showcases got a public team reply** — biggest amplification gap

## Community Sentiment — Top Keywords

vibe (569) · project (266) · how (231) · what (231) · role (204) · good (200) · builder (197) · get (189) · hello (185) · guys (172) · chain (150) · check (145) · all (141) · everyone (136) · any (134) · hey (130) · live (128) · robinhood (119) · please (115) · wallet (114)

**Signal**: "role/get/welcome/please" dominate = most messages are newcomer-onboarding/role-application chatter. "how/what" high = many questions. "game" (104) = games are the #1 shipped category. "wallet" (114) reflects the wallet/signing pain cluster.

## $VIBEVIBE TGE Timing Sentiment

- Community in the dark on $VIBEVIBE TGE timing
- One user (@1usdchangemylife) openly bearish on $SPARK post-$VIBEVIBE-airdrop
- **No team member has publicly committed to a TGE date in Discord in the last 30 days**
