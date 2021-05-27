#!/bin/sh

# My personal out of box installer for arch/artix linux
yay -S pulseaudio pavucontrol nerd-fonts-complete stow

# Set timezone:
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

