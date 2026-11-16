# Wizard: Stripe setup

<!--
The textified wizard: the source of truth both scripts are built from.
Edit this file first, then rebuild the .sh (from template.sh) and the .ps1
(from template.ps1). Grammar:
- One `## Stage: <name>` heading per stage; their count is TOTAL_STAGES.
- One `- <helper>: <args>` bullet per library call, in order. Helpers are the
  library's: say, step, note, warn, open_url, pause, ask, ask_secret,
  write_env, set_secret, set_var. ask/ask_secret take `KEY | Prompt`;
  write_env/set_secret/set_var take `NAME` (value is the captured $NAME) or
  `NAME = literal`. A trailing `(...)` is a comment carried into both scripts.
- `- confirm: <question>` gates the bullets indented under it.
Replace the example below.
-->

Builds: `scripts/setup-stripe.sh`, `scripts/setup-stripe.ps1`

## Stage: Stripe: API keys

- say: We'll grab your Stripe test keys and store them for local dev + CI.
- open_url: https://dashboard.stripe.com/test/apikeys
- step: On the API keys page, copy the Publishable key (starts pk_test_).
- ask: STRIPE_PUBLISHABLE_KEY | Paste the publishable key:
- step: Click 'Reveal test key' on the Secret key row, then copy it.
- ask_secret: STRIPE_SECRET_KEY | Paste the secret key:
- write_env: STRIPE_PUBLISHABLE_KEY
- write_env: STRIPE_SECRET_KEY
- set_secret: STRIPE_SECRET_KEY (CI needs this one)
