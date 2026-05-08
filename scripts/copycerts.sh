#!/bin/bash

DEST=~/certs

# Copiar los dos archivos específicos
sudo cp /etc/letsencrypt/live/h20.higia.ai/fullchain.pem "$DEST/"
sudo cp /etc/letsencrypt/live/h20.higia.ai/privkey.pem "$DEST/"

# Cambiar propietario y permisos
sudo chown $(whoami):$(whoami) "$DEST/fullchain.pem" "$DEST/privkey.pem"
chmod 644 "$DEST/fullchain.pem" "$DEST/privkey.pem"

echo "Certificados fullchain.pem y privkey.pem copiados en $DEST"
