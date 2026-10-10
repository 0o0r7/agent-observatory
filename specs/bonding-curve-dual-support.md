# Bonding Curve Dual-Support Specification

**Status**: Specified in `docs/01-specification-v2.md` §9.

## Background

The V6 bonding curve was changed 1000x mid-flight on 2026-09-05 (per Discord pain point #1 from @nblurr_28691):

> "Two curves, one leaderboard... invariants differ by exactly 1000x: legacy k = 1.0344e6 (graduates at 0.005 ETH) current k = 1.0344e9 (graduates at 5 ETH)... This make every new builder penalised ! 31.62x more ETH is needed to achieve same results as before contracts update... Not fair for new builders/traders."

## Dual-Support Specification

| Generation | k value | Graduation threshold |
|---|---|---|
| Legacy (pre-2026-09-05) | 1.0344e6 | 0.005 ETH |
| Current (post-2026-09-05) | 1.0344e9 | 5 ETH |

## SDK Implementation

The `vibe-vibe-create-sdk.getBondingCurveProgress(tokenAddress)` function detects which generation a token belongs to (via the launch timestamp from V6 LaunchFactory events) and applies the appropriate formula.

## Detection Logic

```typescript
async function getBondingCurveProgress(tokenAddress: Address): Promise<{
  generation: 'legacy' | 'current';
  k: bigint;
  graduationThreshold: bigint; // in wei
  progress: number; // 0-100
}> {
  const launchTimestamp = await getLaunchTimestamp(tokenAddress);
  const generation = launchTimestamp < LEGACY_CUTOFF_TIMESTAMP 
    ? 'legacy' 
    : 'current';
  const k = generation === 'legacy' ? 1034400n : 1034400000n;
  const graduationThreshold = generation === 'legacy' 
    ? parseEther('0.005') 
    : parseEther('5');
  // ... compute progress
}

const LEGACY_CUTOFF_TIMESTAMP = Math.floor(new Date('2026-09-05T00:00:00Z').getTime() / 1000);
```

This is the gold standard for handling a known on-chain regression.
