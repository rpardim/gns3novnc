# GNS3 - noVNC
Monitoramento de sessões VNC + noVNC + atualização HTML 

## Procedimento:
```
sudo apt install apache2
sudo a2enmod proxy proxy_http proxy_wstunnel rewrite
cd /etc/apache2/sites-available/
sudo mv 000-default.conf 000-default.conf_ori
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/websockfy.conf
sudo mv websockfy.conf 000-default.conf
sudo apache2ctl configtest
sudo systemctl reload apache2
cd /var/www/html
sudo git clone https://github.com/novnc/noVNC
cd noVNC
sudo mv vnc_lite.html vnc_lite.html_ori
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/vnc_lite.html
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/console_list.html.template
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/index.html
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/favicon.ico
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/favicon.svg
cd utils
sudo git clone https://github.com/novnc/websockify
cd /usr/local/bin/
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/gns3novnc.sh
sudo chmod 755 gns3novnc.sh
cd /etc/systemd/system
sudo wget https://raw.githubusercontent.com/rpardim/gns3novnc/main/gns3novnc.service
sudo systemctl daemon-reload
sudo systemctl enable gns3novnc
sudo service gns3novnc start
sudo service gns3novnc status
```

### Screenshots
Abrir http://gns3server/noVNC/
<img width="1179" height="544" alt="image" src="https://github.com/user-attachments/assets/9762c300-cdb8-4c95-bc54-30ef86e475c1" />
<img width="1101" height="264" alt="image" src="https://github.com/user-attachments/assets/17cd45bb-ef95-45a7-ac99-64f4a0f864a4" />




