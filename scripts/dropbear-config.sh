#!/bin/bash
# Dropbear SSH Configuration Script

echo "Configuring Dropbear SSH service..."

# Create Dropbear default configuration
mkdir -p /etc/default
cat > /etc/default/dropbear << 'EOF'
# Dropbear SSH configuration
NO_START=0
DROPBEAR_PORT=69
DROPBEAR_EXTRA_ARGS="-p 109"
DROPBEAR_BANNER="/etc/issue.net"
DROPBEAR_RECEIVE_WINDOW=65536
EOF

echo "Dropbear default configuration created at /etc/default/dropbear"
