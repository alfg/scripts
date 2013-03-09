#!/usr/bin/env python

import urllib2
import gzip
import os
from subprocess import call

'''
Updates Transmission Blocklist with specified blocklist file. Must be run as root
if using default blocklist_path directory.
'''

blocklist_path = '/var/lib/transmission-daemon/info/blocklists/'
blocklist_url = 'http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz'

print "Removing old blocklist.txt file..."
os.remove(blocklist_path + 'blocklist.txt')

print "Downloading new blocklist from %s" % blocklist_url
file = urllib2.urlopen(blocklist_url)

download = open(blocklist_path + 'blocklist.gz', 'wb')
download.write(file.read())
download.close()

print "Gunzipping blocklist.gz..."
unzip = gzip.open(blocklist_path + 'blocklist.gz')
output = open(blocklist_path + 'blocklist.txt', 'w')
output.write(unzip.read())

print "Cleaning up..."
os.remove(blocklist_path + 'blocklist.gz')

print "Bouncing Transmission Daemon..."
call(["pkill", "-HUP", "transmission-daemon"])

print "Done."
