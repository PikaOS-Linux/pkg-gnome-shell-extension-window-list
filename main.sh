DEBIAN_FRONTEND=noninteractive

# Clone Upstream
apt install -y rpm
wget https://dl.fedoraproject.org/pub/fedora/linux/releases/38/Everything/x86_64/os/Packages/g/gnome-shell-extension-window-list-44.0-1.fc38.noarch.rpm
mkdir -p ./gnome-shell-extension-window-list
cp -rvf ./debian ./gnome-shell-extension-window-list/
cd ./gnome-shell-extension-window-list
rpm2cpio ../gnome-shell-extension-window-list-44.0-1.fc38.noarch.rpm | cpio -idmv

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -pv ./output
mv -v ./*.deb ./output/
