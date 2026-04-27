#!/bin/bash

set -euo pipefail

echo "[+] Initializing environment..."
BASE_DIR="$HOME"
TOOLS_DIR="$BASE_DIR/Documents/tools"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[+] Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "[!] Oh My Zsh already installed, skipping..."
fi

# Set Background 
mkdir -p "$BASE_DIR/Pictures/backgrounds"
wget -O "$BASE_DIR/Pictures/backgrounds/kali-bg.png" "https://github.com/KickedDroid/kickeddroid.github.io/blob/main/Assets/kali-background.png?raw=true"

# System Packages
echo "[+] Installing i3 and terminal utilities..."
sudo apt-get update -qq
sudo apt-get install -y -qq i3 i3status dmenu alacritty feh libpcap-dev golang
sudo apt-get install -y -qq faketime bloodyAD certipy-ad spice-vdagent alacritty

# i3 Config
CONFIG_DIR="$HOME/.config/i3"
mkdir -p "$CONFIG_DIR"
curl -fsSL "https://raw.githubusercontent.com/KickedDroid/dotfiles/refs/heads/main/i3/config" -o "$CONFIG_DIR/config"

# Rust and Cargo
echo "[+] Setting up Rust environment..."
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
source "$HOME/.cargo/env"

echo "[+] Installing Cargo tools (this may take a while)..."
cargo install -q --locked zellij rustscan zoxide bottom

# Zellij Config
mkdir -p "$HOME/.config/zellij"
wget -O "$HOME/.config/zellij/config.kdl" https://github.com/KickedDroid/dotfiles/raw/refs/heads/main/zellij/config.kdl

# Tooling Repositories
echo "[+] Cloning tool repositories..."
mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR"

declare -a REPOS=(
    "https://github.com/arthaud/git-dumper.git"
    "https://github.com/micahvandeusen/gMSADumper.git"
    "https://github.com/urbanadventurer/username-anarchy.git"
    "https://github.com/dirkjanm/PKINITtools.git"
    "https://github.com/ShutdownRepo/pywhisker.git"
    "https://github.com/ShutdownRepo/targetedKerberoast.git"
    "https://github.com/jalvarezz13/Krb5RoastParser.git"
)

for repo in "${REPOS[@]}"; do
    repo_name=$(basename "$repo" .git)
    if [ ! -d "$repo_name" ]; then
        git clone --depth 1 "$repo"
    fi
done

echo "[+] Building gopacket..."
if [ ! -d "gopacket" ]; then
    git clone https://github.com/mandiant/gopacket
    cd gopacket && ./install.sh --target native && cd ..
fi

echo "[+] Downloading ls-ad-users..."
wget -q -O "ls-ad-users" "https://github.com/KickedDroid/ls-ad-users/raw/refs/heads/master/ls-ad-users"
chmod +x "ls-ad-users"


echo "[+] Applying final .zshrc..."
wget -O "$HOME/.zshrc" https://github.com/KickedDroid/dotfiles/raw/refs/heads/main/.zshrc

echo "-------------------------------------------------------"
echo "[SUCCESS] Setup complete. Please restart your terminal."
echo "-------------------------------------------------------"
