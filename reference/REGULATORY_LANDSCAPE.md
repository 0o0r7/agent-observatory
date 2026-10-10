# Regulatory Landscape

## SEC (United States)

### SEC Innovation Exemption (September 17, 2026)
- **5-year conditional sandbox** for trading of tokenized NMS stock
- **Source**: SEC press release 2026-90 (sec.gov/newsroom/press-releases/2026-90-...)
- **Formal order**: Temporary Conditional Exemptive Relief under Section 36 (sec.gov/files/rules/exorders/2026/34-106402.pdf)
- **Impact**: Regulatory greenlight for tokenized stock trading on Robinhood Chain

### Robinhood Assets (Jersey) Limited
- **SEC EDGAR CIK**: 0002142247
- **State of Incorporation**: Y9 (Jersey, Channel Islands)
- **Address**: First Floor, La Chasse Chambers, Ten La Chasse, St. Helier JE2 4UE, Jersey
- **Phone**: +44 1534 888860
- **Mailing**: 85 Willow Road, Menlo Park CA 94025 (Robinhood Markets HQ)
- **SEC Filings**: Form 40-APP (Investment Company Act of 1940 exemptive application), filed 2026-07-14 (accession 0000950103-26-010574)

### Stock Tokens Legal Classification
- **Issuer**: Robinhood Assets (Jersey) Limited
- **Classification**: Tokenised debt securities
- **Quote**: *"Stock Tokens are tokenised debt securities issued by Robinhood Assets (Jersey) Limited. They provide economic exposure to underlying securities but do not [confer legal or beneficial ownership]."*
- **Available tokens**: 190+ tracking NVIDIA, Google, Apple, QQQ
- **Confirming sources**: Koi Finance (August 17, 2026), X.com (July 17, 2026) — "collateralized debt securities"

### Investor Eligibility
- **US retail**: EXCLUDED
- **US accredited**: EXCLUDED
- **EU retail**: Accessible via Robinhood Europe UAB under MiCA
- **Other jurisdictions**: Subject to restrictions

### SEC's September 2026 Tokenization Guidance
- Issuers can object to third-party tokenization within **30 days** of trading-venue notice
- Risk: Each tracked equity issuer (NVDA, AAPL, etc.) can veto tokenization
- Mitigation: Mega-caps (NVDA, AAPL) have public tokenization already; less risk of veto

## Howey Test (Securities Law)

### SEC v. W.J. Howey Co., 328 U.S. 293 (1946)
A security exists if there is:
1. Investment of money
2. In a common enterprise
3. With an expectation of profit
4. To be derived from the efforts of others

### AgentObservatory's Howey Analysis
AgentObservatory v2 is designed to fail prong #4 ("efforts of others") via per-holder commit-reveal:
- Holders submit their OWN verdicts via commit-reveal
- Reflections distributed based on the HOLDER's prediction accuracy (NOT the operator's)
- The holder's profit depends on their OWN prediction skill, not on the efforts of a promoter

This matches the Numerai NMR token pattern (which has not faced SEC enforcement since 2017).

## CFTC (Commodity Futures Trading Commission)

### Polymarket Settlement (January 3, 2022)
- **Penalty**: $1.4M fine for binary-options event contracts on PUBLIC events (elections, sports)
- **Distinction from AgentObservatory**:
  - AgentObservatory's commit-reveal pattern is NOT a swap (CFTC §1a(47) — no exchange of payments based on outcome)
  - NOT an event contract (CFTC §1a(33) — token graduation is market-internal, not "an event of interest to the public at large" under §5b(c)(2)(B))
  - NOT a SEF (CFTC §1a(38) — AgentObservatory is a tax-distribution smart contract, not a swap execution facility)

## Investment Advisers Act of 1940

### §202(a)(11) — Investment Adviser Definition
A person is an investment adviser if they receive compensation for managing securities.

### AgentObservatory's Position
- The agent operator is NOT acting as an investment adviser
- The agent-attested token is a research publication primitive, NOT a managed-account service
- Verdicts are public goods (published), NOT tailored advice
- Holders do not receive personalized advice

## Exchange Act of 1934

### §3(a)(24) — Transfer Agent Definition
A transfer agent maintains securityholder records.

### AgentObservatory's Position
- Phase-2 Reflections Router distributes based on ON-CHAIN BALANCE at snapshot block
- NOT based on a maintained ledger of securityholder identities
- Does NOT constitute transfer-agent activity

### §15 / §20 — Control Person Liability
- Multi-sig scope is limited to ratifying deterministic oracle output for slashing
- Multi-sig does NOT initiate slashing, does NOT exercise discretionary judgment
- Multi-sig signers are NOT "control persons"

### §3(a)(5) — Dealer Definition
- A dealer is a person engaged in the business of buying and selling securities for their own account
- Builder Grants Fund will NOT engage in secondary market purchases of agent-attested tokens
- Only distributes treasury-held tax receipts (ETH or pair-token assets, NOT agent-attested tokens)

## EU MiCA Regulation

### Robinhood Europe UAB (Vilnius, Lithuania)
- Distributes Stock Tokens in EU under MiCA
- EU retail access via this entity

### MiCA Token Classification
- eMT (electronic money tokens) — for stablecoins
- ART (asset-referenced tokens) — for tokens referencing assets
- Other — for utility tokens
- AgentObservatory's agent-attested token is positioned as a utility token (NOT eMT, NOT ART)

## Jersey Financial Services Commission

### Robinhood Assets (Jersey) Limited
- Registered in Jersey (per SEC EDGAR's "Y9" state code)
- Subject to Jersey FSC regulation
- JFSC business-registry is JS-gated; full lookup requires authenticated session

## State Money Transmitter Laws

### NY BitLicense
- May apply if AgentObservatory holds custody of NY residents' funds
- Mitigation: non-custodial design (ERC-6551 token-bound accounts; MCP bridge runs locally on operator's machine)

### CA DFPI (Department of Financial Protection and Innovation)
- May apply if AgentObservatory serves CA residents
- Mitigation: US-exclusion stack (KYC + IP geo-fence + ToS attestation)

## Insurance Regulation

### McCarran-Ferguson Act (15 U.S.C. §1011)
- State insurance commissioners regulate insurance
- "Insurance" terminology triggers state insurance regulation

### AgentObservatory's Position
- NO "insurance" terminology anywhere in spec or marketing
- "Slashing" is a staking penalty (NOT an insurance payout)
- "30-day linear vesting" is a schedule (NOT a policy period)
