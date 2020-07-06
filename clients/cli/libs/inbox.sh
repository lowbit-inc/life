#!/usr/bin/env bash

#########
# Inbox #
#########

inboxAdd() {

  # Input args
  inputGet string "Item name" "${@}" ; shift ; thisInboxItemName="${inputReturn}"

  # if [ "${1}" ]; then

  #   thisInboxItemName="${@}" ; shift
  #   if ! validateString "${thisInboxItemName}" ; then
  #     logPrint error "Invalid inbox item name"
  #   fi
  
  # else
  #   inputAskString "Inbox item name" ; thisInboxItemName="${inputUserAnswer}"
  # fi

  # logPrint debug "Inbox item => ${thisInboxItemName}"

  exit 0

  # if databaseTableCheckEntryExists inbox ".|${thisInboxItemName}$" ; then
  #   logPrint error "Inbox item already exists: '${thisInboxItemName}'"
  #   return 1
  # fi

  # if databaseTableInsert inbox "=>" "`timestampGetNow`" "${thisInboxItemName}" ; then
  #   logPrint info "New inbox item: '${thisInboxItemName}'"
  #   return 0
  # else
  #   logPrint error "Failed to add inbox item: '${thisInboxItemName}'"
  #   return 1
  # fi

}

inboxDelete() {

  if [ ! "${1}" ]; then
    logPrint error "Missing inbox item name"
    return 1
  fi

  thisInboxItemName="${@}"

  if ! databaseTableCheckEntryExists inbox ".|${thisInboxItemName}$" ; then
    logPrint error "Item '${thisInboxItemName}' not found in Inbox"
    exit 1
  fi
  
  if databaseTableDeleteByString inbox "|${thisInboxItemName}$" ; then
    logPrint info "'${thisInboxItemName}' deleted from Inbox"
  else
    logPrint error "Failed to delete '${thisInboxItemName}' from Inbox"
  fi

}

inboxList() {

  logPrint debug "Inbox List"

  databaseTableList inbox 10 asc 1 3

}

inboxRouter() {

  if [ $1 ]; then
    usrAction=$1 ; shift ; logPrint debug "Action => ${usrAction}"
  else
    helpGetInbox
  fi

  case ${usrAction} in
    "add")
      inboxAdd "${@}"
      ;;
    # "delete")
    #   logPrint debug "Action => ${usrAction}"
    #   shift
    #   inboxDelete "${@}"
    #   ;;
    "help"|"--help"|"-h")
      helpGetInbox
      ;;
    # "list")
    #   logPrint debug "Action => ${usrAction}"
    #   shift
    #   inboxList
    #   ;;
    *)
      logPrint error "Unknown action '${usrAction}'"
    #   ;;
  esac

}
