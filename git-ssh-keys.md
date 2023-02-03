Alias to do a quick `ssh-add`:

```bash
alias sshadd='eval "$(ssh-agent)"; ssh-add;'
```

Easy way to add a local deploy key for a specific repository:

```bash
KEY_NAME=<name>
KEY_PATH=$HOME/.ssh/$KEY_NAME
ssh-keygen -C "label" -f $KEY_PATH -t ed25519

# before the next step, add this generated key as a deploy key to your repo

GIT_SSH_COMMAND='ssh -i $KEY_PATH' git clone <repo>
git config --add --local core.sshCommand 'ssh -i $KEY_PATH'
```
