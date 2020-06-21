#!/usr/bin/env bash

##########
# Config #
##########

configDirName="${HOME}/.lowbit/life"
configFileName="lowbit-life.cfg"
configPath="${configDirName}/${configFileName}"
configTempFile="/tmp/lowbit-life.cfg"

configAssistant() {

  # Explaning things for the user
  logPrint info "Starting the config assistant"
  logPrint info "You will be asked some questions"

  # Creating path
  logPrint debug "Creating directory structure"
  mkdir -p "${configDirName}"

  # Creating file
  logPrint debug "Initializing temporary config file"
  echo "# Lowbit Life - CLI - Config" > "${configTempFile}"

  # Question 1/4 - Backend type
  logPrint user "Question 1/4: Which backend type would you like to use?"
  logPrint info "Valid options: api, file, git"
  while [ true ] ; do
    unset usrAnswer
    read -p "Answer => " usrAnswer

    case "${usrAnswer}" in
      "api")
        echo "backend=${usrAnswer}" >> "${configTempFile}"
        break
        ;;
      "file")
        echo "backend=${usrAnswer}" >> "${configTempFile}"
        break
        ;;
      "git")
        echo "backend=${usrAnswer}" >> "${configTempFile}"
        break
        ;;
      *)
        logPrint warn "Invalid answer - Try again..."
        ;;
    esac

  done

  # Question 2/4 - Backend URI
  logPrint user "Question 2/4: What is your backend URI?"
  while [ true ] ; do
    unset usrAnswer
    read -p "Answer => " usrAnswer

    case "${usrAnswer}" in
      "")
        logPrint warn "Invalid answer - Try again..."
        ;;
      *)
        echo "uri=${usrAnswer}" >> "${configTempFile}"
        break
        ;;
    esac

  done

  # Question 3/4 - Backend username
  logPrint user "Question 3/4: What is your backend username?"
  unset usrAnswer
  read -p "Answer (leave blank for none) => " usrAnswer
  echo "username=${usrAnswer}" >> "${configTempFile}"

  # Question 4/4 - Backend password
  logPrint user "Question 4/4: What is your backend password?"
  unset usrAnswer
  read -p "Answer (leave blank for none) => " usrAnswer
  echo "password=${usrAnswer}" >> "${configTempFile}"

  # Commiting config file
  logPrint debug "Saving data to the config file"
  mv "${configTempFile}" "${configPath}"

  # Final messages
  logPrint info "Your config file was generated at '${configPath}'"
  logPrint info "If you want to change your configuration, just type '`basename $0` config'"

  exit 0
}

configCheck() {

  logPrint debug "Looking for user config file"

  if [ -f "${configPath}" ] ; then
    logPrint debug "Config file found"
    configLoad
  else
    logPrint info "Config file not found - Creating one..."
    configAssistant
  fi

}

configLoad() {

  logPrint debug "Loading user config"

  IFS=$'\n'
  for config in `grep '=' "${configPath}" | grep -v '#'` ; do
    thisUsrConfig=`echo "${config}" | cut -d= -f1`  # Getting config
    thisUsrValue=`echo "${config}" | cut -d= -f2`   # Getting value

    case "${thisUsrConfig}" in
      "backend")
        usrConfigBackend="${thisUsrValue}"
        logPrint debug "Config: Backend => ${usrConfigBackend}"
        ;;
      "uri")
        usrConfigURI="${thisUsrValue}"
        logPrint debug "Config: URI => ${usrConfigURI}"
        ;;
      "username")
        usrConfigUsername="${thisUsrValue}"
        logPrint debug "Config: Username => ${usrConfigUsername}"
        ;;
      "password")
        usrConfigPassword="${thisUsrValue}"
        logPrint debug "Config: Password => ********"
        ;;
      *)
        logPrint debug "Unknown config '${thisUsrConfig}' - skipping..."
        ;;
    esac

  done

}