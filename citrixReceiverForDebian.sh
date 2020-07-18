#!/bin/bash

#=========================================================================================================================
#installing citrix receiver in debian & and it's dependent distors.
#Author : ganesh
#Date   : July 18 2020
#Prerequisits   : Downloaded icaClient from citrix website, sudo privillages
#Instructions
#1. Download icaClient receiver from citrix website and keep it in Downloads folder.
#2. Run the shell script as normal user
#3. Enter the sudo password when promted.
#=========================================================================================================================

#System paths && variables
tmpPath=/tmp
tmpDownloadFolder=$(echo ${0} | awk '{ print $1}' FS=".")
icaClientDownloadedFilePath=~/Downloads/icaclient*

#Creating temporary folder for downloads and installations.
#echo "\nMoving the execution to temp directory ......."
cd ${tmpPath} && mkdir ${tmpDownloadFolder} && cd ${tmpDownloadFolder}

#Downloading required packages using the url's from pkgs.org websit
echo "\nDownloading dependent packages ......."
curl -O http://ftp.br.debian.org/debian/pool/main/i/icu/libicu57_57.1-6+deb9u4_amd64.deb
curl -O http://ftp.br.debian.org/debian/pool/main/w/webkitgtk/libjavascriptcoregtk-1.0-0_2.4.11-3_amd64.deb
curl -O http://ftp.br.debian.org/debian/pool/main/w/webkitgtk/libwebkitgtk-1.0-0_2.4.11-3_amd64.deb

#Moving ica client package to execution folder
echo "\nCopying icaclient deb package to a tmp directory......"
sudo cp ${icaClientDownloadedFilePath} $(pwd)

#installing all the deb packages as root and answering yes for installation
echo "\nInstallation started ....."
sudo apt install -y ./libicu57_57* && sudo apt install -y ./libjavascriptcoregtk* && sudo apt install -y ./libwebkitgtk* && sudo apt install -y ./icaclient*

#Copying certificates to make citrix work.
echo "\nCopying required certificates"
sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts/

#Moving to home directory
cd ~
#removing the temp directory
sudo rm -r ${tmpPath}/${tmpDownloadFolder}
echo "\nInstallation completed ...."
