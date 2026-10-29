FROM nginx:stable-trixie

LABEL org.opencontainers.image.source="https://github.com/Robooto/js-pitch-shift"

# Debian backports the CVE-2026-111497 fix without changing the upstream version.
RUN apt-get update \
    && apt-get install -y --no-install-recommends libbrotli1 openssl \
    && dpkg --compare-versions "$(dpkg-query -W -f='${Version}' libbrotli1)" ge '1.1.0-2+deb13u1' \
    && rm -rf /var/lib/apt/lists/*

COPY ./nginx/default.conf /etc/nginx/conf.d
COPY ./src /usr/share/nginx/html

RUN openssl req -x509 -nodes -days 365 \
    -subj  "/C=CA/ST=QC/O=Company Inc/CN=example.com" \
     -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
     -out /etc/ssl/certs/nginx-selfsigned.crt

# EXPOSE PORTS
EXPOSE 443
