# COMMUNICATION PROTOCOL

**Document purpose**: Define how the GLM-5.3 coder agent (and team) communicates with the user and with each other.

---

## §1. LANGUAGE POLICY

### §1.1 Persian is OK in chat
Persian is acceptable for chat between:
- User and coder agent (for clearer execution-flow understanding)
- Coder agent and team members (internal coordination)

This is to ensure the user (Persian-speaking) can clearly understand the execution flow and provide feedback.

### §1.2 English ONLY in code and project documentation
Persian must NOT leak into:
- Source code (variable names, function names, class names, file names)
- Code comments
- README files
- API documentation
- Commit messages
- Pull request titles and descriptions
- Issue titles and descriptions
- Architecture decision records
- Any file in the 5 repositories
- Discord bot messages
- Twitter marketing copy

**Rationale**: The product is global (EU + non-US only per Reg S); English is the lingua franca of crypto + developer ecosystems. Persian in code would limit the project to a Persian-speaking audience and create legal/compliance risk (Reg S disclosure must be in English for SEC).

### §1.3 Enforcement
- Tech Lead (Role 1) reviews every PR for English-only compliance
- QA/Testing Lead (Role 8) adds a CI check (e.g., `grep -rP '[\x{0600}-\x{06FF}]' src/ docs/` — should return zero hits)
- Documentation Lead (Role 7) reviews all docs for English-only compliance

---

## §2. COMMUNICATION CHANNELS

### §2.1 GitHub Issues (primary)
All technical issues, bug reports, feature requests, and acceptance criteria tracking go through GitHub Issues in the relevant repo.

- Each Phase has its own GitHub Project board
- Issues are tagged with: `phase:N`, `role:N`, `priority:high|medium|low`, `status:todo|in-progress|blocked|done`
- Acceptance criteria (per `docs/06-acceptance-criteria.md`) are tracked as GitHub Issues with `acceptance-criteria` label

### §2.2 GitHub Pull Requests
All code changes go through PRs. PR template includes:
- Summary of changes
- Phase + role tags
- Acceptance criteria link
- Test coverage report
- Slither/Mythril report (for Solidity PRs)
- Legal/Compliance review (for Solidity PRs or PRs touching tokenomics)

### §2.3 Discord (internal team coordination)
Internal team coordination uses a private Discord server (NOT the public `discord.gg/vibevibebuilders`).

- Channels: `#phase-0`, `#phase-1`, ..., `#phase-8`, `#legal-review`, `#community-bd`, `#random`
- Persian is OK in internal Discord channels
- All decisions in Discord must be documented in a GitHub Issue or ADR

### §2.4 Public Discord (`discord.gg/vibevibebuilders`)
Public communications with the vibe/vibe community:

- `#project-showcase` — post the 3 demo agent-attested tokens (English only)
- `#builder-help` — answer questions from other builders (English only, but Persian-speaking builders can DM in Persian)
- `#global-chat` — general engagement (English only)

### §2.5 Twitter/X (external marketing)
All external marketing on Twitter (English only):
- Launch tweet for `@meta_alchemist` quote-tweet
- Daily "Agent Verdict of the Day" digest image auto-posted
- Builder amplifications (when other builders ship agent-observatory-compatible products)

### §2.6 Email (external counsel)
External legal counsel communication (for the 2-opinion legal memo on utility-token characterization) goes through email. Founder's responsibility.

---

## §3. STANDUP PROTOCOL

### §3.1 Daily standup (async, GitHub Projects)
Each engineer posts a daily standup in the relevant GitHub Project board:
- Yesterday: what was completed
- Today: what's planned
- Blockers: what's blocking progress

### §3.2 Weekly sync (live, internal Discord)
Weekly sync on Mondays at 14:00 UTC in the internal Discord `#phase-sync` channel:
- Phase progress review
- Cross-phase dependency check
- Risk review
- Decisions needed from Tech Lead

### §3.3 Phase gate review (live, internal Discord)
At the end of each phase, a phase gate review:
- Acceptance criteria verification
- Go/No-Go decision for next phase
- Lessons learned

---

## §4. ESCALATION PROTOCOL

### §4.1 Technical blocker
If an engineer is blocked on a technical issue for >4 hours:
1. Post in the relevant phase channel in internal Discord
2. Tag the Tech Lead (Role 1)
3. If Tech Lead can't resolve in 2 hours, escalate to user

### §4.2 Legal/compliance blocker
If an engineer encounters a legal/compliance question:
1. Tag the Legal/Compliance Reviewer (Role 9) in the PR
2. Legal/Compliance Reviewer assesses within 24 hours
3. If high-risk, escalate to external counsel (founder's responsibility)

### §4.3 Founder/team liaison blocker
If coordination with the vibe/vibe team is needed (e.g., V6 LaunchFactory address verification, Guilds contract address, audit timeline):
1. Community/BD (Role 10) reaches out via Discord DM or Telegram
2. If no response in 48 hours, escalate to user

### §4.4 User escalation
For any issue that requires user input (e.g., infrastructure access, business decisions):
1. Post in the `#user-escalation` channel in internal Discord
2. User responds within 24 hours (Persian OK)

---

## §5. INFRASTRUCTURE ACCESS REQUESTS

### §5.1 GitHub Education benefits package
Verified and accessible. To request access for a new service:
1. Open a GitHub Issue in the relevant repo with label `infra-request`
2. Specify: service name, purpose, estimated cost, duration
3. User provides credentials or access within 24 hours

### §5.2 NVIDIA Developer account
Verified and accessible. To request GPU compute (e.g., for local LLM via Ollama):
1. Open a GitHub Issue with label `infra-request`, `nvidia`
2. Specify: GPU model needed, estimated compute hours, purpose (e.g., "training", "inference")
3. User provides access within 24 hours

### §5.3 Azure for Builders
Verified and accessible. To request Azure resources (e.g., App Service for kernel service, Azure Monitor):
1. Open a GitHub Issue with label `infra-request`, `azure`
2. Specify: resource type, region, estimated monthly cost, purpose
3. User provides access within 24 hours

### §5.4 AWS Builder ID
Verified and accessible. To request AWS resources (e.g., EC2 for kernel service, CloudWatch for monitoring):
1. Open a GitHub Issue with label `infra-request`, `aws`
2. Specify: service (EC2/S3/Lambda/CloudWatch), region, estimated monthly cost, purpose
3. User provides access within 24 hours

---

## §6. SECRETS MANAGEMENT

### §6.1 Local development
- Use `.env` files (NEVER commit to git)
- Use `.env.example` as template (commit to git)
- Use `direnv` or `dotenv` for loading

### §6.2 CI/CD
- Use GitHub Actions secrets (encrypted at rest)
- Never echo secrets in logs
- Use `${{ secrets.SECRET_NAME }}` syntax

### §6.3 Production
- Use Railway/Fly.io/Vercel environment variables (encrypted at rest)
- Rotate secrets quarterly
- Use principle of least privilege (each service has only the secrets it needs)

### §6.4 Token rotation
The user will rotate the GitHub PAT and Discord token after each session. Do NOT store these tokens in any file. Use environment variables only.

