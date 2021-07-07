#!/bin/sh

sudo pacman -Syu

sudo pacman -S --needed - <Pacfile
yay -S --needed - <Aurfile
