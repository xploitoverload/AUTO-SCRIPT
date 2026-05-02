#!/bin/bash
# Swap Space Configuration Script

echo "Configuring swap space..."

# Detect available memory and set swap size accordingly
MEMORY=$(free -b | awk 'NR==2 {print $2}')
SWAP_SIZE=$((MEMORY / 1024 / 1024))  # Convert to MB

# Cap at 4GB for safety
if [ $SWAP_SIZE -gt 4096 ]; then
    SWAP_SIZE=4096
fi

# Create swap file
SWAP_FILE="/swapfile"

if [ ! -f "$SWAP_FILE" ]; then
    echo "Creating $SWAP_SIZE MB swap file at $SWAP_FILE..."
    
    # Create empty file with desired size
    fallocate -l ${SWAP_SIZE}M $SWAP_FILE 2>/dev/null || dd if=/dev/zero of=$SWAP_FILE bs=1M count=$SWAP_SIZE
    
    # Set permissions
    chmod 600 $SWAP_FILE
    
    # Format as swap
    mkswap $SWAP_FILE > /dev/null
    
    # Enable swap
    swapon $SWAP_FILE
    
    # Add to fstab for persistence
    if ! grep -q "$SWAP_FILE" /etc/fstab; then
        echo "$SWAP_FILE none swap sw 0 0" >> /etc/fstab
    fi
    
    echo "Swap space configured: ${SWAP_SIZE}MB"
else
    echo "Swap file already exists at $SWAP_FILE"
fi

# Display current swap status
echo "Current swap status:"
free -h | grep -i swap
