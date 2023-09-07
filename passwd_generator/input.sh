#!/bin/bash

# Set the length of the password
length=12

# Generate the password
password=$(tr -dc A-Za-z0-9 < /dev/urandom | head -c $length)

# Print the password
echo "Random password: $password"
