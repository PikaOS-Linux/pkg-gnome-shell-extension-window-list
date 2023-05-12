DEBIAN_FRONTEND=noninteractive

# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
apt install -y rpm
wget https://dl.fedoraproject.org/pub/fedora/linux/releases/38/Everything/x86_64/os/Packages/g/gnome-shell-extension-user-theme-44.0-1.fc38.noarch.rpm
mkdir -p ./gnome-shell-extension-user-theme
cp -rvf ./debian ./gnome-shell-extension-user-theme/
cd ./gnome-shell-extension-user-theme
rpm2cpio ../gnome-shell-extension-user-theme-44.0-1.fc38.noarch.rpm | cpio -idmv

# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -pv ./output
mv -v ./*.deb ./output/
