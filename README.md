# Home Backup Script for macOS

[![ShellCheck](https://github.com/fpaupier/TimeCapsule/actions/workflows/shell_check.yml/badge.svg)](https://github.com/fpaupier/TimeCapsule/actions/workflows/shell_check.yml)

This project contains a shell script for backing up a macOS home directory. It is designed to be run on a personal 
macOS laptop.

## Features

- **Dynamic Date Handling:** Automatically names backup files with the current date and time to avoid overwrites.
- **Configurable Exclusions:** Uses an external configuration file for specifying directories to exclude from the backup.
- **Detailed Logging:** Outputs a detailed log file for each backup operation.
- **Error Handling:** Catches errors during the backup process and logs them.
- **Backup Verification:** Verifies the integrity of the backup after creation.

## Usage

To use this script:

1. Clone this repository to your local machine.
2. Copy the `backup_exclude.conf.example` into `backup_exclude.conf`
3. Customize the `backup_exclude.conf` with paths you want to exclude from the backup. 
4. Set the `backup_dest` variable in the script to your desired backup location.
5. Run the script manually with `./backup_script.sh`, or set it up as a cron job for automatic execution.

### Prerequisites

- macOS environment.
- Sufficient permissions to access and create files in the backup and log directories.
- tar utility (should be pre-installed on macOS).

### Configuration

Create `backup_exclude.conf` in the same directory as the script, or in a location of your choice
(updating the `config_file` variable in the script accordingly), with contents like the following:

```conf
/Users/yourusername/.Trash
/Users/yourusername/projects/big_project
/Users/yourusername/Downloads
# Add more lines as needed
```

Replace `/Users/yourusername` with the appropriate path to your home directory.

### Script Output

The backup archive will be saved to the path specified in `backup_dest`.
A log file for each backup operation will be saved to the same directory as the backup file.


## Contributing

Contributions to this project are welcome! Please fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
