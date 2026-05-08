openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout ../certs/superset.key \
  -out ../certs/superset.crt \
  -subj "/C=US/ST=Local/L=Local/O=Local/OU=Local/CN=localhost"
