#!/usr/bin/env bash

#########
# Habit #
#########

habitAdd() {

  logPrint debug "Habit Add"

  if [ "${2}" ]; then
    thisHabitRecurrence="${1}"  ; logPrint debug "Habit Recurrence => ${thisHabitRecurrence}" ; shift
    thisHabitName="${@}"        ; logPrint debug "Habit Name => ${thisHabitName}"
  else
    logPrint error "Missing one of required arguments"
    return 1
  fi

  # Validating recurrence arg
  case "${thisHabitRecurrence}" in
    "d"|"daily")
      thisHabitRecurrenceOrder="10"
      thisHabitRecurrenceString="Daily  "
      ;;
    "w"|"weekly")
      thisHabitRecurrenceOrder="20"
      thisHabitRecurrenceString="Weekly "
      ;;
    "m"|"monthly")
      thisHabitRecurrenceOrder="30"
      thisHabitRecurrenceString="Monthly"
      ;;
    "y"|"yearly")
      thisHabitRecurrenceOrder="40"
      thisHabitRecurrenceString="Yearly "
      ;;
    *)
      logPrint error "Wrong value for 'recurrence' argument"
      return 1
      ;;
  esac

  # Validating if a habit with the same name already exists
  if databaseTableCheckEntryExists habit ".|${thisHabitName}$" ; then
    logPrint error "Habit already exists: '${thisHabitName}'"
    return 1
  fi

  # Adding the habit
  if databaseTableInsert habit "[H]" "${thisHabitRecurrenceOrder}" "${thisHabitRecurrenceString}" "1970-01-01 00:00 00" "[ ]" "${thisHabitName}" ; then
    logPrint info "New habit created: '${thisHabitName}'"
  else
    logPrint error "Failed to create habit: '${thisHabitName}'"
  fi

}

habitComplete() {

  ## Input
  if [ "${1}" ]; then
    thisHabitName="${@}"  ; logPrint debug "Habit name => ${thisHabitName}"
  else
    logPrint error "Missing habit name"
    return 1
  fi

  ## Processing

  # Validating if the habit exists
  if ! databaseTableCheckEntryExists habit ".|${thisHabitName}$" ; then
    logPrint error "Habit not found: '${thisHabitName}'"
    exit 1
  fi

  # Validating if the habit is already completed
  if ! databaseTableCheckEntryExists habit "[ ].|${thisHabitName}$" ; then
    logPrint warn "Habit already completed - Relax ;)"
    exit 0
  fi

  # Adding habit to completed table
  if ! databaseTableInsert completed "[X]" "`timestampGetNow`" "${thisHabitName}" ; then
    logPrint error "Failed to add habit to completed table: '${thisHabitName}'"
    exit 1
  fi

  # Marking habit as completed
  if ! databaseTableUpdateEntry habit "|[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9] [0-9][0-9]|\[ \]|${thisHabitName}$" "|`timestampGetNowWithWeek`|\[X\]|${thisHabitName}" ; then
    logPrint error "Failed to mark habit as completed: '${thisHabitName}'"
    exit 1
  fi

  ## Output
  logPrint info "Yay! Another habit completed: '${thisHabitName}'"

}

habitDelete() {

  ## Input
  if [ "${1}" ]; then
    thisHabitName="${@}"  ; logPrint debug "Habit Name => ${thisHabitName}"
  else
    logPrint error "Missing habit name"
    exit 1
  fi

  ## Processing

  # Validating if the habit exists
  if ! databaseTableCheckEntryExists habit ".|${thisHabitName}$" ; then
    logPrint error "Habit not found: '${thisHabitName}'"
    exit 1
  fi
  
  # Deleting the habit
  if databaseTableDeleteByString habit "|${thisHabitName}$" ; then
    logPrint info "Habit deleted: '${thisHabitName}'"
  else
    logPrint error "Failed to delete habit: '${thisHabitName}'"
  fi

}

habitList() {

  logPrint debug "Habit List"

  # Refreshing the habits before listing
  habitRefresh

  databaseTableSort habit 2,2 asc
  databaseTableList habit 1000 asc 1 5 3 6

}

