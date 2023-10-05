DEBIAN_FRONTEND=noninteractive

# Clone Upstream
apt install -y rpm
wget https://rpmfind.net/linux/fedora/linux/updates/testing/39/Everything/x86_64/Packages/g/gnome-shell-extension-window-list-45.0-1.fc39.noarch.rpm
mkdir -p ./gnome-shell-extension-window-list
cp -rvf ./debian ./gnome-shell-extension-window-list/
cd ./gnome-shell-extension-window-list
rpm2cpio ../gnome-shell-extension-window-list-45.0-1.fc39.noarch.rpm | cpio -idmv

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -pv ./output
mv -v ./*.deb ./output/
