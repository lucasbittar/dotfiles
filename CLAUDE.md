# Dotfiles Setup Playbook

This is a dotfiles repo for macOS and Linux (Ubuntu/Pop!_OS). When asked to
"set up this machine", follow every section below in order. Ask the user before
installing anything marked **optional**.

---

## 1. Detect Environment

```bash
OS=$(uname -s)   # Darwin = macOS, Linux = Linux
```

Use `$OS` to branch on platform-specific steps throughout this guide.

---

## 2. Create Directories

```bash
mkdir -p ~/Code
mkdir -p ~/.local/scripts
mkdir -p ~/.zsh/plugins
mkdir -p ~/.config/ghostty
mkdir -p ~/.config
```

---

## 3. Install Packages

### Linux (apt + other methods)

```bash
sudo apt update && sudo apt install -y \
  build-essential btop curl wget git fd-find fzf golang-go gopls jq neovim tmux xclip zsh eza
```

Additional tools (install individually):

- **Starship prompt**: `curl -sS https://starship.rs/install.sh | sh`
- **delta** (git's pager, set in `.gitconfig`): `sudo apt install -y git-delta` on Ubuntu
  23.04+; on older releases (Pop!_OS 22.04) install the `.deb` from
  https://github.com/dandavison/delta/releases with `sudo dpkg -i`
- **Google Chrome**: download the `.deb` from https://www.google.com/chrome/ and install with `sudo dpkg -i`
- **Ghostty**: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"`

Communication apps:
```bash
sudo snap install slack teams-for-linux
```
- **Zoom**: download `.deb` and install (snap has sandboxing issues):
  ```bash
  wget -O /tmp/zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
  sudo dpkg -i /tmp/zoom_amd64.deb
  ```

Fonts:
```bash
sudo apt install -y fonts-firacode
```

- **Optional** (ask user first): Spotify, VLC, EasyEffects, Zig

WiFi drivers (MacBook Pro running Linux — Broadcom BCM4360):
```bash
sudo apt install -y bcmwl-kernel-source broadcom-sta-dkms b43-fwcutter
```
Reboot after installing. The `wl` kernel module should load automatically. If WiFi
still doesn't work, try `sudo modprobe wl`.

### macOS (Homebrew)

If Homebrew is not installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Core CLI tools:
```bash
brew install bat btop eza fd fzf git go gopls jq moreutils neovim python3 ripgrep wget tmux tree-sitter-cli yt-dlp starship git-delta
```

Core applications:
```bash
brew install --cask google-chrome firefox docker-desktop slack spotify vlc karabiner-elements ghostty zoom microsoft-teams rectangle notion hammerspoon beekeeper-studio
```

Fonts:
```bash
brew install --cask font-hack-nerd-font font-fira-code
```

Notes:
- **Apple Silicon**: Homebrew installs to `/opt/homebrew`, not `/usr/local`. `zsh/.zshrc`
  runs `eval "$(/opt/homebrew/bin/brew shellenv)"` (guarded) to put `brew`, `starship`,
  `eza` and `fzf` on PATH. Without that, the section 14 checks for the prompt, fzf
  keybindings and aliases all fail.
- Docker's cask is **`docker-desktop`**.
- Docker Desktop and Karabiner-Elements each need an approval in
  System Settings → Privacy & Security on first launch.
- **Hammerspoon** handles the app-switch shortcuts (`Ctrl+1`–`Ctrl+4`: Ghostty, Chrome,
  Slack, Notion) instead of Karabiner. Karabiner's `shell_command` runs on the Mac the
  keyboard is paired with, so under Universal Control it switched apps on the wrong Mac;
  plain keys are forwarded, so the Mac with the pointer handles them. Install it on
  every Mac that shares the keyboard. The old Karabiner rules are kept in
  `karabiner/backup/app-switch-rules.json`.
- **Beekeeper Studio** is the only SQL client.
  Connections live in `~/Library/Application Support/beekeeper-studio/app.db`, with
  passwords encrypted using the per-install key in that directory's `.key`. Its ER
  diagrams (Tools → Open ER Diagram) need a paid licence — every download includes a
  14-day trial, after which the rest of the app stays free as the Community Edition.
- Hammerspoon needs **Accessibility** permission (System Settings → Privacy & Security →
  Accessibility). macOS reserves `Ctrl+1` for "Switch to Desktop 1" even while that
  shortcut is disabled, so Hammerspoon can't register it as a hotkey and catches it
  with an event tap instead, which needs the permission.
- Karabiner does not always notice edits to `karabiner.json` through the symlink. If a
  change doesn't take effect, restart its services:
  ```bash
  launchctl kickstart -k gui/$(id -u)/org.pqrs.service.agent.Karabiner-Core-Service-rev2
  launchctl kickstart -k gui/$(id -u)/org.pqrs.service.agent.Karabiner-Console-User-Server
  ```

**Optional** (ask user first):
```bash
brew install --cask dropbox alfred appcleaner the-unarchiver
```

---

## 4. Keyboard Configuration (Linux only)

Remap Caps Lock to Ctrl:
```bash
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
```

Set fast key repeat (200ms delay, 20ms repeat):
```bash
gsettings set org.gnome.desktop.peripherals.keyboard delay 200
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
```

Install Input Remapper for system-wide vim navigation (Ctrl+HJKL → arrow keys):
```bash
sudo apt install -y input-remapper
```
After installing, open Input Remapper and create a "VIM Navigation" preset for the
keyboard with these mappings:
- Ctrl+H → Left
- Ctrl+J → Down
- Ctrl+K → Up
- Ctrl+L → Right

---

## 5. Shell Setup

Set zsh as the default shell:
```bash
chsh -s $(which zsh)
```

On modern macOS this is already the default and the command is a no-op; check with
`dscl . -read /Users/$(whoami) UserShell` before bothering (it prompts for a password).

Install zsh plugins manually:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/plugins/zsh-completions
git clone https://github.com/rupa/z.git ~/.zsh/plugins/z
```

---

## 6. Node.js Setup

Install nvm:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

Then install the latest LTS version of Node:
```bash
nvm install --lts
```

### Chrome DevTools MCP (Claude Code and Cursor)

Gives coding agents a Chrome to drive: load pages, take screenshots, read the console
and network requests, run performance traces. It runs through `npx`, so set up Node
first. `--headless` keeps the agent's Chrome from opening a window; drop it to watch
what the agent does.

Claude Code (user scope, so every project gets it; config lands in `~/.claude.json`):
```bash
claude mcp add chrome-devtools --scope user -- npx -y chrome-devtools-mcp@latest --headless
```

Cursor (the `cursor-agent` CLI and the editor) does not read Claude Code's config. Its
global servers live in `~/.cursor/mcp.json`; merge the entry in, keeping any others:
```bash
f=~/.cursor/mcp.json; mkdir -p ~/.cursor; [ -f "$f" ] || echo '{}' > "$f"
jq '.mcpServers["chrome-devtools"] = {command: "npx", args: ["-y", "chrome-devtools-mcp@latest", "--headless"]}' "$f" > "$f.new" && mv "$f.new" "$f"
```

The two configs are separate, so change both when changing the server's flags. Check
with `claude mcp get chrome-devtools` (expect `✔ Connected`) and `cursor-agent mcp list`
(expect `chrome-devtools: ready`). New tools only appear in sessions started afterwards.

---

## 7. Create Symlinks

Use `ln -sf` for each link. The repo should be cloned to `~/.dotfiles`.

### Both platforms

```bash
ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/.gitignore ~/.gitignore
ln -sf ~/.dotfiles/git/.extras ~/.extras
ln -sf ~/.dotfiles/shell/aliases/aliases/.aliases ~/.aliases
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/tmux/.ready-tmux ~/.ready-tmux
ln -sf ~/.dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/.dotfiles/zsh/starship.toml ~/.config/starship.toml

# Neovim (symlink the directory)
ln -sf ~/.dotfiles/nvim/.config/nvim ~/.config/nvim
```

### macOS only

```bash
# Karabiner
ln -sf ~/.dotfiles/karabiner/.config/karabiner ~/.config/karabiner

# Hammerspoon (link the file: Hammerspoon keeps its own data in ~/.hammerspoon)
mkdir -p ~/.hammerspoon
ln -sf ~/.dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua
```

Then launch Hammerspoon once (`open -a Hammerspoon`) and grant it Accessibility
permission; `init.lua` enables launch at login.

---

## 8. Local Scripts

Copy scripts and make them executable:
```bash
cp ~/.dotfiles/local/scripts/* ~/.local/scripts/
chmod +x ~/.local/scripts/*
```

---

## 9. Tmux Plugin Manager

Install TPM:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

The `.tmux.conf` already declares these TPM plugins:
- **tmux-sensible** — sensible defaults
- **tmux-resurrect** — save/restore sessions (`prefix + Ctrl-s` / `prefix + Ctrl-r`)
- **tmux-continuum** — automatic session restore on tmux start

Tell the user to open tmux and press `prefix + I` to install plugins.

Or install them without the manual step:
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

---

## 10. Neovim Plugins

Tell the user to open nvim and run:
```
:PlugInstall
```

Or install them without the manual step:
```bash
nvim --headless +PlugInstall +qall
```
Plugins land in `~/.local/share/nvim/plugged`. Requires Node for `coc.nvim`, so run
this after section 6.

These plugins need a step that `:PlugInstall` does **not** cover:

- **`vim-ai`** needs `pynvim`. On macOS, `init.vim` points `g:python3_host_prog` at a
  venv that the repo does not ship (it is gitignored), so create it:
  ```bash
  python3 -m venv ~/.config/nvim/venv/nvim-python-stable
  ~/.config/nvim/venv/nvim-python-stable/bin/python3 -m pip install pynvim
  ```
  On Linux it uses `/usr/bin/python3`, so install `pynvim` for that interpreter.
  Without it, every nvim start prints "Python 3 support is required for vim-ai plugin".
  Verify with `:echo has('python3')` (expect `1`).

- **`nvim-treesitter`** (the `main` branch) compiles a parser per language, which needs
  the `tree-sitter` CLI (0.26.1+, installed in section 3 on macOS; on Linux use
  `cargo install tree-sitter-cli` — the apt package is too old, and the plugin says
  not to use npm) and a C compiler. `init.vim` installs the parser list on start, in
  the background; to build them up front instead:
  ```bash
  nvim --headless -c 'lua require("nvim-treesitter").install({"go","gomod","gosum","python","javascript","typescript","tsx","json","html","css","scss","yaml","toml","bash","lua","vim","vimdoc","markdown","markdown_inline","dockerfile","sql","prisma"}):wait(600000)' -c qa
  ```
  Parsers land in `~/.local/share/nvim/site/parser`. Check with
  `:checkhealth nvim-treesitter`. Without the CLI, files fall back to the old regex
  syntax highlighting.

- **Theme**: `colors/benokai.lua` (Monokai colours on the terminal's background)
  colours Tree-sitter captures and coc's semantic tokens. `coc-settings.json` turns
  semantic tokens on (`gopls` needs `go.goplsOptions.semanticTokens` too), and
  `init.vim` sets `g:coc_default_semantic_highlight_groups = 0` so coc's default
  links don't override Tree-sitter's finer colours. A `CursorHold` autocmd
  highlights every reference to the symbol under the cursor (`CocHighlightText`,
  `CocHighlightWrite` for assignments).

- **`diffview.nvim`** is for reviewing changes: `,gd` toggles a view of every
  uncommitted change, `,gD` reviews the whole branch against `origin/HEAD`
  (uncommitted changes included), `,gh` shows the current file's history, and `q`
  closes it. `,gD` needs `origin/HEAD`, which `git clone` sets; for a repo that was
  `git init`-ed and pushed, run `git remote set-head origin -a` once. In the terminal,
  `gd` (`git diff`) goes through `delta`, themed with the same diff colours.

- **`coc-go`** uses the system `gopls` (installed in section 3), not its own copy:
  `coc-settings.json` sets `"go.goplsPath": "gopls"`, so `brew upgrade` keeps it
  current. coc-go's own update check is broken — it looks for `gopls/` tags on the
  first page of GitHub's `golang/tools` tags, which no longer has any — and warned
  "checking for a new gopls version failed" daily. Setting `goplsPath` skips it. If
  `gopls` is missing from PATH, Go files show "goplsPath is configured … but does not
  exist!".

- **`markdown-preview.nvim`** needs its prebuilt browser binary. The
  `mkdp#util#install()` hook does not run under headless `:PlugInstall`, so fetch it
  directly:
  ```bash
  bash ~/.local/share/nvim/plugged/markdown-preview.nvim/app/install.sh
  ```
  It picks the right build per `uname -sm` (`markdown-preview-macos-arm64` on Apple
  Silicon). Then `,m` toggles the preview from any markdown buffer.

  Relative links to other markdown files (`[x](./other.md)`, `../other.md`) open in
  the preview thanks to `nvim/.config/nvim/patches/markdown-preview-local-links.patch`,
  which the plugin's `do` hook in `init.vim` applies to `app/routes.js`. The patched
  file is read by the prebuilt binary at server start (`--path app/server.js`), so no
  rebuild is needed — but a preview server that is already running must be restarted
  (`:MarkdownPreviewStop`, then `,m` again).

  vim-plug runs `do` hooks only for plugins it just installed or updated
  (`autoload/plug.vim`, `s:do()`), so the hook does **not** fire on a plain
  `:PlugInstall` over an already-installed plugin. Force it:
  ```
  :PlugInstall! markdown-preview.nvim
  ```
  Or apply the patch by hand. Unlike the hook, this doesn't check first: on a plugin
  that is already patched, `git apply` fails with "patch does not apply", which is
  harmless:
  ```bash
  git -C ~/.local/share/nvim/plugged/markdown-preview.nvim apply ~/.config/nvim/patches/markdown-preview-local-links.patch
  ```
  Check whether it is applied with
  `grep -c 'local markdown links' ~/.local/share/nvim/plugged/markdown-preview.nvim/app/routes.js`.

---

## 11. Git & SSH Setup

Generate an SSH key for GitHub:
```bash
ssh-keygen -t ed25519 -C "user@email.com" -f ~/.ssh/github
```

Ask the user for their email before running this command.

Add SSH config:
```bash
cat >> ~/.ssh/config << 'EOF'
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/github
  IdentitiesOnly yes
EOF
```

Copy the public key to clipboard:
- Linux: `xclip -selection clipboard < ~/.ssh/github.pub`
- macOS: `pbcopy < ~/.ssh/github.pub`

Tell the user to add the key at https://github.com/settings/ssh/new

Test the connection:
```bash
ssh -T git@github.com
```

---

## 12. Clone Personal Repos

All personal projects live in `~/Code`. Clone over **SSH**, not HTTPS — several of
these repos are private, and HTTPS would prompt for a username and a personal access
token on every clone, fetch and push. SSH uses the key from section 11 and just works
once the key is on the account.

Requires section 11 to be complete, including adding the public key at
https://github.com/settings/ssh/new. Verify first:

```bash
ssh -T git@github.com   # expect: "Hi <user>! You've successfully authenticated..."
```

Then clone:

```bash
mkdir -p ~/Code && cd ~/Code
for repo in pv7 personal-site cartadeadeus myscrobble weatherapp; do
  [ -d "$repo" ] || git clone "git@github.com:lucasbittar/$repo.git"
done
```

| Repo | Visibility |
| --- | --- |
| `pv7` | private |
| `personal-site` | public |
| `cartadeadeus` | private |
| `myscrobble` | public |
| `weatherapp` | public |

If a repo was already cloned over HTTPS, switch its remote to SSH:

```bash
cd ~/Code/<repo>
git remote set-url origin git@github.com:lucasbittar/<repo>.git
```

---

## 13. macOS System Preferences (macOS only)

Run the macOS defaults script:
```bash
bash ~/.dotfiles/.macos
```

The cleanup loop force-quits Chrome, Finder, Dock, Mail, Messages, Safari, Calendar,
Contacts and Activity Monitor **without saving**, so close unsaved work first. It also
wipes the Dock's persistent apps (`persistent-apps -array`), so you will rebuild the
Dock afterward. Needs an interactive sudo password, and some changes — including the
key repeat rate — only apply to apps launched after a logout.

`Terminal` is not in the kill list, so the script is safe to run from Terminal.app.

---

## 14. Verification Checklist

After setup, verify each of these:

- [ ] `echo $SHELL` shows zsh
- [ ] Starship prompt is rendering
- [ ] `nvim` opens without errors
- [ ] `tmux` starts correctly
- [ ] `fzf` keybindings work (Ctrl+R for history, Ctrl+T for files)
- [ ] Aliases are loaded (`type ll` should show the eza alias)
- [ ] `git` is configured (`git config user.name` returns a value)
- [ ] `ssh -T git@github.com` authenticates successfully
- [ ] Personal repos are cloned into `~/Code` (section 12)
- [ ] `top` launches btop
- [ ] Rectangle is running (macOS window snapping; needs Accessibility permission)
- [ ] Hammerspoon is running and `Ctrl+1`–`Ctrl+4` switch apps on the Mac the pointer
      is on (Ghostty, Chrome, Slack, Notion)
- [ ] `claude mcp get chrome-devtools` and `cursor-agent mcp list` show the Chrome
      DevTools MCP connected (section 6)
