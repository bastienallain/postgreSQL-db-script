# PostgreSQL Database and User Management Script

This script facilitates the management of PostgreSQL databases and users. It allows easy creation and configuration of databases and associated users with specific privileges.

## Introduction

The PostgreSQL Database and User Management Script is a bash script designed to simplify the creation and management of PostgreSQL databases and users. It offers interactive choices for creating new databases with users, and for adding users to existing databases. The script also generates secure, random passwords and handles the naming conventions for databases and users, ensuring uniqueness and adherence to PostgreSQL naming standards.

## Requirements

- Ubuntu 23.04 or later.
- PostgreSQL installed and running.
- `openssl` installed for generating secure random strings.
- Sufficient privileges to create databases and users in PostgreSQL.

## Installation

1. Download the script `manage_postgres.sh`.
2. Make the script executable: `chmod +x manage_postgres.sh`.

## Usage

Run the script in the terminal:

```bash
./manage_postgres.sh
```

Follow the on-screen prompts to choose between:

1. Creating a new database and user with `GRANT ALL PRIVILEGES`.
2. Adding a user to an existing database.

For each option, the script will guide you through the required steps.

### Examples

- To create a new database with a user:

  - Choose option 1.
  - Enter the desired prefixes for the database and user.
  - The script will output the database URL, name, username, and password.

- To add a user to an existing database:
  - Choose option 2.
  - Select from the list of existing databases.
  - Enter the prefix for the new user.
  - The script will output the database URL, username, and password.

## Contact

For any queries or issues related to this script, please open an issues.
