#!/bin/bash

#=========================================================================================================================
#installing required softwares for debian and it's dependent distors
#Author : ganesh
#Create Date   : Dec 06 2020
#Prerequisits   : sudo privillages

#Instructions
#1. Run the shell script as normal user and use sh to run the script instead of "./"
#1. Enter the sudo password when promted.
#Modified :
#=========================================================================================================================

sudo apt update && sudo apt upgrade -y

sudo apt install -y rofi stellarium mpv veracrypt virtualbox vnstat youtube-dl
