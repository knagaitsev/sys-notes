#!/bin/bash

# Ask for username
read -p "Enter new username: " username

read -p "Should $username's .ssh directory be populated with an SSH key or pulled from GitHub? (key/github) " ssh_source

if [[ ! "$ssh_source" == "github" && ! "$ssh_source" == "key" ]]
then
	  echo "Invalid option selected for SSH key source. Please select 'key' or 'github'."
    exit 1
fi

# Generate random password
password=$(openssl rand -base64 15 | tr -d "=+/")

# Create user with password
sudo useradd -m -p $(openssl passwd -1 $password) $username

if [[ "$ssh_source" == "github" ]]
then
    # Ask for GitHub username
    read -p "Enter GitHub username: " github_username
    
    # Pull SSH key from GitHub
    sudo mkdir /home/$username/.ssh
    sudo wget https://github.com/$github_username.keys -O /home/$username/.ssh/authorized_keys
    
    ssh_key_source="GitHub"
    
else
    # Ask for SSH key
    read -p "Enter SSH key for $username: " ssh_key
    
    # Create .ssh directory and authorized_keys file
    sudo mkdir /home/$username/.ssh
    sudo touch /home/$username/.ssh/authorized_keys
    
    # Add SSH key to authorized_keys file
    sudo echo $ssh_key | sudo tee -a /home/$username/.ssh/authorized_keys
    
    ssh_key_source="provided by user"
    
fi

# Set permissions on .ssh directory and authorized_keys file
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys

# Set ownership of home directory and .ssh directory to new user
sudo chown -R $username:$username /home/$username/.ssh

echo "User $username has been created with the following SSH key and password:"
echo "SSH key: $ssh_key_source"
echo "Password: $password"

# Ask if user should be added to sudo group
read -p "Should $username be added to the sudo group? (y/n) " add_sudo

if [[ "$add_sudo" =~ ^[Yy]$ ]]
then
    # Add user to sudo group
    sudo usermod -aG sudo $username
fi

