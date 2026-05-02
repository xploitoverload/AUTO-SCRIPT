#!/bin/bash
# Dropbear SSH Systemd Service Configuration

echo "Configuring Dropbear systemd service..."

# Create Dropbear systemd service file
mkdir -p /usr/lib/systemd/system
cat > /usr/lib/systemd/system/dropbear.service << 'EOF'
[Unit]
Description=Lightweight SSH server
Documentation=man:dropbear(8)
After=network.target

[Service]
Environment=DROPBEAR_PORT=22
Environment=DROPBEAR_RECEIVE_WINDOW=65536
Environment=DROPBEAR_BANNER="/etc/issue.net"
EnvironmentFile=-/etc/default/dropbear
ExecStart=/usr/sbin/dropbear -EF -p 22 -W 65536
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon to recognize the new service
systemctl daemon-reload

# Enable and start Dropbear service
systemctl enable dropbear 2>/dev/null || true
systemctl restart dropbear 2>/dev/null || true

echo "Dropbear systemd service configured and started"
