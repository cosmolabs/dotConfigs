#!/bin/bash

#=========================================================================================================================
#Setting up git config initially
#Author			: ganesh kuramsetti
#Create Date	: Dec 20 2020
#Prerequisits   : git should be installed in the system and editor geany should be installed in the system.

#Instructions
#Run the shell script using sh
#=========================================================================================================================

echo 'Configuring git config .....'
echo ''

git config --global user.name ''
git config --global user.email ''
git config --global core.editor geany

echo 'Configured git config. Below is the global configuraiton or the configuration of the repository you are in ....'
echo ''

git config --list
