#!/bin/bash

#####################################################################
# This script will rsync the minecraft map to a backup copy, then run
# Minecraft-Overviewer to render and update the Minecraft Overviewer Map
# at /home/alf/http/ to server via Apache. Then runs a command to notify
# users ingame.
#####################################################################

/etc/init.d/minecraft command "say Updating Live Map. Server may experience lag for 10-20 mins while map is being updated."
sleep 2
echo "server message sent"
sleep 2
rsync -ar -P --delete /home/alf/minecraft-server/world /home/alf/http/qwertycraft.com/
sleep 2
echo "rsync map data done"
sleep 2
python /home/alf/Minecraft-Overviewer/overviewer.py --config=/home/alf/scripts/qwertycraftmap
sleep 2
echo "Map Generation done"
sleep 2
/etc/init.d/minecraft command "say Map Updated. View at qwertycraft.com/map"
sleep 2
echo "Map updated notice sent"
sleep 2
exit 0

