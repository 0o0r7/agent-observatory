# INFRASTRUCTURE ACCESS PROTOCOL

**Document purpose**: Define the infrastructure access packages available to the project, and the protocol for requesting access.

---

## §1. AVAILABLE INFRASTRUCTURE PACKAGES

The user has verified access to the following infrastructure packages. All are accessible upon request via the protocol in §2.

### §1.1 GitHub Education Benefits Package
- **Status**: Verified and accessible
- **What's included**:
  - GitHub Pro account (free for students/educators)
  - Unlimited private repositories
  - GitHub Actions: 2,000 free minutes/month for private repos (unlimited for public)
  - GitHub Packages: 500MB free storage
  - GitHub Copilot: free for students/educators
  - GitHub Codespaces: 90 hours free/month
  - GitHub Enterprise Server: not included (use GitHub Pro)
- **Documentation**: https://education.github.com/pack
- **Use cases for this project**:
  - Private repos for `agent-observatory-kernel`, `agent-observatory-contracts`, `agent-observatory-studio`, `agent-observatory-mcp-bridge`, `vibe-vibe-create-sdk`
  - GitHub Actions CI/CD for all 5 repos
  - GitHub Packages for npm/PyPI publication
  - GitHub Copilot for code assistance (if Claude Code is not used)
  - GitHub Codespaces for cloud dev environment

### §1.2 NVIDIA Developer Account
- **Status**: Verified and accessible
- **What's included**:
  - NVIDIA NGC catalog access (pre-trained models, containers)
  - NVIDIA GPU Cloud (NGC) registry
  - NVIDIA Deep Learning SDK (TensorRT, cuDNN, CUDA toolkit)
  - NVIDIA Nsight Systems/Compute (profiling tools)
  - Free credits for NVIDIA GPU compute (varies; check NVIDIA Developer portal)
- **Documentation**: https://developer.nvidia.com
- **Use cases for this project**:
  - Local LLM via Ollama (provider-agnostic LLM router per `specs/autoloop-yml-schema.md`)
  - Self-hosted LLM inference (Llama 3.1 70B, Mistral, etc.) for fallback chain
  - Profiling `agent-observatory-kernel` Python service performance
  - GPU-accelerated evidence synthesis (if needed)

### §1.3 Azure for Builders
- **Status**: Verified and accessible
- **What's included**:
  - Azure free account ($200 credit + 12 months free services)
  - Azure App Service (10 web apps free)
  - Azure Functions (1M executions free)
  - Azure Storage (5GB free)
  - Azure Monitor (free tier)
  - Azure DevOps (free for up to 5 users)
  - Azure OpenAI Service (if available in region)
- **Documentation**: https://azure.microsoft.com/free
- **Use cases for this project**:
  - Azure App Service for `agent-observatory-kernel` (alternative to Railway/Fly.io)
  - Azure Functions for cron jobs (daily digest image generator)
  - Azure Storage for `artifacts/verdicts/` persistence (alternative to IPFS)
  - Azure Monitor for kernel service monitoring
  - Azure OpenAI Service for LLM provider (if GPT-4 access is needed; alternative to direct OpenAI)

### §1.4 AWS Builder ID
- **Status**: Verified and accessible
- **What's included**:
  - AWS Free Tier (12 months free)
  - Amazon EC2 (750 hours/month free for t2.micro)
  - Amazon S3 (5GB free)
  - AWS Lambda (1M executions free)
  - Amazon CloudWatch (10 metrics + 10 alarms free)
  - AWS CodePipeline (free for up to 5 pipelines)
- **Documentation**: https://aws.amazon.com/free
- **Use cases for this project**:
  - Amazon EC2 for `agent-observatory-kernel` (alternative to Railway/Fly.io)
  - Amazon S3 for `artifacts/verdicts/` persistence (alternative to IPFS)
  - AWS Lambda for cron jobs (daily digest image generator)
  - Amazon CloudWatch for kernel service monitoring
  - AWS CodePipeline for CI/CD (alternative to GitHub Actions if minutes are exhausted)

---

## §2. ACCESS REQUEST PROTOCOL

### §2.1 Open a GitHub Issue
To request access to any infrastructure package, open a GitHub Issue in the relevant repo with the following:

**Title**: `[Infra Request] <Service Name> for <Repo Name>`

**Labels**: `infra-request`, `<service-name>` (e.g., `nvidia`, `azure`, `aws`)

**Body**:
```markdown
## Service Requested
<service name, e.g., "Azure App Service">

## Purpose
<one-sentence description of why this service is needed>

## Repo
<repo name>

## Estimated Cost
<monthly cost, e.g., "$0 (free tier)" or "$50/month">

## Estimated Duration
<how long access is needed, e.g., "permanent" or "3 months">

## Acceptance Criteria
- [ ] Service provisioned
- [ ] Credentials/access provided to engineer
- [ ] Service integrated with codebase
- [ ] Documentation updated
```

