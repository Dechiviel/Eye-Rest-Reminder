#!/usr/bin/env bash
#
# install.sh — installs the 20-20-20 eye rule reminder.
#
# Run this from the directory containing 20-20-20.sh and 20-20-20.service.
# It will:
#   1. Copy the script to ~/.local/bin/
#   2. Make it executable
#   3. Copy the systemd unit to ~/.config/systemd/user/
#   4. Reload systemd, enable, and start the service

set -euo pipefail

SCRIPT_NAME="20-20-20.sh"
SERVICE_NAME="20-20-20.service"

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
SYSTEMD_DIR="$HOME/.config/systemd/user"

if [[ ! -f "$SRC_DIR/$SCRIPT_NAME" ]]; then
    echo "Error: $SCRIPT_NAME not found in $SRC_DIR" >&2
    exit 1
fi

if [[ ! -f "$SRC_DIR/$SERVICE_NAME" ]]; then
    echo "Error: $SERVICE_NAME not found in $SRC_DIR" >&2
    exit 1
fi

if ! command -v notify-send &>/dev/null; then
    echo "Warning: notify-send not found. Install libnotify first (e.g. 'sudo pacman -S libnotify')." >&2
fi

echo "Installing script to $BIN_DIR/$SCRIPT_NAME ..."
mkdir -p "$BIN_DIR"
cp "$SRC_DIR/$SCRIPT_NAME" "$BIN_DIR/$SCRIPT_NAME"
chmod +x "$BIN_DIR/$SCRIPT_NAME"

echo "Installing systemd unit to $SYSTEMD_DIR/$SERVICE_NAME ..."
mkdir -p "$SYSTEMD_DIR"
cp "$SRC_DIR/$SERVICE_NAME" "$SYSTEMD_DIR/$SERVICE_NAME"

echo "Reloading systemd user daemon ..."
systemctl --user daemon-reload

echo "Resetting any previous failed state ..."
systemctl --user reset-failed "$SERVICE_NAME" 2>/dev/null || true

echo "Enabling and starting $SERVICE_NAME ..."
systemctl --user enable --now "$SERVICE_NAME"

echo
echo "Done. Checking status:"
systemctl --user status "$SERVICE_NAME" --no-pager || true

echo
echo "Tip: view live logs with:"
echo "  journalctl --user -u $SERVICE_NAME -f"
