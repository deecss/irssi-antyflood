# irssi-antispam

## Description

`irssi-antispam` is a script for Irssi that helps to block spam and flood messages in private and channel messages. The script provides options for blocking messages matching spam patterns and blocking messages sent too quickly (flooding).

## Installation

1. Download the `irssi-antispam.pl` script from [https://github.com/dee-/irssi-antispam](https://github.com/dee-/irssi-antispam).
2. Save the script to your Irssi scripts directory (default: `~/.irssi/scripts/`).
3. Load the script in Irssi using the command `/script load irssi-antispam.pl`.

## Configuration

The script provides various options that can be configured using Irssi's settings. You can add, modify, or remove spam patterns and customize other options such as flood block duration.

Available configuration options:

- `antispam_block`: Block messages matching spam patterns (default: ON)
- `antispam_block_flood`: Block flood messages (default: ON)
- `antispam_flood_duration`: Flood block duration in seconds (default: 5)
- `antispam_patterns`: Comma-separated list of spam patterns (default: list included in the script)

To change these options, use the `/set` command, for example:

/set antispam_block_flood OFF
/set antispam_flood_duration 10
/set antispam_patterns .spam_pattern1.,.spam_pattern2.

For more information about configuring and using this script, visit [https://github.com/dee-/irssi-antispam](https://github.com/dee-/irssi-antispam).

## License

This script is released under the GPLv3 license.