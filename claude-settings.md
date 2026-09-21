For `--dangerously-skip-permissions` by default (along with other useful settings):

```json
{
  "cleanupPeriodDays": 3650,
  "permissions": {
    "defaultMode": "bypassPermissions"
  },
  "model": "opus[1m]",
  "worktree": {
    "bgIsolation": "none"
  },
  "skipDangerousModePermissionPrompt": true
}
```

For auto mode by default:

```json
{
  "cleanupPeriodDays": 3650,
  "permissions": {
    "defaultMode": "auto"
  },
  "model": "opus[1m]",
  "worktree": {
    "bgIsolation": "none"
  }
}
```

## Prevent Regular Re-Authentication

If you are already logged in, start with doing this in Claude:

```
/logout
```

Run:

```bash
claude setup-token
```

Save to `~/.bashrc`:

```
export CLAUDE_CODE_OAUTH_TOKEN=...
```

Test if things are working:

```
claude -p "say hi"
```

**If Claude still prompts you to log in, the fix is to add this to** `~/.claude.json`:

```
"hasCompletedOnboarding": true
```
