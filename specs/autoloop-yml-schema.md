# autoloop.yml Schema Specification

**Status**: Specified in `docs/01-specification-v2.md` §3.

The full autoloop.yml schema is documented in the main specification. See `../docs/01-specification-v2.md` §3 for the complete schema including:

- `verdict_loop` (trigger, event_source, poll_interval_seconds, expose_verdict_block_height)
- `evidence_budget` (max_tokens_per_verdict, max_citations_per_verdict, evidence_repositories)
- `verdict_llm_provider` (primary, fallback_chain, retry_strategy, role)
- `evidence_llm_provider` (primary, fallback_chain, role)
- `summary_llm_provider` (primary, fallback_chain, role)
- `commit_reveal_window_blocks` (~1 hour on Robinhood Chain at 0.1s blocks)
- `accuracy_metric` (type: brier_score, rolling_window_days, promote_threshold, demote_threshold, paths)
- `promote_policy` (promote_on, demote_on, human_review_required_for_promotion, slash_on_inaccuracy, slash_amount)
- `fallback_to_paper_trade_on_mcp_error`
- `replay_html_renderer` (template, artifacts_dir, files)

This file is a placeholder; the canonical schema is in `../docs/01-specification-v2.md`.
