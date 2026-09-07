#!/usr/bin/env bash
#
# uninstall.sh - uninstalling the 20-20-20 eye rule reminder.

systemctl --user disable --now 20-20-20.service
rm ~/.local/bin/20-20-20.sh
rm ~/.config/systemd/user/20-20-20.service
systemctl --user daemon-reload