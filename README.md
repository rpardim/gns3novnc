# GNS3 - noVNC
Monitoramento de sessões VNC + noVNC + atualização HTML 

## Procedimento:
```
sudo apt install apache2
cd /var/www/html
sudo git clone https://github.com/novnc/noVNC
cd noVNC
sudo mv vnc_lite.html vnc_lite.html_ori
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/vnc_lite.html
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/console_list.html.template
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/gns3novnc.sh
cd /usr/local/bin/
sudo chmod 755 gns3novnc.sh
cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/gns3novnc.service
sudo systemctl daemon-reload
sudo systemctl enable gns3novnc
sudo service gns3novnc start
sudo service gns3novnc status
```
