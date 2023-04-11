#!/bin/bash

#create cronjob for this file with command crontab -e

CONTAINER_ID=$(docker container ls --no-trunc | grep fastAPI_container | awk '{print $1}')
CONTAINER_NAME=$(docker container ls --no-trunc | grep fastAPI_container | awk '{print $NF}')

# Check if folder exists
if [ -d "C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/" ]; then

    
    # Folder exists, define destination folder variable
    SOURCE_FOLDER="//wsl.localhost/docker-desktop-data/data/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log*"
    DESTINATION_FOLDER="-p C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/"

    echo $SOURCE_FOLDER

    cp $SOURCE_FOLDER $DESTINATION_FOLDER

# elif [ -d "C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}" ]; then

    
#     # Folder exists, define destination folder variable
#     mkdir "C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/"
#     SOURCE_FOLDER="//wsl.localhost/docker-desktop-data/data/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log*"
#     DESTINATION_FOLDER="-p C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/"

#     echo $SOURCE_FOLDER

#     cp $SOURCE_FOLDER $DESTINATION_FOLDER

else
    # Folder doesn't exist, create it and define destination folder variable
    mkdir "C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/"
    # mkdir "C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/${CONTAINER_ID}/"
    SOURCE_FOLDER="//wsl.localhost/docker-desktop-data/data/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log*"
    DESTINATION_FOLDER="C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/"

    # cp -r "$SOURCE_FOLDER" "$DESTINATION_FOLDER"
fi

# cp -r "$SOURCE_FOLDER" "$DESTINATION_FOLDER"



# echo $CONTAINER_ID 
# echo $CONTAINER_NAME
# cd C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/
# mkdir ${CONTAINER_NAME}

# # docker stop "$CONTAINER_ID"

# SOURCE_FOLDER="//wsl.localhost/docker-desktop-data/data/docker/containers/${CONTAINER_ID}/container-cached.log"
# DESTINATION_FOLDER="C:/Nimap/projects/multibranch-project/docker-fastapi-test/log/${CONTAINER_NAME}/${CONTAINER_ID}/"

# cp -r "$SOURCE_FOLDER" "$DESTINATION_FOLDER"
