#!bin/bash

USERNAME="FatmaEzzat"
GROUPNAME="Ghanem"

#add a new user
sudo useradd FatmaEzzat

#create a new group
sudo groupadd Ghanem

#add the user to the group
sudo usermod -aG Ghanem FatmaEzzat

#check if the username and group exist  
if  grep -q "FatmaEzzat" /etc/passwd && grep -q "Ghanem" /etc/group; then

#display the user informtion
 id "$USERNAME"
 
#display the group informtion
 echo -e "\n"
 getent group "$GROUPNAME"

fi

