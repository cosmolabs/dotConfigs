#!/bin/bash

#=========================================================================================================================
#installing citrix receiver in debian & and it's dependent distors.
#Author : ganesh
#Date   : Aug 08 2020
#Prerequisits   : None
#Instructions
#1. Run the shell script as normal user and use sh to run the script instead of "./"
#2. Enter the sudo password when promted.
#=========================================================================================================================

# Creating a download folder for .deb package in tmp folder
cd /tmp && mkdir 4kVideoDownloader && cd 4kVideoDownloader

# Downloading debian package from website

echo "\nDownlaoding 4kVideoDownloader 4.12.5-1 ........"
curl -O https://dl.4kdownload.com/app/4kvideodownloader_4.12.5-1_amd64.deb

echo "\nInstalling 4kVideoDownloader ......"
sudo apt install -y ./4kvideo*

#sudo rm -r /tmp/4kVideoDownloader

echo "\nInstallion complete."






