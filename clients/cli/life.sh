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

# Main Router
case "${usrCommand}" in
  "config")
    configAssistant
    ;;
  "help"|"--help"|"-h")
    helpGet
    ;;
  "inbox")
    nextHop="inboxRouter"
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

# Sourcing backend lib
if source "./backends/${usrConfigBackend}.sh" > /dev/null 2>&1 ; then
  logPrint debug "Backend lib loaded => ${usrConfigBackend}"
else
  logPrint error "Failed to load the backend lib. Please, run '`basename $0` config' and follow the instructions to be able to use the CLI."
fi

# Checking backend
if backendCheck; then
  logPrint debug "Backend checked"
else
  logPrint error "Failed to check backend"
fi

# Calling next hop and passing all user arguments
logPrint debug "Calling next hop => ${nextHop}"
"${nextHop}" "${@}"