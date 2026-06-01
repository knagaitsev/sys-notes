## code-server Extension Notes

Check for extensions here: https://open-vsx.org/?sortBy=downloadCount&sortOrder=desc

List extensions like so:

```bash
code-server --list-extensions
```

Install extension:

```bash
code-server --install-extension meta.pyrefly
code-server --install-extension ms-python.python ms-python.vscode-python-envs ms-python.debugpy
```

Uninstall extension:

```bash
code-server --uninstall-extension ms-python.python
```

Fix issues with PET:

```
cd ~/.local/share/code-server/extensions/ms-python.python-2026.4.0-universal
mkdir -p python-env-tools/bin
cd python-env-tools/bin
cp ~/.vscode/extensions/ms-python.python-2026.4.0-darwin-arm64/python-env-tools/bin/pet .
```
