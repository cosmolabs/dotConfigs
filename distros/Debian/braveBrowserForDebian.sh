#!/usr/bin/bash

#=========================================================================================================================
#installing brave browser in debian & and it's dependent distors.
#Author : ganesh
#Create Date   : Dec 06 2020
#Prerequisits   : sudo privillages

#Instructions
#1. Run the shell script as normal user and use sh to run the script instead of "./"
#2. Enter the sudo password when promted.
#Modified : 
#=========================================================================================================================

sudo apt install -y apt-transport-https curl gnupg

#grabing brave browser and key
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

#adding brave browser source to sources.list directory
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

#Updating the system
sudo apt update && sudo apt upgrade

#Installing the browser
sudo apt install -y brave-browser
