#!/usr/bin/env bash

###########
# Backend #
###########

backendLoad() {

  # Checking if a user backend is configured
  if [ ! "${usrConfigBackend}" ] ; then
    logPrint error "No backend configured. We will call the config assistant. Please, follow the instructions bellow to be able to use the CLI."
    configAssistant
  fi

  # Sourcing the user defined backend
  if source "./backends/${usrConfigBackend}.sh" > /dev/null 2>&1 ; then
    logPrint debug "Backend lib loaded => ${usrConfigBackend}"
  else
    logPrint error "Failed to load backend '${usrConfigBackend}'. We will call the config assistant. Please, follow the instructions bellow to be able to use the CLI."
    configAssistant
  fi

}