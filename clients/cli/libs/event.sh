#!/usr/bin/env bash

#########
# Event #
#########

eventAdd() {

  logPrint debug "Event Add"

  if [ "${3}" ]; then
    thisEventDate="${1}"  ; logPrint debug "Event Date => ${thisEventDate}" ; shift
    thisEventTime="${1}"  ; logPrint debug "Event Time => ${thisEventTime}" ; shift
    thisEventName="${@}"  ; logPrint debug "Event Name => ${thisEventName}"
  else
    logPrint error "Missing one of required arguments"
    return 1
  fi

  # Validating the date arg
  timestampValidateDate ${thisEventDate}

  # Validate time
  timestampValidateTime ${thisEventTime}

  # Validating if an event with the same name already exists
  if databaseTableCheckEntryExists event ".|${thisEventName}$" ; then
    logPrint error "Event already exists: '${thisEventName}'"
    return 1
  fi

  # Adding the event
  if databaseTableInsert event "[E]" "${thisEventDate} ${thisEventTime}" "${thisEventName}" ; then
    logPrint info "New event created: '${thisEventName}'"
  else
    logPrint error "Failed to create event: '${thisEventName}'"
  fi

  # Sorting the event table by date
  databaseTableSort event 2 asc

}

eventComplete() {

  ## Input
  if [ "${1}" ]; then
    thisEventName="${@}"  ; logPrint debug "Event name => ${thisEventName}"
  else
    logPrint error "Missing event name"
    exit 1
  fi

  ## Processing

  # Validating if the event exists
  if ! databaseTableCheckEntryExists event ".|${thisEventName}$" ; then
    logPrint error "Event not found: '${thisEventName}'"
    exit 1
  fi
  
  # Marking as completed
  if ! databaseTableInsert completed "[X]" "`timestampGetNow`" "${thisEventName}" ; then
    logPrint error "Failed to mark event as completed: '${thisEventName}'"
    exit 1
  fi

  # Deleting from event table
  if ! databaseTableDeleteByString event "|${thisEventName}$" ; then
    logPrint error "Failed to delete event after marking it as completed: '${thisEventName}'"
    exit 1
  fi

  ## Output
  logPrint info "Yay! Another event completed: '${thisEventName}'"

}


eventDelete() {

  ## Input
  if [ "${1}" ]; then
    thisEventName="${@}"  ; logPrint debug "Event Name => ${thisEventName}"
  else
    logPrint error "Missing event name"
    exit 1
  fi

  ## Processing

  # Validating if the event exists
  if ! databaseTableCheckEntryExists event ".|${thisEventName}$" ; then
    logPrint error "Event not found: '${thisEventName}'"
    exit 1
  fi
  
  # Deleting the event
  if databaseTableDeleteByString event "|${thisEventName}$" ; then
    logPrint info "Event deleted: '${thisEventName}'"
  else
    logPrint error "Failed to delete event: '${thisEventName}'"
  fi

}

eventList() {

  logPrint debug "Event List"

  databaseTableList event 10 asc 1 2 3

}

eventShowUsage() {

  echo -e "${colorBold}Lowbit Planner - Event${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0` event${colorReset} ${colorUnderline}${colorLightRed}action${colorReset}${colorDim} [${colorReset}${colorUnderline}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Actions:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}add${colorReset} ${colorUnderline}date${colorReset} (YYYY-MM-DD) ${colorUnderline}time${colorReset} (HH:MM) ${colorUnderline}event_name${colorReset} ${colorDim}- Create a new event${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}complete${colorReset} ${colorUnderline}event_name${colorReset}                           ${colorDim}- Complete an event${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}delete${colorReset} ${colorUnderline}event_name${colorReset}                             ${colorDim}- Delete an event${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}list${colorReset}                                          ${colorDim}- List events${colorReset}"
  echo
  exit 0

}

eventRouter() {

  if [ $1 ]; then
    usrAction=$1  ; shift ; logPrint debug "Action => ${usrAction}"
  else
    eventShowUsage
  fi

  case ${usrAction} in
    "add")
      eventAdd "${@}"
      ;;
    "complete")
      eventComplete "${@}"
      ;;
    "delete")
      eventDelete "${@}"
      ;;
    "list")
      eventList
      ;;
    "--help"|"-h"|"help")
      eventShowUsage
      ;;
    *)
      logPrint error "Unknown action '${usrAction}'"
      ;;
  esac

}
