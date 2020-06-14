#!/usr/bin/env bash

##########
# Config #
##########

configDirName="${HOME}/.lowbit/life/cli"
configFileName="lowbit-life-cli.cfg"
configPath="${configDirName}/${configFileName}"

configAssistant() {

  # Explaning things for the user
  logPrint info "Starting the config file creation assistant"
  logPrint info "You will be asked some questions"

  # Creating path
  logPrint debug "Creating directory structure"
  mkdir -p "${configDirName}"

  # Creating file
  logPrint debug "Creating config file"
  echo "# Lowbit Life - CLI - Config" > "${configPath}"

  # Question 1 - Backend type
  logPrint user "Question: Which backend type would you like to use?"
  while [ true ] ; do
    unset usrAnswer
    read -p "Answer (valid options: api, git) => " usrAnswer

    case "${usrAnswer}" in
      "api")
        echo "backend=${usrAnswer}" >> "${configPath}"
        break
        ;;
      "git")
        echo "backend=${usrAnswer}" >> "${configPath}"
        break
        ;;
      *)
        logPrint error "Invalid answer - Try again..."
        ;;
    esac

  done

  # Question 2 - Backend URI
  logPrint user "Question: What is your backend URI?"
  while [ true ] ; do
    unset usrAnswer
    read -p "Answer => " usrAnswer

    case "${usrAnswer}" in
      "")
        logPrint error "Invalid answer - Try again..."
        ;;
      *)
        echo "uri=${usrAnswer}" >> "${configPath}"
        break
        ;;
    esac

  done

  # Question 3 - Backend username
  logPrint user "Question: What is your backend username?"
  unset usrAnswer
  read -p "Answer (leave blank for none) => " usrAnswer
  echo "username=${usrAnswer}" >> "${configPath}"

  # Question 4 - Backend password
  logPrint user "Question: What is your backend password?"
  unset usrAnswer
  read -p "Answer (leave blank for none) => " usrAnswer
  echo "password=${usrAnswer}" >> "${configPath}"

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