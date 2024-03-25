sudo apt update && sudo apt upgrade
sudo apt install -y linux-headers-$(uname -r) build-essential bc dkms git libelf-dev rfkill iw
cd /tmp
git clone https://github.com/morrownr/88x2bu-20210702.git
cd 88x2bu
