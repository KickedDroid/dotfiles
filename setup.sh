echo "[+] Starting Setup ...";

sudo apt install i3status dmenu &&

echo "[+] i3 installed, setting up config";

touch ~/.config/i3/config;
sudo curl -o ~/.config/i3/config https://raw.githubusercontent.com/KickedDroid/dotfiles/refs/heads/main/i3/config &&

echo "[+] i3 configured"; 

