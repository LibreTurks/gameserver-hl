#!/bin/bash
set -e

# These variables should be set by the Dockerfile
# SERVER_ROOT: /opt/steam/hlds or /opt/steam/svends
# GAME_MOD: cstrike, valve, or svencoop
# BINARY_NAME: hlds_run or svends_run

# Source environment variables if file exists
if [ -f "/opt/steam/.env" ]; then
    source /opt/steam/.env
fi

echo "------------------------------------------------"
echo "Starting Game Server"
echo "Mod: ${GAME_MOD}"
echo "Root: ${SERVER_ROOT}"
echo "Binary: ${BINARY_NAME}"
echo "------------------------------------------------"

# Path where custom files might be mounted
CUSTOM_FILES_DIR="/opt/steam/custom"

# Copy custom files if they exist
if [[ -d "$CUSTOM_FILES_DIR" ]]; then
    echo "Found custom files in $CUSTOM_FILES_DIR. Copying to $SERVER_ROOT/$GAME_MOD/..."
    # Ensure destination exists
    mkdir -p "$SERVER_ROOT/$GAME_MOD"
    cp -R "$CUSTOM_FILES_DIR"/* "$SERVER_ROOT/$GAME_MOD/"
fi

# Switch to server root
cd "$SERVER_ROOT"

# Ensure the binary is executable
chmod +x "$BINARY_NAME"

# Execute the server
echo "Executing: ./$BINARY_NAME $*"
exec "./$BINARY_NAME" "$@"
