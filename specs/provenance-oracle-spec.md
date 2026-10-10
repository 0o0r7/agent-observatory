# Phase-2 Provenance Oracle Specification

**Status**: Specified in `docs/01-specification-v2.md` §7.1.

## Contract Size

~160 lines Solidity (EVM-native primitives only)

## EIP-712 (Modern Standard, Replaces EIP-191)

Per AO-1 fix: use EIP-712 typed-data (modern standard, 2026-era wallets natively support `eth_signTypedData_v4`) instead of EIP-191 (2016-era, known chain-id replay-protection issues).

## Full Solidity Implementation

See `../docs/01-specification-v2.md` §7.1 for the complete Solidity implementation including:

- EIP-712 domain separator (name, version, chainId, verifyingContract)
- `VERDICT_TYPEHASH`
- `registerVerdict()` function with EIP-712 typed-data verification
- `operatorPublicKey` (immutable, set in constructor)
- `verdictHashOf` mapping (launchAddress => verdictHash)
- `VerdictRegistered` event

## Self-Audit

Self-auditable with Slither + Mythril in an afternoon (per J1 Round-1 criterion):
- No external calls
- No array loops
- No reentrancy surface
- EVM-native primitives only (keccak256, abi.encodePacked, address, bytes32, uint8, ecrecover, EIP-712 typed-data)

## Deployment Status

**DEFERRED** to post-team-audit. V6 itself is NOT source-verified on Blockscout per worklog §6b-onchain-fast. Deploying custom Solidity on top of unaudited V6 = unaudited-on-unaudited risk.
