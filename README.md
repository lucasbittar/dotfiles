# dotfiles

Cross-platform dotfiles for macOS and Linux (Ubuntu/Pop!_OS). Configs for zsh, neovim, tmux, git, Ghostty, Starship, and more.

## Setup

On a fresh machine:

1. Install [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
2. Clone this repo to `~/.dotfiles`
3. Run Claude Code and ask it to **set up this machine**

Claude reads `CLAUDE.md` and walks through installing packages, creating symlinks, configuring the shell, and everything else needed to get a fully working environment.

## What's included

- **zsh** — config with Starship prompt, vi mode, fzf integration, manually sourced plugins
- **neovim** — full config with plugin support
- **tmux** — config with TPM, ready-tmux script, tmux-sessionizer
- **git** — gitconfig, global gitignore, extras, diff-so-fancy
- **Ghostty** — terminal config
- **Starship** — prompt theme
- **shell aliases** — shared + OS-specific aliases
- **macOS** — system defaults script, Karabiner, iTerm2 config

## License

The code is available under the MIT license.
