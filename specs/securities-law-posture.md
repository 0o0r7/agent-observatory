# Securities-Law Compliance Posture

**Status**: Specified in `docs/01-specification-v2.md` §0.2.

## 7 Verbatim Assertions

1. **Howey prong analysis**: Per-holder commit-reveal pattern (§4) — holders submit their OWN verdicts; reflections distributed based on HOLDER's accuracy (NOT operator's). Fails "efforts of others" prong of Howey.

2. **Reg S transfer-restriction stack**: For agent-attested tokens paired with Stock Tokens, add: (i) whitelist-based transfer with KYC per transfer; (ii) Reg S legend in token metadata; (iii) custom `transfer()` override smart contract hook; (iv) Rule 902(c) "diligent inquiry" verification.

3. **CFTC event-contract disclaimer**: Commit-reveal pattern is NOT a swap, NOT an event contract, NOT a SEF.

4. **Investment Advisers Act disclaimer**: Operator is NOT acting as an investment adviser. Verdicts are public goods, not tailored advice.

5. **Transfer-agent disclaimer**: Phase-2 Reflections Router distributes based on ON-CHAIN BALANCE at snapshot block, NOT based on a maintained ledger.

6. **Control-person limitation**: Multi-sig scope limited to ratifying deterministic oracle output for slashing. Multi-sig does NOT initiate slashing.

7. **Dealer activity limitation**: Builder Grants Fund will NOT engage in secondary market purchases of agent-attested tokens.

See `../docs/01-specification-v2.md` §0.2 for the complete text.
