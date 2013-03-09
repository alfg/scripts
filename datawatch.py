#!/usr/bin/env python

import time
import threading

import pymongo
from pymongo import Connection
import redis
import boto
import pystache

# Configure
########################

EMAIL_FROM = '@gmail.com'
EMAIL_TO = '@gmail.com'
DATABASE = 'test' 
COLLECTION = 'post'
INTERVAL = 5 # in seconds

MONGODB_HOST = '192.168.1.22'
MONGODB_PORT = 27017
REDIS_HOST = 'localhost'
REDIS_PORT = 6379
AWS_ACCESS_KEY_ID = 'key'
AWS_SECRET_ACCESS_KEY = 'secret'

# No need to edit below
#########################

# Mongo connection
connection = Connection(MONGODB_HOST, MONGODB_PORT)
db = eval('connection.%s' % DATABASE)
data = eval('db.%s' % COLLECTION)

# Redis connection
r = redis.StrictRedis(host=REDIS_HOST, port=REDIS_PORT, db=0)

# AWS SES connection
conn = boto.connect_ses(
    aws_access_key_id = AWS_ACCESS_KEY_ID,
    aws_secret_access_key = AWS_SECRET_ACCESS_KEY)

def query_data():
    currentRows = data.count()
    previousRows = r.get('data')

    print "%s rows of data previously" % previousRows
    print "%s rows of data" % currentRows 

    r.set('data', currentRows)
    print "%s stored on Redis" % r.get('data')

    if int(currentRows) != int(previousRows):
        newRowsCount = int(currentRows) - int(previousRows)
        print "%i rows of NEW DATA" % newRowsCount
        queryNew = data.find(limit=newRowsCount).sort([['uid', -1]])
        queriedList = []
        for item in queryNew:
            queriedList.append(item)
        send_ses_mail(EMAIL_TO, queriedList)
    else:
        pass
    threading.Timer(5, query_data).start()


def sendMail():
    sendmail_location = "/usr/sbin/sendmail" # sendmail location
    p = os.popen("%s -t" % sendmail_location, "w")
    p.write("From: %s\n" % "test@gmail.com")
    p.write("To: %s\n" % "test@gmail.com")
    p.write("Subject: test\n")
    p.write("\n") # blank line separating headers from body
    p.write("testing")
    status = p.close()
    if status != 0:
           print "Sendmail exit status", status

def send_ses_mail(email, message):
    data = {
                "data" : message
              }

    template = "{{data}}"
    
    conn.send_email(
        email,
        'Database Notice',
        pystache.render(template, data),
        [email])

if __name__ == "__main__":
    query_data()
