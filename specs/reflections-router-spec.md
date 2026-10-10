# Phase-2 Reflections Router Specification

**Status**: Specified in `docs/01-specification-v2.md` §7.2 and §4.

## Contract Size

~150 lines Solidity (pull-based distribution + snapshot-based)

## Pull-Based Distribution (matches V6's existing reflection pattern)

Per J2 Round-1 spec: pull-based distribution (claimable by holder at any time after snapshot block).

## Snapshot-Based (NOT Maintained Ledger)

Per §0.2 securities-law compliance posture: distributes based on ON-CHAIN BALANCE at snapshot block, NOT based on a maintained ledger of securityholder identities. Avoids transfer-agent characterization under Exchange Act §3(a)(24).

## Distribution Mechanism

Distributes pair-token reflections to **holders who revealed correct verdicts** pro-rata by their (correctVerdicts × stakeAmount) over the snapshot block.

## Multi-Sig Scope Limitation

Per §0.2: multi-sig scope limited to ratifying deterministic SybilClusterProof output for slashing. Multi-sig does NOT initiate slashing, does NOT exercise discretionary judgment.

Per J2 Round-2 elevation condition: on-chain `SybilClusterProof` struct + 7-day timelock before slash execution + community dispute window.

## Slash for Inaccuracy (Real Numerai-Pattern)

Per §4.4: operators lock 0.1% of supply for 30 days; slashable if 30-day accuracy < 0.40 (Brier score). Slashed amount routed to Builder Grants Fund.

## Deployment Status

**DEFERRED** to post-team-audit.
