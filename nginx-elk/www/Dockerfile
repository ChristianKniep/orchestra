FROM qnib/nginx

ADD etc/consul.d/check_www.json /etc/consul.d/
ADD etc/supervisord.d/update_html.ini /etc/supervisord.d/
ADD usr/local/bin/update_html.sh /usr/local/bin/
ADD usr/local/cats/ /usr/local/cats/

