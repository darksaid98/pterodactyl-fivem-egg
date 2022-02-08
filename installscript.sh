#!/bin/ash
# FiveM Installation Script
#
# Server Files: /mnt/server
apt update -y
apt install -y tar xz-utils curl git file jq unzip

mkdir -p /mnt/server
cd /mnt/server

RELEASE_PAGE=$(curl -sSL https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/?$RANDOM)

# Check wether to run installation or update version of script
if [ ! -d "./alpine/" ] && [ ! -d "./resources/" ]; then
  # Install script
  echo "Beginning installation of new FiveM server."

  # Grab download link from FIVEM_VERSION
  if [ "${FIVEM_VERSION}" == "latest" ] || [ -z ${FIVEM_VERSION} ] ; then
    # Grab latest optional artifact if version requested is latest or null
    LATEST_ARTIFACT=$(echo -e "${RELEASE_PAGE}" | grep "LATEST OPTIONAL" -B1 | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1')
    DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${LATEST_ARTIFACT})
  else
    # Grab specific artifact if it exists
    VERSION_LINK=$(echo -e "${RELEASE_PAGE}" | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1' | grep ${FIVEM_VERSION})
    if [ "${VERSION_LINK}" == "" ]; then
      echo -e "Defaulting to directly downloading artifact as the version requested was not found on page."
    else
      DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FIVEM_VERSION}/fx.tar.xz)
    fi
  fi

  # Download artifact and get filetype
  echo -e "Running curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}..."
  curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}
  echo "Extracting FiveM artifact files..."
  FILETYPE=$(file -F ',' ${DOWNLOAD_LINK##*/} | cut -d',' -f2 | cut -d' ' -f2)

  # Unpack artifact depending on filetype
  if [ "$FILETYPE" == "gzip" ]; then
    tar xzvf ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "Zip" ]; then
    unzip ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "XZ" ]; then
    tar xvf ${DOWNLOAD_LINK##*/}
  else
    echo -e "Downloaded artifact of unknown filetype. Exiting."
    exit 2
  fi

  # Delete original bash launch script
  rm -rf ${DOWNLOAD_LINK##*/} run.sh

  if [ -e server.cfg ]; then
    echo "Server config file already exists. Skipping download of new one."
  else
    echo "Downloading default FiveM server config..."
    curl https://raw.githubusercontent.com/darksaid98/pterodactyl-fivem-egg/master/server.cfg >> server.cfg
  fi

  # Clone resources repo from git or install FiveM default resources
  if [ "${GIT_ENABLED}" == "1" ] && [ ! -d "/mnt/server/resources" ]; then
    # Download from git
    
    echo "Preparing to clone resources repo from git.";

    if [[ ${GIT_REPOURL} != *.git ]]; then # Add .git at end of URL
      GIT_REPOURL=${GIT_REPOURL}.git
    fi

    if [ -z "${GIT_USERNAME}" ] && [ -z "${GIT_TOKEN}" ]; then # Check for git username & token
      echo -e "Git Username or Git Token was not specified."
    else
      GIT_REPOURL="https://${GIT_USERNAME}:${GIT_TOKEN}@$(echo -e ${GIT_REPOURL} | cut -d/ -f3-)"
    fi

    if [ -z ${GIT_BRANCH} ]; then
      echo -e "Cloning default branch into /resources/*."
      git clone ${GIT_REPOURL} /mnt/server/resources
    else
      echo -e "Cloning ${GIT_BRANCH} branch into /resources/*."
      git clone --single-branch --branch ${GIT_BRANCH} ${GIT_REPOURL} /mnt/server/resources && echo "Finished cloning into /resources/* from Git." || echo "Failed cloning into /resources/* from Git."
    fi

  else
    # Download FiveM default server resources

    mkdir -p /mnt/server/resources
    echo "Preparing to clone default FiveM resources."
    git clone https://github.com/citizenfx/cfx-server-data.git /tmp && echo "Downloaded server from git." || echo "Downloading from git failed."
    cp -Rf /tmp/resources/* resources/

  fi

  mkdir logs/
  echo "Installation complete."

else
  # Update script
  echo "Beginning update of existing FiveM server artifact."

  # Delete old artifact
  if [ -d "./alpine/" ]; then
    echo "Deleting old artifact..."
    rm -r ./alpine/
    while [ -d "./alpine/" ]; do
      sleep 1s
    done
    echo "Deleted old artifact files successfully."
  fi

  # Grab download link from FIVEM_VERSION
  if [ "${FIVEM_VERSION}" == "latest" ] || [ -z ${FIVEM_VERSION} ] ; then
    # Grab latest optional artifact if version requested is latest or null
    LATEST_ARTIFACT=$(echo -e "${RELEASE_PAGE}" | grep "LATEST OPTIONAL" -B1 | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1')
    DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${LATEST_ARTIFACT})
  else
    # Grab specific artifact if it exists
    VERSION_LINK=$(echo -e "${RELEASE_PAGE}" | grep -Eo 'href=".*/*.tar.xz"' | grep -Eo '".*"' | sed 's/\"//g' | sed 's/\.\///1' | grep ${FIVEM_VERSION})
    if [ "${VERSION_LINK}" == "" ]; then
      echo -e "Defaulting to directly downloading artifact as the version requested was not found on page."
    else
      DOWNLOAD_LINK=$(echo https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FIVEM_VERSION}/fx.tar.xz)
    fi
  fi

  # Download artifact and get filetype
  echo -e "Running curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}..."
  curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_LINK##*/}
  echo "Extracting FiveM artifact files..."
  FILETYPE=$(file -F ',' ${DOWNLOAD_LINK##*/} | cut -d',' -f2 | cut -d' ' -f2)

  # Unpack artifact depending on filetype
  if [ "$FILETYPE" == "gzip" ]; then
    tar xzvf ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "Zip" ]; then
    unzip ${DOWNLOAD_LINK##*/}
  elif [ "$FILETYPE" == "XZ" ]; then
    tar xvf ${DOWNLOAD_LINK##*/}
  else
    echo -e "Downloaded artifact of unknown filetype. Exiting."
    exit 2
  fi

  # Delete original bash launch script
  rm -rf ${DOWNLOAD_LINK##*/} run.sh

  echo "Update complete."

fi