#!/usr/bin/bash

# Author			:	Ganesh Kuramsetti
# Date Created		:	May 02, 2021
# Description		:	Software installation in newly installed arch
# Prequisites		:	bash
# Instructions		:	Run the shell script using sh
# Date Modified		:	

sudo pacman -Syu --quiet --needed --noconfirm --noprogressbar
sudo pacman -S --quiet --needed --noconfirm --noprogressbar redshift
