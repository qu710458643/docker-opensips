#!/bin/bash
sudo OPENSIPS_VERSION=3.5 OPENSIPS_EXTRA_MODULES="opensips-auth-jwt-module opensips-perl-modules opensips-auth-modules \
    opensips-postgres-module opensips-berkeley-bin opensips-presence-modules opensips-berkeley-module opensips-prometheus-module \
    opensips-carrierroute-module opensips-python-module opensips-cgrates-module opensips-rabbitmq-modules \
    opensips-radius-modules opensips-compression-module opensips-redis-module opensips-cpl-module \
    opensips-regex-module opensips-restclient-module opensips-dbhttp-module opensips-sctp-module \
    opensips-dialplan-module opensips-siprec-module opensips-diameter-module opensips-snmpstats-module \
    opensips-emergency-module opensips-sqlite-module opensips-geoip-module opensips-stir-shaken-module \
    opensips-http-modules opensips-tlsmgm-module opensips-identity-module opensips-tls-module \
    opensips-jabber-module opensips-tls-openssl-module opensips-json-module opensips-tls-wolfssl-module \
    opensips-kafka-module opensips-unixodbc-module opensips-ldap-modules opensips-uuid-module opensips-lua-module \
    opensips-wss-module opensips-memcached-module opensips-xml-module opensips-mongodb-module opensips-xmlrpc-module \
    opensips-msrp-modules opensips-xmpp-module opensips-mysql-module" make build