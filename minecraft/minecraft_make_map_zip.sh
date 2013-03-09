#!/bin/bash

#####################################################################
# This script rsyncs over the map data to qwertycraft.com/downloads 
# and makes a zipball so users can download.
#####################################################################

rsync -ar -P --delete /home/alf/minecraft-server/world /home/alf/http/qwertycraft.com/downloads/
sleep 2
cd /home/alf/http/qwertycraft.com/downloads
sleep 2
zip -r world world/*

exit 0

