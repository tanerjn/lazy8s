#!/bin/bash
set -e

echo "[INFO] Listing running VMs..."
VM_LIST=$(vmrun list | tail -n +2)

if [ -z "$VM_LIST" ]; then
    echo "[INFO] No running VMs found."
    exit 0
fi

for vmx in $VM_LIST; do
    echo "-----------------------------------------"
    echo "VM: $vmx"

    # Get the guest IP
    IP=$(vmrun getGuestIPAddress "$vmx" 2>/dev/null || echo "N/A")

    if [[ "$IP" == "N/A" ]]; then
        echo "  [!] Could not get IP (VMware Tools missing?)"
        continue
    fi

    echo "  Guest IP: $IP"

    # Extract the first three octets and form x.y.z.100
    BASE=$(echo "$IP" | cut -d. -f1-3)
    NEW_IP="${BASE}.100"

    echo "  Generated IP: $NEW_IP"
done

