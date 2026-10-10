# Team Roles — 10 Specialized Roles

**Document purpose**: 10 specialized team roles for parallel execution of AgentObservatory v2.

**Full team composition**: See `../handoff/TEAM_COMPOSITION.md` for the complete role descriptions, responsibilities, required skills, tools, and estimated allocation.

## Role Summary

| Role | Title | Reports to | Owns |
|---|---|---|---|
| 1 | Tech Lead / Architect | Project owner | Overall architecture, code reviews, multi-repo coordination |
| 2 | Solidity Engineer | Tech Lead | V6 integration, Phase-2 contracts (post-audit) |
| 3 | TypeScript/Next.js Engineer | Tech Lead | vibe-vibe-create-sdk, agent-observatory-studio, MCP bridge |
| 4 | Python Engineer | Tech Lead | agent-observatory-kernel (verdict engine, autoloop runner) |
| 5 | AI/LLM Engineer | Tech Lead | Provider-agnostic LLM router, autoloop.yml schema, evidence synthesis |
| 6 | DevOps/SRE | Tech Lead | CI/CD, hosting, monitoring |
| 7 | Documentation Lead | Tech Lead | README files, technical docs, handoff docs |
| 8 | QA/Testing Lead | Tech Lead | Test strategy, automated tests, security analysis |
| 9 | Legal/Compliance Reviewer | Tech Lead | Securities-law posture, Reg S, MiCA, KYC integration |
| 10 | Community/BD | Project owner | Discord integration, builder outreach, vibe/vibe team liaison |

## Solo Founder with Claude Code (Alternative)

Combine roles as:
- **You (founder)**: Role 1 (Tech Lead) + Role 10 (Community/BD) + final review of Roles 2-9
- **Claude Code**: Roles 2 (Solidity) + 3 (TypeScript) + 4 (Python) + 5 (AI/LLM) + 6 (DevOps) + 7 (Docs) + 8 (QA) + 9 (Legal review prompts)

This is feasible because Claude Code can write code across multiple languages, set up CI/CD, write tests, write docs, and review legal compliance (with external counsel for the 2-opinion memo).

See `../handoff/TEAM_COMPOSITION.md` for full role descriptions.
