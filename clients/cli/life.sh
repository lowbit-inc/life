#!/usr/bin/env bash

################
# Dependencies #
################

# Sourcing basic libs
for lib in ./libs/*.sh ; do
  source $lib
done

##########
# Config #
##########

# Checking or creating user config, if needed
configCheck

###########
# Backend #
###########

# Sourcing user backend
backendLoad

##############
# User Input #
##############

if [ $1 ]; then
  usrCommand=$1 ; shift ; logPrint debug "Command => ${usrCommand}"
else
  helpUsage
fi

##############
# Processing #
##############

case ${usrCommand} in

  # "add")
  #   databaseCheckIfExists
  #   inboxAdd "${@}"
  #   ;;
  # "completed")
  #   databaseCheckIfExists
  #   completedList
  #   ;;
  "config")
    configAssistant
    ;;
  # "decide")
  #   databaseCheckIfExists
  #   interactiveDecide
  #   ;;
  # "event")
  #   databaseCheckIfExists
  #   eventRouter "${@}"
  #   ;;
  # "habit")
  #   databaseCheckIfExists
  #   habitRouter "${@}"
  #   ;;
  # "inbox")
  #   databaseCheckIfExists
  #   inboxRouter "${@}"
  #   ;;
  # "list")
  #   databaseCheckIfExists
  #   inboxList     ; echo
  #   eventList     ; echo
  #   taskList      ; echo
  #   habitList     ; echo
  #   completedList ; echo
  #   ;;
  # "review")
  #   databaseCheckIfExists
  #   interactiveReview
  #   ;;
  # "search")
  #   databaseCheckIfExists
  #   itemSearch "${@}"
  #   ;;
  # "sync")
  #   databaseCheckIfExists
  #   databaseSync
  #   ;;
  # "task")
  #   databaseCheckIfExists
  #   taskRouter "${@}"
  #   ;;
  # "work")
  #   databaseCheckIfExists
  #   interactiveWork
  #   ;;
  # "--help"|"-h"|"help")
  #   helpShow
  #   ;;
  # "--link")
  #   systemLink
  #   ;;
  *)
    logPrint error "Unknown option '${usrCommand}'"
    ;;

esac