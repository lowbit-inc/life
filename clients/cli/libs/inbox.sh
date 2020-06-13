#!/usr/bin/env bash

#########
# Inbox #
#########

inboxAdd() {

  logPrint debug "Inbox Add"

  if [ "${1}" ]; then
    thisInboxItemName="${@}"  ; logPrint debug "${thisInboxItemName}"
  else
    logPrint error "Missing inbox item name"
    return 1
  fi

  if databaseTableCheckEntryExists inbox ".|${thisInboxItemName}$" ; then
    logPrint error "Inbox item already exists: '${thisInboxItemName}'"
    return 1
  fi

  if databaseTableInsert inbox "=>" "`timestampGetNow`" "${thisInboxItemName}" ; then
    logPrint info "New inbox item: '${thisInboxItemName}'"
    return 0
  else
    logPrint error "Failed to add inbox item: '${thisInboxItemName}'"
    return 1
  fi

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

  if [ ! $1 ]; then
    inboxShowUsage
  fi

  usrAction=$1

  case ${usrAction} in
    "add")
      logPrint debug "Action => ${usrAction}"
      shift
      inboxAdd "${@}"
      ;;
    "delete")
      logPrint debug "Action => ${usrAction}"
      shift
      inboxDelete "${@}"
      ;;
    "list")
      logPrint debug "Action => ${usrAction}"
      shift
      inboxList
      ;;
    "--help"|"-h"|"help")
      logPrint debug "Action => ${usrAction}"
      inboxShowUsage
      ;;
    *)
      logPrint error "Unknown action '${usrAction}'"
      ;;
  esac

}

inboxShowUsage() {

  echo -e "${colorBold}Lowbit Planner - Inbox${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0` inbox${colorReset} ${colorUnderline}${colorLightRed}action${colorReset}${colorDim} [${colorReset}${colorUnderline}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Actions:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}add${colorReset} ${colorUnderline}item_name${colorReset}    ${colorDim}- Add an item to the inbox${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}delete${colorReset} ${colorUnderline}item_name${colorReset} ${colorDim}- Delete an item from the inbox${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}list${colorReset}             ${colorDim}- List inbox items${colorReset}"
  echo
  exit 0

}
