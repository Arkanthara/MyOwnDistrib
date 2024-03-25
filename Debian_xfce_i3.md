# Install dependencies
sudo apt install libxcb1 libxcb1-dev xcb-proto libglib2.0-0 libglib2.0-dev gobject-introspection  libjson-glib-dev gtk-doc-tools autotools-dev 
sudo apt install pkg-config xfce4-dev-tools libgtk-4-dev libxfce4ui-2-dev xfce4-panel libxfce4panel-2.0-dev

# Install i3ipc-glib
cd /tmp && git clone https://github.com/altdesktop/i3ipc-glib.git && \
cd i3ipc-glib/ && \
./autogen.sh
