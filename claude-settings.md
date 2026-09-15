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

To switch to default mode of auto:

```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```
