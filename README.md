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
sudo mkdir /var/www/html/noVNC/websockify
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
<img width="903" height="363" alt="image" src="https://github.com/user-attachments/assets/28a4790f-064a-44b2-b302-399b6c9f5319" />&nbsp;
<img width="651" height="226" alt="image" src="https://github.com/user-attachments/assets/d5e9c994-d9bb-49bc-8ad4-676f44c706c5" />
