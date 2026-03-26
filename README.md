# SysConfig

Shared dotfiles and settings across machines. Clone to `~/Library/SysConfig`
(macOS) or `~/sysconfig` (Linux), then run `install.sh` to symlink everything
into place.

## Setup

```sh
./install.sh
```

This creates symlinks in `$HOME` for: `.emacs`, `.bashrc`, `.bash_profile`,
`.zshrc`, `.zprofile`, `.vimrc`, `.vim`, `.ctags`, and `.starship.toml`.

## Requirements

### Emacs

Requires **Emacs 29+** (for built-in `use-package` and `eglot`). Tested on
Emacs 29.3 (Ubuntu 24.04) through Emacs 30.2 (macOS).

MELPA packages (auto-installed on first launch): doom-themes, company,
which-key, go-mode, markdown-mode, xterm-color.

Backups go to `~/Backup/` -- create that directory if it doesn't exist.

### LSP Servers

Eglot provides LSP integration (jump-to-definition with `M-.`,
find-references with `M-?`, jump-back with `M-,`, hover docs, diagnostics,
and completions). Install the language servers externally:

**Go** (gopls + goimports):
```sh
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
```

**Python** (pyright):
```sh
npm install -g pyright
```

**C/C++** (clangd):
```sh
# macOS
brew install llvm

# Ubuntu/Debian
apt install clangd
```

### Starship Prompt

The zsh config uses [Starship](https://starship.rs/):

```sh
# macOS
brew install starship

# Linux
curl -sS https://starship.rs/install.sh | sh
```

## Per-Machine Secrets

For API tokens or other secrets that shouldn't be checked in, put them in
`~/.secrets` and source it from your shell config:

```sh
[[ -f ~/.secrets ]] && source ~/.secrets
```
