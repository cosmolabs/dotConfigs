#!/bin/bash

#=========================================================================================================================
#Syncing content from one path to another path using rsync
#Author : ganesh
#Create Date   : Dec 06 2020
#Prerequisits   : sudo privillages if needed, rsync installed

#Instructions
#1. Run the shell script as normal user and use sh to run the script instead of "./"
#1. Enter the sudo password when promted.
#Modified :
#=========================================================================================================================

read -p 'Enter from path: ' fromPath
read -p 'Enter to path: ' toPath

rsync -auv ${fromPath} ${toPath}