### §2.2 User Response Time
The user will respond within 24 hours of the issue being opened. Response will be in Persian (per `COMMUNICATION_PROTOCOL.md` §1.1).

### §2.3 Access Provisioning
The user will provide:
- Credentials (NEVER commit to git — use GitHub Actions secrets or .env files)
- Or: IAM role / service principal for cloud resources
- Or: SSH key for VMs
- Or: API token for SaaS services

### §2.4 Access Revocation
The user will rotate credentials quarterly or upon project completion. The user will notify the team 7 days before rotation to ensure no service interruption.

---

## §3. RECOMMENDED INFRASTRUCTURE STACK

Based on the project requirements (5 repos, multi-language, multi-region for EU compliance), the recommended stack is:

### §3.1 Hosting
- `agent-observatory-kernel`: Railway (primary) or Fly.io (alternative) — Python service
- `agent-observatory-studio`: Vercel — Next.js 16
- `agent-observatory-mcp-bridge`: NOT hosted (local process on operator's machine)
- `agent-observatory-contracts`: NOT hosted (Solidity contracts deployed to Robinhood Chain Testnet)
- `vibe-vibe-create-sdk`: NOT hosted (npm package)

### §3.2 CI/CD
- GitHub Actions (primary — 2,000 free minutes/month for private repos via GitHub Education)
- AWS CodePipeline (alternative if GitHub Actions minutes exhausted)

### §3.3 Monitoring
- Sentry (error monitoring — free tier for 5K errors/month)
- Logtail or Logz.io (log aggregation — free tier)
- Better Uptime or UptimeRobot (uptime monitoring — free tier)
- Azure Monitor or Amazon CloudWatch (alternative)

### §3.4 LLM Provider Fallbacks (per `specs/autoloop-yml-schema.md`)
- Primary: Anthropic Claude 3.5 Sonnet (paid API)
- Fallback 1: OpenAI Codex GPT-5.6 (paid API)
- Fallback 2: Z.AI GLM-4.5 (paid API)
- Fallback 3: MiniMax Text-01 (paid API)
- Fallback 4: HuggingFace Router (paid API)
- Fallback 5: Ollama Llama 3.1 70B (self-hosted on NVIDIA GPU — free)

### §3.5 Storage
- IPFS (primary — web3.storage free tier 100GB)
- Azure Storage (alternative — 5GB free)
- Amazon S3 (alternative — 5GB free)

### §3.6 Discord Bot Hosting
- Railway (primary — supports Node.js + Discord.js)
- AWS EC2 (alternative)

---

## §4. COST ESTIMATE (FREE TIER MAXIMIZATION)

| Service | Free Tier | Estimated Monthly Cost |
|---|---|---|
| GitHub Pro (Education) | All repos private + 2K Actions minutes | $0 |
| Railway | $5 free credit/month | $0 (for small kernel service) |
| Vercel | Free for personal Next.js | $0 |
| Sentry | 5K errors/month free | $0 |
| Logtail | 1GB logs free | $0 |
| Better Uptime | 10 monitors free | $0 |
| IPFS (web3.storage) | 100GB free | $0 |
| Anthropic Claude API | Pay-per-use | ~$50/month (varies with usage) |
| OpenAI API | Pay-per-use | ~$30/month (varies with usage) |
| Z.AI API | Pay-per-use | ~$20/month (varies with usage) |
| Ollama (self-hosted) | Free | $0 (uses local GPU) |
| **Total** | | **~$100/month** (LLM API costs only) |

If the user prefers to minimize LLM API costs, use Ollama (Llama 3.1 70B) as the primary provider via NVIDIA GPU (self-hosted). Estimated cost: $0/month.

---

## §5. SECURITY CONSIDERATIONS

### §5.1 Secret Rotation
- GitHub PAT: rotate after each session (per `COMMUNICATION_PROTOCOL.md` §6.4)
- Discord token: rotate after each session (per user's stated protocol)
- LLM API keys: rotate quarterly
- Robinhood Trading MCP OAuth: rotate per Robinhood's policy

### §5.2 EU Data Residency (for Reg S compliance)
- For `agent-observatory-kernel` hosting: prefer EU regions (Railway Frankfurt, Fly.io Amsterdam, Azure West Europe, AWS eu-west-1)
- For `artifacts/` storage: prefer IPFS (decentralized) or Azure Storage West Europe
- For LLM API calls: Anthropic, OpenAI, Z.AI all have EU data residency options — enable if available

### §5.3 Audit Trail
- All infrastructure access requests documented in GitHub Issues
- All secrets stored in GitHub Actions secrets (audit log available)
- All LLM API calls logged (provider-side + local logs)
- All verdicts persisted to `artifacts/verdicts/` (immutable file-first state per §2.1 of AGENT_INSTRUCTIONS.md)

