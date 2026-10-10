# Azure for Builders

**Status**: Verified and accessible by the user.

## What's Included

- Azure free account ($200 credit + 12 months free services)
- Azure App Service (10 web apps free)
- Azure Functions (1M executions free)
- Azure Storage (5GB free)
- Azure Monitor (free tier)
- Azure DevOps (free for up to 5 users)
- Azure OpenAI Service (if available in region)

## Documentation

- https://azure.microsoft.com/free

## Use Cases for AgentObservatory v2

- Azure App Service for `agent-observatory-kernel` (alternative to Railway/Fly.io)
- Azure Functions for cron jobs (daily digest image generator)
- Azure Storage for `artifacts/verdicts/` persistence (alternative to IPFS)
- Azure Monitor for kernel service monitoring
- Azure OpenAI Service for LLM provider (if GPT-4 access is needed; alternative to direct OpenAI)

## EU Data Residency (for Reg S Compliance)

For `agent-observatory-kernel` hosting: prefer Azure West Europe (`westeurope`) region.
For `artifacts/` storage: prefer Azure Storage West Europe.

## How to Request Access

See `ACCESS_PROTOCOL.md` for the access request protocol.