habitShowUsage() {

  echo -e "${colorBold}Lowbit Planner - Habit${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0` habit${colorReset} ${colorUnderline}${colorLightRed}action${colorReset}${colorDim} [${colorReset}${colorUnderline}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Actions:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}add${colorReset} ${colorUnderline}recurrence${colorReset} ${colorUnderline}habit_name${colorReset} ${colorDim}- Create a new habit${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}complete${colorReset} ${colorUnderline}habit_name${colorReset}       ${colorDim}- Complete a habit${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}delete${colorReset} ${colorUnderline}habit_name${colorReset}         ${colorDim}- Delete a habit${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}list${colorReset}                      ${colorDim}- List habits${colorReset}"
  echo
  exit 0

}

habitShuffle() {

  databaseTableShuffle habit        # Shuffling habits
  databaseTableSort habit 5,5 asc   # Sorting habits by completion (pending habits will be in the begining of table)

}

habitRefresh() {

  logPrint debug "Habit Refresh"

  logPrint info "Please wait until the habits are refreshed..."

  # Storing the current timestamp masks
  thisDay="`date '+%Y-%m-%d'`"
  thisWeek="`date '+%Y.*%U'`"
  thisMonth="`date '+%Y-%m'`"
  thisYear="`date '+%Y'`"

  IFS=$'\n'
  for habit in `databaseTableGetByString habit "[X]"`; do

    habitName=`echo ${habit} | cut -d'|' -f6`
    habitRecurrence=`echo ${habit} | cut -d'|' -f3 | tr -d ' '`
    habitCompleted=`echo ${habit} | cut -d'|' -f5`
    habitTimestamp=`echo ${habit} | cut -d'|' -f4`

    case "${habitRecurrence}" in

      "Daily")

        if [[ $(echo "${habitTimestamp}" | grep -e "${thisDay}") ]] ; then
          logPrint debug "Habit '${habitName}' is still valid - Ignoring"
          continue
        fi

        logPrint debug "Habit '${habitName}' is expired - Unchecking"
        if databaseTableUpdateEntry habit "|\[X\]|${habitName}$" "|\[ \]|${habitName}" ; then
          logPrint debug "Habit unchecked"
        else
          logPrint error "Failed to uncheck Habit '${habitName}'"
        fi
        ;;

      "Weekly")
        if [[ $(echo "${habitTimestamp}" | grep -e "${thisWeek}") ]] ; then
          logPrint debug "Habit '${habitName}' is still valid - Ignoring"
          continue
        fi

        logPrint debug "Habit '${habitName}' is expired - Unchecking"
        if databaseTableUpdateEntry habit "|\[X\]|${habitName}$" "|\[ \]|${habitName}" ; then
          logPrint debug "Habit unchecked"
        else
          logPrint error "Failed to uncheck Habit '${habitName}'"
        fi
        ;;

      "Monthly")
        if [[ $(echo "${habitTimestamp}" | grep -e "${thisMonth}") ]] ; then
          logPrint debug "Habit '${habitName}' is still valid - Ignoring"
          continue
        fi

        logPrint debug "Habit '${habitName}' is expired - Unchecking"
        if databaseTableUpdateEntry habit "|\[X\]|${habitName}$" "|\[ \]|${habitName}" ; then
          logPrint debug "Habit unchecked"
        else
          logPrint error "Failed to uncheck Habit '${habitName}'"
        fi
        ;;

      "Yearly")
        if [[ $(echo "${habitTimestamp}" | grep -e "${thisYear}") ]] ; then
          logPrint debug "Habit '${habitName}' is still valid - Ignoring"
          continue
        fi

        logPrint debug "Habit '${habitName}' is expired - Unchecking"
        if databaseTableUpdateEntry habit "|\[X\]|${habitName}$" "|\[ \]|${habitName}" ; then
          logPrint debug "Habit unchecked"
        else
          logPrint error "Failed to uncheck Habit '${habitName}'"
        fi
        ;;

      *)
        logPrint error "Unknown recurrence for habit"
        ;;
    esac

  done

  # Reseting IFS
  unset IFS

}

habitRouter() {

  if [ $1 ]; then
    usrAction=$1  ; shift ; logPrint debug "Action => ${usrAction}"
  else
    habitShowUsage
  fi

  case ${usrAction} in
    "add")
      habitAdd "${@}"
      ;;
    "complete")
      habitComplete "${@}"
      ;;
    "delete")
      habitDelete "${@}"
      ;;
    "list")
      habitList
      ;;
    "--help"|"-h"|"help")
      habitShowUsage
      ;;
    *)
      logPrint error "Unknown action '${usrAction}'"
      ;;
  esac

}
