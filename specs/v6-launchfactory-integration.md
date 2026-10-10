# V6 LaunchFactory Integration Specification

**Status**: Specified in `docs/01-specification-v2.md` §5.1 and §11.

## V6 LaunchFactory Address

`0xe794217880011f9cA6961340eD5c16EC9559Fea0` (verified on-chain per worklog §6b-onchain-fast)

## V6 Function Selectors (24/86 decoded)

| Selector | Signature | Significance |
|---|---|---|
| `0x27cca59f` | `launchCount()` | launchpad counter |
| `0x84639514` | `launchNonce(address)` | per-creator nonce |
| `0xdce0b4e4` | `creationFee()` | fee getter (0.0004 ETH) |
| `0xb7d86225` | `setCreationFee(uint256)` | admin |
| `0x61d027b3` | `treasury()` | fee sink |
| `0xf0f44260` | `setTreasury(address)` | admin |
| `0xdc4c90d3` | `poolManager()` | Uniswap V4 PoolManager |
| `0x7f5a7c7b` | `hook()` | Uniswap V4 hook |
| `0xd7b96d4e` | `locker()` | LP locker |
| `0x2a2dae0a` | `tokenDeployer()` | token minter role |
| `0x12261ee7` | `permit2()` | Uniswap Permit2 |
| `0x262d6152` | `zap()` | zap-in |
| `0xe30c3978` | `pendingOwner` | Ownable2Step |
| `0x79ba5097` | `acceptOwnership` | Ownable2Step |
| `0x715018a6` | `renounceOwnership` | Ownable2Step |
| `0x24e615b3` | (no 4byte match) | `createLaunch(...)` — primary entry-point |

## Blockscout Verification Status

V6 LaunchFactory is **NOT source-verified** on Blockscout. No ABI, no Solidity source, no compiler metadata.

The `vibe-vibe-create-abi` selector recovery package (per J1 Round-2 strengthening suggestion) handles this by:
1. Providing the 24/86 decoded selectors as TypeScript discriminated unions
2. Providing `launchTokenRaw(calldata: Hex)` for the unverifiable `0x24e615b3` selector
3. Providing `submitABI(abi, sourceUrl)` community-contribution API for when the team (or any builder) reverse-engineers the createLaunch signature

## RPC Endpoint

`https://rpc.testnet.chain.robinhood.com` (HTTP only — `wss://rpc.testnet.chain.robinhood.com` does NOT exist per AO-2 finding)

## Blockscout API

`https://explorer.testnet.chain.robinhood.com/api/v2/` (used for tx history, contract queries, search)

## Chain ID

46630 (EVM, Arbitrum Orbit L2)
