#!/bin/bash
# System restore script for Orange Pi Klipper & GPIO setup

echo "Installing gpiod and system tools..."
sudo apt update
sudo apt install -y gpiod libgpiod-dev git

echo "Restoring GPIO udev rules..."
sudo cp 99-gpio.rules /etc/udev/rules.d/99-gpio.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

echo "Setting user permissions..."
sudo groupadd -f gpio
sudo usermod -aG gpio $USER
sudo chmod 660 /dev/gpiochip* 2>/dev/null || true
sudo chown root:gpio /dev/gpiochip* 2>/dev/null || true

echo "Restarting Moonraker..."
sudo systemctl restart moonraker

echo "System restoration complete!"
