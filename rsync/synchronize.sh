#!/usr/bin/bash

# A bash script to sync two directories.
# updated on - June 27th, 2021.

echo -e  "\n"
read -p "Enter the full path of source directory: " sourceDirectory
echo -e "\n"
read -p "Enter the full path of destination directory: " destinationDirectory

echo -e "\nSource Direcory is: ${sourceDirectory}"
echo "Destination Directory is: ${destinationDirectory}"
echo -e "\n"
read -p "Do you want to continue? (Y or N) " continueExecution
if [ ${continueExecution} == "Y" ]
then
    echo -e "\nExecuting dry run ......"

    # delelet option will delete the files that are not in source directory.
    rsync -avPuhn --delete ${sourceDirectory} ${destinationDirectory}

    echo -e "\nDry run completed. If there is any file that's in source and not in destination are marked for delete!!!"
    read -p "Do you want to delete the marked files? (Y or N) " deleteFilesinDest

    # Check for deletion of files in destination.
    # If not comfortable with deletion, opt "N"
    if [ ${deleteFilesinDest} == "Y" ]
    then
        echo -e "\n"
        echo -e "You preferred for file deletion if any, in destination."
        echo -e "\n"
        read -p "Do you want to start the synchronization? (Y or N): " executeActualRun
        if [ ${executeActualRun} == "Y" ]
        then
            rsync -avzPhu --delete ${sourceDirectory} ${destinationDirectory}
            echo -e "\nSynced source and destination directoires."
        fi
    elif [ ${deleteFilesinDest} == "N" ]
    then
        echo -e "\n"
        echo -e "You preferred not to delete files if any, in destination."
        echo -e "\n"
        read -p "Do you want to sync the directories? (Y or N): " executeActualRun

        if [ ${executeActualRun} == "Y" ]
        then
            rsync -avzPhu ${sourceDirectory} ${destinationDirectory}
            echo -e "\nSynced source and destination directoires."
        fi
    fi
else
    echo "Meet you next time!!"
fi
