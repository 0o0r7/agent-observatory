# Roadmap — 21-Day MVP

**Document purpose**: 21-day MVP plan for AgentObservatory v2.

**Full plan**: See `../handoff/PHASE_BREAKDOWN.md` for the complete parallel phase execution plan.

## Phase Summary

| Phase | Days | Deliverable | Dependencies |
|---|---|---|---|
| 0 | 1 | Repo setup + dev environment + initial scaffolding | None |
| 1 | 2-7 | `vibe-vibe-create-sdk` + `vibe-vibe-create-abi` | Phase 0 |
| 2 | 5-12 (parallel) | `agent-observatory-kernel` + autoloop runner | Phase 0 |
| 3 | 8-15 (parallel) | `agent-observatory-studio` + Privy integration | Phase 1 |
| 4 | 10-14 (parallel) | `agent-observatory-mcp-bridge` | Phase 1 |
| 5 | 13-18 | `agent-observatory-contracts` Solidity scaffolding | Phase 0 |
| 6 | 16-20 | 3 demo agent-attested tokens + daily digest pipeline | Phases 1, 2, 3 |
| 7 | 19-21 | Discord bot + GitHub repo finalization | All prior |
| 8 | Post-MVP | Phase-2 contracts deployment | V6 audit + 2-opinion legal memo |

## Solo Founder with Claude Code (Alternative)

If executed by a solo founder with Claude Code (Pieter Levels pattern), the 21-day plan is feasible:
- Day 1-2: Set up 5 repos + Claude Code project
- Day 3-7: Implement `vibe-vibe-create-sdk` with Claude Code
- Day 8-12: Implement `agent-observatory-kernel` with Claude Code
- Day 13-15: Implement `agent-observatory-studio` + MCP bridge with Claude Code
- Day 16-17: Launch 3 demo agent-attested tokens on testnet
- Day 18-19: Daily digest pipeline
- Day 20-21: Discord bot + final repo polishing

## 5-Engineer Team (Alternative)

If executed by a 5-engineer team, the 14-day plan is feasible:
- Day 1: Phase 0 (all 5 engineers coordinate)
- Day 2-7: Phases 1, 2, 5 in parallel (TypeScript eng, Python eng + AI/LLM eng, Solidity eng)
- Day 8-12: Phases 3, 4 in parallel (TypeScript eng, DevOps)
- Day 13-14: Phase 6, 7 (full team)

See `../handoff/TEAM_COMPOSITION.md` for the complete team roles and `../handoff/PHASE_BREAKDOWN.md` for the detailed parallel execution plan.
