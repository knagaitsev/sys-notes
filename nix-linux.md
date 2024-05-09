Start by cloning: `https://github.com/NixOS/nixpkgs`

Then in the root we can run the following:

```bash
nix-shell -I "nixpkgs=$(pwd)" -A linux_5_15 --pure
```

Alternatively we can start the REPL and then do the following:

```
nix repl -I "nixpkgs=$(pwd)"
nix-repl> pkgs = import <nixpkgs> {}
```

tab completion can then be used with `pkgs.` to find things
