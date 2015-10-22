#!/bin/bash

cd /usr/local/cats/
PIC=$(find ./ -type f | shuf -n 1)
cp ${PIC} /usr/share/nginx/html/

echo "<h2>You are served by $(hostname)!</h2>" > /usr/share/nginx/html/index.html
echo "<img src=\"${PIC}\"/>" >> /usr/share/nginx/html/index.html
