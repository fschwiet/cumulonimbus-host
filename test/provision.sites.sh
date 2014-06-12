
sudo useradd -m -c "Web Applications Account" -p $(openssl passwd -1 "password") wwwuser
sudo mkdir /cumulonimbus
git clone /vagrant /cumulonimbus
mkdir /cumulonimbus/sites
sudo chown --recursive wwwuser:wwwuser /cumulonimbus


TempCronFile=$(mktemp)
(sudo crontab -l -u wwwuser ; echo '@reboot PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin bash -c "cd /cumulonimbus && ./run.sh >>~/cronrun_cumulonimbus 2>&1"') > $TempCronFile
sudo crontab -u wwwuser $TempCronFile

echo "Next, run:"
echo "    su wwwuser"
echo "    git clone http://github.com/fschwiet/cumulonimbus-project /cumulonimbus/sites/sample"
echo "    cd /cumulonimbus"
echo "    ./deploy.sh sample"
