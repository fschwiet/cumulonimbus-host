
sudo useradd -m -c "Web Applications Account" -p $(openssl passwd -1 "password") wwwuser
sudo mkdir /cumulonimbus
git clone /vagrant /cumulonimbus
mkdir /cumulonimbus/sites
sudo chown --recursive wwwuser:wwwuser /cumulonimbus

sudo su wwwuser
(crontab -l ; echo '@reboot cd /cumulonimbus && ./run.sh >>/var/log/cronrun-cumulonimbus 2>&1') | crontab

echo "Next, run:"
echo "    su wwwuser"
echo "    git clone http://github.com/fschwiet/cumulonimbus-project /cumulonimbus/sites/sample"
echo "    cd /cumulonimbus"
echo "    ./deploy.sh sample"
