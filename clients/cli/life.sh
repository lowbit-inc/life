#!/usr/bin/env bash

################
# Dependencies #
################

# Basic libs
for lib in ./libs/*.sh ; do
  source $lib
done

##############
# User Input #
##############

if [ "${1}" ]; then
  usrCommand="${1}" ; shift ; logPrint debug "Command => ${usrCommand}"
else
  helpGet
fi

case "${usrCommand}" in
  "config")
    configAssistant
    ;;
  "help"|"--help"|"-h")
    helpGet
    ;;
  "install")
    systemInstall
    ;;
  "version"|"--version"|"-v")
    systemGetVersion
    ;;
  *)
    logPrint error "Unknown option '${usrCommand}'"
    exit 1
    ;;
esac

##############
# Processing #
##############

# Config
configCheck

# Backend
backendCheck
