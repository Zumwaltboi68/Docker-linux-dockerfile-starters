# Base Image
FROM kalilinux/kali-rolling

# Update and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    nodejs \
    npm \
    kali-linux-default \
    git \
    curl \
    wget && \
    apt-get clean

# Install Wetty
RUN npm install -g wetty

# Create a non-root user for better security
RUN useradd -ms /bin/bash hacker && echo 'hacker:hacker' | chpasswd

# Set the environment to use the non-root user
USER hacker
WORKDIR /home/hacker

# Expose port 3000 for Wetty
EXPOSE 3000

# Command to start Wetty
CMD wetty --port 3000 --base / --command /bin/bash
