# Install alacritty and compton for i3 and setup compton for transparent blur
# alacritty for fedora
sudo dnf install alacritty
# compton dependancies for fedora
sudo dnf install libXcomposite-devel libXdamage-devel libXrandr-devel libXinerama-devel libconfig-devel mesa-libGL-devel dbus-devel asciidoc
# install compton
# Clone the repo
git clone https://github.com/tryone144/compton
# cd into the cloned repo
cd compton
# Make the main program
make
# Make docs
make docs
# Install (this will likely require root privileges)
make install
# Create compton.conf file for compton
touch ~/.config/compton.conf
# Paste the following lines into the config:
echo 'backend="glx";
glx-no-stencil = true;
glx-swap-method = "-1";

active-opacity = 0.85;
inactive-opacity = 0.85;
inactive-opacity-override = true;

blur-background = true;
blur-background-frame = true;
blur-method = "kawase";
blur-strength = 5;
blur-kern = "5x5gaussian";
blur-background-fixed = true;' > ~/.config/compton.conf
# Add compton to i3 config
echo "exec compton" > ~/.config/i3/config

# Add background image
echo "exec --no-startup-id feh --bg-fill ~/Pictures/wallpapers/wallpapers.jpeg" > ~/.config/i3/config
