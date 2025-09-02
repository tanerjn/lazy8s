#!/bin/bash
set -e  # exit if any command fails

REPO_URL="https://github.com/sandervanvugt/cka.git"
REPO_DIR="$HOME/cka"

# Clone if not exists, else pull latest
if [ ! -d "$REPO_DIR" ]; then
    echo "[INFO] Cloning repository..."
    git clone "$REPO_URL" "$REPO_DIR"
else
    echo "[INFO] Repository exists, pulling latest changes..."
    cd "$REPO_DIR"
    git pull
fi

cd "$REPO_DIR"

# Make scripts executable just in case
chmod +x setup-container.sh setup-kubetools.sh

echo "[INFO] Running setup-container.sh..."
./setup-container.sh

echo "[INFO] Running setup-kubetools.sh..."
./setup-kubetools.sh

echo "[INFO] All done!"

