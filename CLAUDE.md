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
  build-essential curl wget git fd-find fzf neovim tmux xclip zsh eza
```

Additional tools (install individually):

- **Starship prompt**: `curl -sS https://starship.rs/install.sh | sh`
- **diff-so-fancy**: `sudo snap install diff-so-fancy` (or `npm install -g diff-so-fancy`)
- **Google Chrome**: download the `.deb` from https://www.google.com/chrome/ and install with `sudo dpkg -i`
- **Ghostty**: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"`

Fonts:
```bash
sudo apt install -y fonts-firacode
```

- **Optional** (ask user first): Spotify, VLC, EasyEffects, Zig

### macOS (Homebrew)

If Homebrew is not installed:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Core CLI tools:
```bash
brew install bat eza fd fzf git moreutils neovim python3 ripgrep wget tmux yt-dlp starship diff-so-fancy
```

Core applications:
```bash
brew install --cask google-chrome firefox docker slack spotify vlc karabiner-elements ghostty
```

Fonts:
```bash
brew install --cask font-hack-nerd-font font-fira-code
```

**Optional** (ask user first):
```bash
brew install --cask dropbox alfred appcleaner the-unarchiver zoom
```

---

## 4. Shell Setup

Set zsh as the default shell:
```bash
chsh -s $(which zsh)
```

Install zsh plugins manually:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/plugins/zsh-completions
git clone https://github.com/rupa/z.git ~/.zsh/plugins/z
```

---

## 5. Node.js Setup

Install nvm:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

Then install the latest LTS version of Node:
```bash
nvm install --lts
```

---

## 6. Create Symlinks

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

## 7. Local Scripts

Copy scripts and make them executable:
```bash
cp ~/.dotfiles/local/scripts/* ~/.local/scripts/
chmod +x ~/.local/scripts/*
```

---

## 8. Tmux Plugin Manager

Install TPM:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Tell the user to open tmux and press `prefix + I` to install plugins.

---

## 9. Neovim Plugins

Tell the user to open nvim and run:
```
:PlugInstall
```

---

## 10. Git & SSH Setup

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

## 11. macOS System Preferences (macOS only)

Run the macOS defaults script:
```bash
bash ~/.dotfiles/.macos
```

---

## 12. Verification Checklist

After setup, verify each of these:

- [ ] `echo $SHELL` shows zsh
- [ ] Starship prompt is rendering
- [ ] `nvim` opens without errors
- [ ] `tmux` starts correctly
- [ ] `fzf` keybindings work (Ctrl+R for history, Ctrl+T for files)
- [ ] Aliases are loaded (`type ll` should show the eza alias)
- [ ] `git` is configured (`git config user.name` returns a value)
