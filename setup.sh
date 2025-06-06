echo "[+] Starting Setup ...";

sudo apt install i3 i3status dmenu &&

echo "[+] i3 installed, setting up config";

touch ~/.config/i3/config;
sudo curl -o ~/.config/i3/config https://raw.githubusercontent.com/KickedDroid/dotfiles/refs/heads/main/i3/config &&

echo "[+] i3 configured"; 

echo "[!] Starting rust configuration ...";

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;

cargo install --locked zellij;

cargo install rustscan; 

cargo install bottom; 

sudo apt install alacritty



