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

sudo apt install alacritty;


mkdir ~/Documents/tools & cd ~/Documents/tools;

git clone https://github.com/arthaud/git-dumper.git;
git clone https://github.com/micahvandeusen/gMSADumper.git;
git clone https://github.com/urbanadventurer/username-anarchy.git;
git clone https://github.com/dirkjanm/PKINITtools.git;
git clone https://github.com/ShutdownRepo/pywhisker.git;
git clone https://github.com/ShutdownRepo/targetedKerberoast.git;
wget -o https://github.com/KickedDroid/ls-ad-users/raw/refs/heads/master/ls-ad-users;
git clone https://github.com/jalvarezz13/Krb5RoastParser.git;







