#!/bin/bash
# DNS Disable Script - Stop systemd-resolved and set custom DNS

echo "Disabling systemd-resolved and configuring DNS..."

# Stop systemd-resolved service
systemctl stop systemd-resolved 2>/dev/null || true

# Disable systemd-resolved from starting at boot
systemctl disable systemd-resolved 2>/dev/null || true

# Backup existing resolv.conf
cp /etc/resolv.conf /etc/resolv.conf.bak 2>/dev/null || true

# Remove the existing symlinked resolv.conf
rm -f /etc/resolv.conf 2>/dev/null || true

# Create a new resolv.conf file with custom DNS entries
echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4" | tee /etc/resolv.conf > /dev/null

# Make it immutable to prevent changes
chattr +i /etc/resolv.conf 2>/dev/null || true

echo "systemd-resolved disabled, DNS configured to 8.8.8.8 and 8.8.4.4"
