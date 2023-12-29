#!/bin/bash

# Function to check and clean inputs
sanitize_input() {
    echo "$(echo "$1" | sed -e 's/[^a-zA-Z0-9_-.]//g')"
}

# Function to generate a random suffix using openssl
generate_random_suffix() {
    local length=$1
    openssl rand -base64 $length | tr -dc 'a-zA-Z0-9_-' | cut -c 1-$length
}

# Function to create a database and a user with GRANT ALL PRIVILEGES
create_db_and_user() {
    read -p "Enter the prefix for the database (Umami): " db_prefix
    read -p "Enter the prefix for the user (Usrumami): " user_prefix

    # Generate suffixes while respecting the maximum length
    local db_suffix=$(generate_random_suffix $((63 - ${#db_prefix})))
    local user_suffix=$(generate_random_suffix $((128 - ${#user_prefix})))
    local password=$(generate_random_suffix 90)

    local db_name="$(sanitize_input "$db_prefix")${db_suffix}"
    local user_name="$(sanitize_input "$user_prefix")${user_suffix}"

    sudo -u postgres psql -c "CREATE DATABASE \"$db_name\";"
    sudo -u postgres psql -c "CREATE USER \"$user_name\" WITH PASSWORD '$password';"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE \"$db_name\" TO \"$user_name\";"

    echo "DATABASE_URL=postgresql://$user_name:$password@localhost:5432/$db_name"
    echo "DATABASE: $db_name"
    echo "username: $user_name"
    echo "password: $password"
}

# Function to create a user for an existing database
echo "List of existing databases:"
sudo -u postgres psql -c '\l'

read -p "Enter the name of the existing database: " existing_db
read -p "Enter the prefix for the user: " user_prefix

local user_suffix=$(generate_random_suffix 80)
local password=$(generate_random_suffix 90)

local user_name="$(sanitize_input "$user_prefix")_${user_suffix}"

sudo -u postgres psql -c "CREATE USER $user_name WITH PASSWORD '$password';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $existing_db TO $user_name;"

echo "DATABASE_URL=postgresql://$user_name:$password@localhost:5432/$existing_db"
echo "DATABASE: $existing_db"
echo "username: $user_name"
echo "password: $password"
}



while true; do
    echo "1: Création de DB et Users avec GRANT ALL PRIVILEGES"
    echo "2: Créer un user pour une DB existante"
    echo "3: Quitter"
    read -p "Choisissez une option: " choice

    case $choice in
        1) create_db_and_user ;;
        2) create_user_for_existing_db ;;
        3) exit ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
done