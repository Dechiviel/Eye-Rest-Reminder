#!/usr/bin/env bash
#
# 20-20-20 eye rule reminder.
#
# Every 20 minutes: fire a notification telling you to look at something
# 20 feet away for 20 seconds. Then, 20 seconds later, fire a follow-up
# telling you it's safe to look back at the screen.
#
# Notifications go out via `notify-send` (standard freedesktop/libnotify
# call). No special integration is needed for caelestia shell: caelestia
# registers itself as the system's org.freedesktop.Notifications D-Bus
# service, so any notify-send call is automatically picked up and rendered
# by caelestia's own notification UI.
#
# Requires: libnotify (for `notify-send`)

set -euo pipefail

INTERVAL="${INTERVAL:-1200}"   # 20 minutes, in seconds
LOOK_AWAY="${LOOK_AWAY:-20}"   # 20 seconds
APP_NAME="Eye Rest Reminder"
ICON="${ICON:-your-icon}"   # any icon name from your icon theme

notify() {
    local summary="$1"
    local body="$2"
    local urgency="${3:-normal}"
    notify-send \
        --app-name="$APP_NAME" \
        --icon="$ICON" \
        --urgency="$urgency" \
        --expire-time=15000 \
        "$summary" \
        "$body"
}

echo "Eye rule reminder started (interval: ${INTERVAL}s)."
echo "Press Ctrl+C to stop."

while true; do
    sleep "$INTERVAL"

    notify \
        "Look away!" \
        "Time to rest your eyes"

    sleep "$LOOK_AWAY"

    notify \
        "You're good" \
        "${LOOK_AWAY} seconds are up" \
        "low"
done
