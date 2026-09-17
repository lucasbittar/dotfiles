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
  build-essential btop curl wget git fd-find fzf neovim tmux xclip zsh eza
```

Additional tools (install individually):

- **Starship prompt**: `curl -sS https://starship.rs/install.sh | sh`
- **diff-so-fancy**: `sudo snap install diff-so-fancy` (or `npm install -g diff-so-fancy`)
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
brew install bat btop eza fd fzf git moreutils neovim python3 ripgrep wget tmux yt-dlp starship diff-so-fancy
```

Core applications:
```bash
brew install --cask google-chrome firefox docker-desktop slack spotify vlc karabiner-elements ghostty zoom microsoft-teams rectangle
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
- The `docker` cask is now named **`docker-desktop`**. The old name still resolves via
  alias, but use the new one.
- Docker Desktop and Karabiner-Elements each need an approval in
  System Settings → Privacy & Security on first launch.

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
```

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

`Terminal` is no longer in the kill list, so running this from Terminal.app no longer
kills its own session mid-run.

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
