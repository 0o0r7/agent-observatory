# ERC-20 Agent-Attested Token Specification

**Status**: Specified in `docs/01-specification-v2.md` §2 (Fix #3) and §6.

## Why ERC-20, not ERC-721

V6 LaunchFactory produces ERC-20 tokens, NOT ERC-721 NFTs (per worklog §6b-onchain-fast — V6 LaunchFactory at `0xe794217880011f9cA6961340eD5c16EC9559Fea0` produces ERC-20 via the standard bonding-curve mechanism).

The original v1 spec called for ERC-721 + ERC-6551 token-bound accounts. AO-2 (On-chain judge) identified this as a CRITICAL on-chain incoherence — the spec's "agent NFT launched via V6 /create" is architecturally impossible.

## v2 Fix

Agent tokens launch as **ERC-20** via V6 /create flow. ERC-6551 token-bound accounts are **deferred to Phase 3** with LayerZero ONFT cross-chain bridge.

## Token Launch Parameters

See `../docs/01-specification-v2.md` §6 for the complete token launch parameter table.
