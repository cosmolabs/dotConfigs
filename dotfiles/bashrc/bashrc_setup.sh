#!/usr/bin/bash

# Author			:	Ganesh Kuramsetti
# Date Created		:	April 22, 2021
# Description		:	Script to set up bash rc
# Prequisites		:	bash
# Instructions		:	Execute the setup from the  bashrc folder downladed from git
#						to pull required dependencies.
#						Run the shell script using sh
# Date Modified		:	April 27, 2021


# Verify and create a .bin directory if it doesn't exist in user's  home directory
if [ ! -d "$HOME/.bin" ] ;
then
	echo -e "\nCreating .bin directory in ${HOME} .......";
	mkdir "$HOME"/.bin;
fi

# Verify and create a bashrc directory if it doesn't exists in user's howe directory

if [ ! -d "$HOME/.bin/bashrc" ]
then
	echo -e "\nCreating bashrc directory in ${HOME}/.bin ......."
	mkdir -p "$HOME"/.bin/bashrc
fi

# Copying all the dependencies into bashrc folder creaetd and 
# instricting the user to run the script from bashrc folder.
if [ -d "./dependencies" ];
then
	echo -e "\nCopying the dependencies to bashrc folder created ......"
	cp ./dependencies/* ~/.bin/bashrc/
else
	echo -e "\nPlease run the setup script from bashrc git folder!!!!!!"
fi
# Creating the backup of existing bashrc file and copying newly downloaded bashrc
if [ -f "$HOME/.bashrc" ] ;
then
	mv "$HOME"/.bashrc "$HOME"/.bashrc.bkp
	cp bashrc "$HOME"/.bashrc
fi

# Backing up existing aliases file if exists
if [ -f "$HOME"/.bash_aliases ] ;
then
	mv "$HOME"/.bash_aliases "$HOME"/.bash_aliases.bkp
fi

echo -e "\nSetup completed. Source new bashrc."
#source ~/.bashrc