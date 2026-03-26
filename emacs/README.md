# Emacs Code Navigation Cheat Sheet

## Eglot (LSP)

Active in Go, Python, C, and C++ buffers. Requires language servers
installed externally (see top-level README).

| Key | Command | Description |
|-----|---------|-------------|
| `M-.` | `xref-find-definitions` | Jump to definition |
| `M-?` | `xref-find-references` | Find all references |
| `M-,` | `xref-go-back` | Jump back after `M-.` |
| `C-x 4 .` | `xref-find-definitions-other-window` | Definition in split |
| `C-h .` | `eldoc` | Show docs/signature at point |
| `M-x eglot-rename` | | Rename symbol across project |
| `M-x eglot-code-actions` | | Quick fixes and refactors |
| `M-x imenu` | | Jump to function/type in current file |

## Selection

### expand-region

Each press expands to the next semantic unit: symbol, expression,
string contents, string with quotes, enclosing parens, block,
function body, function, etc.

| Key | Command | Description |
|-----|---------|-------------|
| `C-=` | `er/expand-region` | Expand selection one level |
| `C--` | `er/contract-region` | Contract selection one level |

### Built-in Selection

| Key | Description |
|-----|-------------|
| `C-M-SPC` | Select sexp at point |
| `C-M-h` | Select current function |
| `C-x h` | Select entire buffer |

## Structured Movement

These use syntax tables and work without LSP in any language mode.

| Key | Description |
|-----|-------------|
| `C-M-f` / `C-M-b` | Forward/backward by balanced expression |
| `C-M-u` / `C-M-d` | Up/down into nested parens/braces |
| `C-M-a` / `C-M-e` | Beginning/end of current function |
| `C-M-n` / `C-M-p` | Forward/backward over balanced groups (lists) |

## General Movement

| Key | Description |
|-----|-------------|
| `C-a` | Beginning of line / window / buffer (multi-tap) |
| `C-e` | End of line / window / buffer (multi-tap) |
| `C-n` / `C-p` | Forward/backward 10 lines |
| `M-g g` | Go to line number |
| `C-x ~` | Go to line number (custom binding) |
| `` ` `` | Jump to matching paren (on paren), otherwise insert backtick |

## Compilation

| Key | Description |
|-----|-------------|
| `C-x c` | Compile |
| `C-x `` ` | Jump to next error |

## Discovering Keybindings

**which-key** shows available completions after pressing a prefix key
and pausing briefly. For example, press `C-x` and wait to see all
`C-x` bindings. Press `C-h` and wait to see all help commands.

| Key | Description |
|-----|-------------|
| `C-h m` | Show all keybindings for current major and minor modes |
| `C-h k` *key* | Describe what a key does |
| `C-h f` *name* | Describe a function by name |
