FROM nginx
COPY ./nginx/default.conf /etc/nginx/conf.d
COPY ./src /usr/share/nginx/html

RUN apt update && \
    apt install -y openssl && \
    openssl req -x509 -nodes -days 365 \
    -subj  "/C=CA/ST=QC/O=Company Inc/CN=example.com" \
     -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
     -out /etc/ssl/certs/nginx-selfsigned.crt;

# EXPOSE PORTS
EXPOSE 443