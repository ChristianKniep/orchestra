FROM qnib/nginx

ADD etc/consul.d/www.json /etc/consul.d/www.json
ADD etc/supervisord.d/update_html.ini /etc/supervisord.d/
ADD usr/local/bin/update_html.sh /usr/local/bin/
ADD usr/share/nginx/html/cat* /usr/share/nginx/html/
ADD etc/nginx/nginx.conf /etc/nginx/

