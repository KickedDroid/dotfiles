#!/bin/bash
set -euo pipefail   # abort on error, treat unset vars as failures

echo "[+] Installing i3, i3status and dmenu …"
sudo apt-get update -qq
sudo apt-get install -y -qq i3 i3status dmenu


CONFIG_URL="https://raw.githubusercontent.com/KickedDroid/dotfiles/refs/heads/main/i3/config"
CONFIG_DIR="${HOME}/.config/i3"

echo "[+] Setting up i3 configuration …"
mkdir -p "${CONFIG_DIR}"                     # create the directory if it doesn't exist
curl -fsSL "${CONFIG_URL}" -o "${CONFIG_DIR}/config"

echo "[+] i3 is installed and configured. Start it with 'startx' or log out/in.";

echo "[!] Starting rust configuration ...";

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;

cargo install --locked zellij;
cargo install rustscan; 
cargo install zoxide;
cargo install bottom; 
cargo install --locked alacritty

echo "[+] Cloning tools ..."

TOOLS_DIR="${HOME}/Documents/tools"
mkdir -p "${TOOLS_DIR}"
cd "${TOOLS_DIR}"

declare -a REPOS=(
    "https://github.com/arthaud/git-dumper.git"
    "https://github.com/micahvandeusen/gMSADumper.git"
    "https://github.com/urbanadventurer/username-anarchy.git"
    "https://github.com/dirkjanm/PKINITtools.git"
    "https://github.com/ShutdownRepo/pywhisker.git"
    "https://github.com/ShutdownRepo/targetedKerberoast.git"
    "https://github.com/jalvarezz13/Krb5RoastParser.git"
)

echo "[+] Cloning ${#REPOS[@]} repositories into ${TOOLS_DIR} …"
for repo in "${REPOS[@]}"; do
    git clone --depth 1 "${repo}"
done


LS_AD_USERS_URL="https://github.com/KickedDroid/ls-ad-users/raw/refs/heads/master/ls-ad-users"
LS_AD_USERS_FILE="${TOOLS_DIR}/ls-ad-users"

echo "[+] Downloading ls‑ad‑users script …"
wget -q -O "${LS_AD_USERS_FILE}" "${LS_AD_USERS_URL}"
chmod +x "${LS_AD_USERS_FILE}" 

echo "[+] All tools are now in ${TOOLS_DIR}"







