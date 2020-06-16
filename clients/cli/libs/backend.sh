#!/usr/bin/env bash

###########
# Backend #
###########

backendCheck() {

  # Checking if a user backend is configured
  if [ ! "${usrConfigBackend}" ] ; then
    logPrint error "No backend configured. Please, run '`basename $0` config' and follow the instructions to be able to use the CLI."
    configAssistant
  fi

  # Sourcing the user defined backend
  if source "./backends/${usrConfigBackend}.sh" > /dev/null 2>&1 ; then
    logPrint debug "Backend lib loaded => ${usrConfigBackend}"
  else
    logPrint error "Failed to load the backend lib. Please, run '`basename $0` config' and follow the instructions to be able to use the CLI."
    configAssistant
  fi

}