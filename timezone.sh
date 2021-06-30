#!/bin/sh

ln -sf /usr/share/zoneinfo/$(curl https://ipapi.co/timezone) /etc/localtime
hwclock --systohc
 
 
