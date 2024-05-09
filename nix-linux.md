Start by cloning: https://github.com/NixOS/nixpkgs

Then in the root you can run the following:

```bash
nix-shell -I "nixpkgs=$(pwd)" -A linux_5_15 --pure
```

After that you can follow this guide: https://github.com/NixOS/nixpkgs/tree/master/pkgs/os-specific/linux/kernel

You can also start the REPL and then do the following:

```
nix repl -I "nixpkgs=$(pwd)"
nix-repl> pkgs = import <nixpkgs> {}
```

tab completion can then be used with `pkgs.` to find things
