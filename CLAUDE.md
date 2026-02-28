# CLAUDE.md

## Planning

- Always check `claude-plans/` directory for current architecture plans (if it exists)
- If making a complex plan, create a new plan file, and include the date in the plan filename to make it clear which plans were the most recent
- when creating a complex plan, switch to using model `Opus 4.6`, and before starting the implementation of the complex plan, go back to using model `Sonnet 4.6`

## Code style preferences

- Prefer clean, root-cause fixes over hacky patches. Don't just wrap things in try-catch without understanding why the error happens.
- When investigating bugs, explain the underlying mechanism before proposing a fix.

## Commit style

- Do not include "Co-Authored-By" or "written by Claude" tags in commits unless explicitly asked.
