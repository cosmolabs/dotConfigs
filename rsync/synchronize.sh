#!/usr/bin/bash


echo -e  "\n"
read -p "Enter the full path of source directory: " sourceDirectory
echo -e "\n"
read -p "Enter the full path of destination directory: " destinationDirectory
echo -e "\nSource Direcory is: ${sourceDirectory}"
echo "Destination Directory is: ${destinationDirectory}"

echo -e "\nExecuting dry run ......"

rsync -avPuhn ${sourceDirectory} ${destinationDirectory}

echo -e "\n"
read -p "Dry run completed. Do you want to sync the directories?(Y or N): " executeActualRun

if [ ${executeActualRun} == "Y" ]
then
	rsync -avPu ${sourceDirectory} ${destinationDirectory}
	echo -e "\nSynced source and destination directoires."
fi
