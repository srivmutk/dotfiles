#!/bin/sh

# Timezone Setup Script for Artix, WIP

# Set timezone:
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
 
 
