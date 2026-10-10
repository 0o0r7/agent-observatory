# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in AgentObservatory v2, please DO NOT open a public issue. Instead, report it privately to the maintainers.

**Reporting process**:
1. Email the maintainers directly (do not post in public channels)
2. Include: description of vulnerability, affected component(s), reproduction steps, suggested fix (if any)
3. Acknowledgment within 24 hours
4. Fix or mitigation within 7 days (critical) or 30 days (high/medium)
5. Public disclosure after fix is released (with reporter's consent)

## Critical Security Constraints (non-negotiable)

These constraints come from the founder's documented preferences (DPRK-PTSD-driven) and the 5-judge evaluation panel.

### §1. NEVER Hold Operator Credentials

The MCP bridge (`agent-observatory-mcp-bridge`) MUST NEVER hold operator credentials (Robinhood OAuth tokens, EVM wallet private keys, LLM API keys).

Pattern:
- Agent PROPOSES (displays in localhost UI)
- Operator reviews and SIGNS via their own wallet (EIP-712 typed-data)
- Bridge translates signed authorization to Robinhood Trading MCP tool call
- Trade executes in holder's OWN Robinhood Agentic Account

This is the founder's DPRK-PTSD-driven rule: the 2025-09-23 DPRK/Lazarus hack of Seedify bridge was via a stolen developer private key obtained via a fake "interview". The operator-in-control pattern is the structural defense.

### §2. Per-Holder Commit-Reveal (Howey Fix)

Phase-2 contracts MUST implement per-holder commit-reveal:
- Holders submit their OWN verdicts via commit-reveal
- Reflections distributed based on HOLDER's accuracy (NOT operator's)
- Fails "efforts of others" prong of Howey

This is the securities-law compliance posture per §0.2 of the specification.

### §3. Slash for Inaccuracy (Numerai-Pattern)

Phase-2 contracts MUST implement slash-for-inaccuracy:
- Operators lock 0.1% of supply for 30 days
- Slashable if 30-day accuracy < 0.40 (Brier score)
- Slashed amount routed to Builder Grants Fund

This is the real Numerai-pattern real-stakes mechanism (NOT just slash-for-sybil).

### §4. Anti-Sniper Window Auto-Reject

The MCP bridge MUST auto-reject MCP-proposed buys on tokens launched <20s ago:
- Returns `antiSniperWindowActive` revert
- Prevents accidental 99% tax exposure (V6 anti-sniper mechanism)

### §5. Phase-2 Contracts Deferred Until V6 Audit

Phase-2 Solidity contracts (Provenance Oracle, Per-Holder Commit-Reveal, Reflections Router, Slashable Stake) MUST NOT be deployed until:
1. V6 LaunchFactory source is verified on Blockscout
2. V6 audit is completed
3. 2-opinion legal memo on utility-token characterization is obtained

V6 itself is NOT source-verified on Blockscout per worklog §6b-onchain-fast. Deploying custom Solidity on top of unaudited V6 = unaudited-on-unaudited risk (per J1 Round-1 criterion).

### §6. Secrets Management

- NEVER commit secrets (GitHub PAT, Discord token, LLM API keys) to git
- Use GitHub Actions secrets for CI/CD (encrypted at rest)
- Use `.env` files for local development (NEVER commit)
- Rotate secrets quarterly
- Use principle of least privilege (each service has only the secrets it needs)

### §7. EU Data Residency (Reg S Compliance)

For `agent-observatory-kernel` hosting: prefer EU regions:
- Railway Frankfurt
- Fly.io Amsterdam
- Azure West Europe
- AWS eu-west-1

For `artifacts/` storage: prefer IPFS (decentralized) or Azure Storage West Europe.

For LLM API calls: Anthropic, OpenAI, Z.AI all have EU data residency options — enable if available.

## Audit Trail

All infrastructure access requests documented in GitHub Issues. All secrets stored in GitHub Actions secrets (audit log available). All LLM API calls logged (provider-side + local logs). All verdicts persisted to `artifacts/verdicts/` (immutable file-first state per §2.1 of AGENT_INSTRUCTIONS.md).
