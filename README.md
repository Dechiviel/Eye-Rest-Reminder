# 20-20-20 Eye Rule Reminder

A lightweight background service that reminds you to follow the **20-20-20 rule**
for eye strain: every 20 minutes, look at something **20 feet** away for
**20 seconds**.

Notifications are sent with the standard `notify-send` (libnotify) call, so
they work with any notification daemon.

## Requirements

- `libnotify` (provides `notify-send`)
- `systemd` (user session)
- A notification daemon that implements `org.freedesktop.Notifications`
  (e.g. GNOME, KDE, Xfce, etc.)

## Install

```bash
git clone https://github.com/Dechiviel/Eye-Rest-Reminder.git
cd Eye-Rest-Reminder
chmod +x install.sh
./install.sh
```

## Configuration

The script reads a few optional environment variables:

| Variable   | Default                                       | Meaning                                 |
|------------|------------------------------------------------|------------------------------------------|
| `INTERVAL` | `1200` (20 minutes, in seconds)                | Time between reminders                   |
| `LOOK_AWAY`| `20`                                            | How many seconds to look away            |
| `ICON`     | `-your-icon`        | Icon name from your theme, or image path |

## Uninstall

```bash
./uninstall.sh
```
