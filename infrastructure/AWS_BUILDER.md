# AWS Builder ID

**Status**: Verified and accessible by the user.

## What's Included

- AWS Free Tier (12 months free)
- Amazon EC2 (750 hours/month free for t2.micro)
- Amazon S3 (5GB free)
- AWS Lambda (1M executions free)
- Amazon CloudWatch (10 metrics + 10 alarms free)
- AWS CodePipeline (free for up to 5 pipelines)

## Documentation

- https://aws.amazon.com/free

## Use Cases for AgentObservatory v2

- Amazon EC2 for `agent-observatory-kernel` (alternative to Railway/Fly.io/Azure App Service)
- Amazon S3 for `artifacts/verdicts/` persistence (alternative to IPFS/Azure Storage)
- AWS Lambda for cron jobs (daily digest image generator — alternative to Azure Functions)
- Amazon CloudWatch for kernel service monitoring (alternative to Azure Monitor)
- AWS CodePipeline for CI/CD (alternative to GitHub Actions if minutes are exhausted)

## EU Data Residency (for Reg S Compliance)

For `agent-observatory-kernel` hosting: prefer AWS eu-west-1 (Ireland) region.
For `artifacts/` storage: prefer Amazon S3 eu-west-1.

## How to Request Access

See `ACCESS_PROTOCOL.md` for the access request protocol.
