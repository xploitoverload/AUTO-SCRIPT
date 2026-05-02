#!/bin/bash
# regen_common_password.sh
# Generate a new local secret and re-encrypt /etc/pam.d/common-password so it can be uploaded.
set -e
mkdir -p /etc/auto-script
PASS=$(openssl rand -base64 32)
# store secret with strict perms
umask 077
printf "%s" "$PASS" > /etc/auto-script/secret
chmod 600 /etc/auto-script/secret

if [ -f /etc/pam.d/common-password ]; then
  openssl aes-256-cbc -salt -a -pbkdf2 -pass pass:"$PASS" -in /etc/pam.d/common-password -out ./password.encrypted
  chmod 600 ./password.encrypted
  echo "Encrypted ./password.encrypted created. Upload this file to your repository (replace existing 'password')."
  echo "New passphrase stored at /etc/auto-script/secret (600)."
else
  echo "/etc/pam.d/common-password not found; please place the desired file and re-run."
  exit 1
fi
