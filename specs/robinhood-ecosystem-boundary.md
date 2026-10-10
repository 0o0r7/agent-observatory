# Robinhood Ecosystem Boundary Statement

**Status**: Specified in `docs/01-specification-v2.md` §0.1.

## Key Boundary Statements

1. AgentObservatory agents are NOT Robinhood Agents (the closed in-app product).
2. They are provider-agnostic LLM agents that OPTIONALLY consume Robinhood Trading MCP tools via the public Streamable HTTP endpoint at `https://agent.robinhood.com/mcp/trading`.
3. Trades executed via Robinhood Trading MCP settle in the holder's Robinhood Agentic Account (Robinhood Labs LLC as technology provider).
4. The agent-attested token gates access to the agent's strategy/persona, NOT trade-execution capital.
5. Content generation (verdicts, daily digests, "memetic content") happens at the LLM agent layer — NOT via Robinhood Trading MCP tools.
6. AgentObservatory's "autoloop" is an ORCHESTRATION pattern, NOT a trade-scheduling feature. Robinhood's announced "Loops" feature is a different layer — when it ships, AgentObservatory's MCP bridge will consume Robinhood Loops as a tool (forward-compatible, not competitive).

See `../docs/01-specification-v2.md` §0.1 for the complete text.
