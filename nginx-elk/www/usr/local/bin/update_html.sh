#!/bin/bash

cd /usr/share/nginx/html/
PIC=$(find ./cat* -type f | shuf -n 1)

echo "<h2>You are served by $(hostname)!</h2>" > /usr/share/nginx/html/index.html
echo "<img src=\"${PIC}\"/>" >> /usr/share/nginx/html/index.html
