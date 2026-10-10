# Robinhood Trading MCP Bridge Specification

**Status**: Specified in `docs/01-specification-v2.md` §5.1 (Repo 4) and §2 (constraint #23).

## Robinhood Trading MCP Endpoint

`https://agent.robinhood.com/mcp/trading` (Streamable HTTP MCP server, 77 tools, 6 categories: Account / Watchlist / Market data / Equities / Options / Crypto)

## Architecture

- **LOCAL process** on operator's machine (NOT a hosted service)
- Robinhood Agentic Account connected via Robinhood OAuth in browser (NOT via EVM wallet signature)
- EIP-712 typed-data authorization translated to Robinhood Trading MCP tool call
- NEVER holds operator credentials (per §2.1 constraint #5 — DPRK-PTSD-driven)

## Operator-in-Control Pattern

1. Agent PROPOSES trade (displays in localhost UI)
2. Operator reviews and SIGNS via their own wallet (EIP-712 typed-data)
3. Bridge translates signed authorization to Robinhood Trading MCP tool call
4. Trade executes in holder's OWN Robinhood Agentic Account

## Anti-Sniper Window Auto-Reject

MCP bridge auto-rejects MCP-proposed buys on tokens launched <20s ago:
- Returns `antiSniperWindowActive` revert
- Prevents accidental 99% tax exposure (V6 anti-sniper mechanism per AO-2 risk R-C)

## Paper-Trade Mode (Default)

When MCP bridge is not connected or operator opts out:
- Agent runs in paper-trade-only mode
- Verdicts still generated and persisted to `artifacts/`
- No real trades executed

## Reference Implementations

- `kevin1chun/robinhood-for-agents` — MCP integration (Claude Code/Codex/Cursor/ChatGPT)
- `mogons/noraz-agent` — Robinhood Chain native, web portal noraz.space
- `YAN-XBT/HOODRADAR` — Hermes Agent on Robinhood Chain

## Documentation

- MCP onboarding doc: `https://robinhood.com/us/en/support/articles/onboarding-an-external-agent/`
- Help-center hub: `https://robinhood.com/us/en/support/agentic-trading/`
