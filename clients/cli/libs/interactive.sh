#!/usr/bin/env bash

###############
# Interactive #
###############

interactiveDecide() {

  usrMode="interactiveDecide"
  usrChoice=""

  while [ true ]; do

    interactiveDecideDraw

    case "${usrChoice}" in
      # Modes
      "r"|"review")
        interactiveReview
        ;;
      "w"|"work")
        interactiveWork
        ;;
      # Global Actions
      "a"|"add")
        interactiveInboxAdd   ; "${usrMode}"
        ;;
      "s"|"sync")
        clear ; databaseSync  ; "${usrMode}"
        ;;
      "q"|"quit")
        logPrint info "Good decision. Bye!" ; exit 0
        ;;
      # Local Actions
      *)
        true
        ;;
    esac

    read -p "Choice => " usrChoice

  done

}

interactiveDecideDraw() {

  clear

  echo -e "${colorDim}+-----------------------${colorReset} ${colorBold}Lowbit Planner${colorReset} ${colorDim}(Bash Edition) ${colorDim}------------------------+${colorReset}"
  echo -e "${colorDim}|                                                                              |${colorReset}"
  echo -e "${colorDim}+-----------------------${colorReset} ${colorBold}Modes${colorReset}: ${colorUnderline}r${colorReset}eview ${colorDim}|${colorReset} ${colorBgLightRed}${colorUnderline}d${colorReset}${colorBgLightRed}ecide${colorReset} ${colorDim}|${colorReset} ${colorUnderline}w${colorReset}ork${colorReset} ${colorDim}------------------------+${colorReset}"
  echo
  echo -e "Decision ${colorDim}(9/10)${colorReset}"
  echo
  echo -e "Progress: ${colorBold}[${colorBgLightGreen}                                                               ${colorReset}     ${colorBold}]${colorReset}"
  echo
  echo -e "  1. ${colorLightYellow}[ ] Not available${colorReset}"
  echo -e "  2. ${colorLightYellow}[ ] Come back soon =)${colorReset}"
  echo
  echo -e "${colorDim}Actions: ${colorUnderline}1${colorReset}${colorDim} | ${colorUnderline}2${colorReset}${colorDim} | ${colorUnderline}s${colorReset}${colorDim}kip-${colorUnderline}d${colorReset}${colorDim}ecision"
  echo
  echo -e "${colorDim}Global actions: ${colorUnderline}a${colorReset}${colorDim}dd (inbox) | ${colorUnderline}s${colorReset}${colorDim}ync | ${colorUnderline}q${colorReset}${colorDim}uit${colorReset}"
  echo

}

interactiveInboxAdd() {

  # Cleaning in memory variable
  thisInboxItemName=""

  # Asking user for inbox item name
  while [ -z "${thisInboxItemName}" ]; do
    clear
    read -p "Inbox item name => " thisInboxItemName
  done
  
  # Adding inbox item
  inboxAdd "${thisInboxItemName}"

  # "${usrMode}"

}

interactiveInboxToEvent() {

  # Cleaning in memory variables
  thisEventDate=""
  thisEventTime=""
  isValidDate=""
  isValidTime=""

  # Asking user for event date
  while [ "${isValidDate}" != "true" ]; do

    clear
    read -p "Event date (YYYY-MM-DD) => " thisEventDate

    if timestampValidateDate "${thisEventDate}" ; then
      isValidDate="true"
    fi

  done

  # Asking user for event time
  while [ "${isValidTime}" != "true" ]; do

    clear
    read -p "Event time (HH:MM) => " thisEventTime

    if timestampValidateTime "${thisEventTime}" ; then
      isValidTime="true"
    fi

  done

  # Adding event
  eventAdd "${thisEventDate}" "${thisEventTime}" "${nextInboxItemName}"

  # Deleting inbox item
  inboxDelete "${nextInboxItemName}"

}

interactiveInboxToHabit() {

  # Cleaning in memory variables
  thisHabitRecurrence=""
  isValidRecurrence=""

  # Asking user for habit recurrence
  while [ "${isValidRecurrence}" != "true" ]; do

    clear
    read -p "Habit frequency (daily/weekly/monthly/yearly) => " thisHabitRecurrence

    case "${thisHabitRecurrence}" in
      "daily")
        isValidRecurrence="true"
        ;;
      "weekly")
        isValidRecurrence="true"
        ;;
      "monthly")
        isValidRecurrence="true"
        ;;
      "yearly")
        isValidRecurrence="true"
        ;;
      *)
        isValidRecurrence="false"
        ;;
    esac

  done

  # Adding habit
  habitAdd "${thisHabitRecurrence}" "${nextInboxItemName}"

  # Deleting inbox item
  inboxDelete "${nextInboxItemName}"

}

interactiveReview() {

  usrMode="interactiveReview"
  usrChoice=""

  while [ true ]; do

    statsGet

    interactiveReviewDraw

    case "${usrChoice}" in
      # Modes
      "d"|"decide")
        interactiveDecide
        ;;
      "w"|"work")
        interactiveWork
        ;;
      # Global Actions
      "a"|"add")
        interactiveInboxAdd     ; "${usrMode}"
        ;;
      "s"|"sync")
        clear ; databaseSync    ; "${usrMode}"
        ;;
      "q"|"quit")
        logPrint info "Good review. Bye!" ; exit 0
        ;;
      # Local Actions
      "di"|"delete-item")
        inboxDelete "${nextInboxItemName}"
        "${usrMode}"
        ;;
      "e"|"event")
        interactiveInboxToEvent ; "${usrMode}"
        ;;
      "h"|"habit")
        interactiveInboxToHabit ; "${usrMode}"
        ;;
      "t"|"task")
        taskAdd "${nextInboxItemName}"
        inboxDelete "${nextInboxItemName}"
        "${usrMode}"
        ;;
      *)
        true
        ;;
    esac

    read -p "Choice => " usrChoice
  done

}

interactiveReviewDraw() {

  clear

  echo -e "${colorDim}+-----------------------${colorReset} ${colorBold}Lowbit Planner${colorReset} ${colorDim}(Bash Edition) ------------------------+${colorReset}"
  echo -e "${colorDim}|                                                                              |${colorReset}"
  echo -e "${colorDim}+-----------------------${colorReset} ${colorBold}Modes${colorReset}: ${colorBgLightRed}${colorUnderline}r${colorReset}${colorBgLightRed}eview${colorReset} ${colorDim}|${colorReset} ${colorUnderline}d${colorReset}ecide ${colorDim}|${colorReset} ${colorUnderline}w${colorReset}ork${colorReset} ${colorDim}------------------------+${colorReset}"
  echo
  echo -e "Inbox ${colorDim}(${colorLightGreen}${inboxCount}${colorReset}${colorDim})${colorReset}"
  echo
  echo -e "${nextInboxKey} ${colorBold}${colorLightGreen}${nextInboxItemName}${colorReset}"
  echo
  echo -e "${colorDim}Actions: ${colorUnderline}e${colorReset}${colorDim}vent | ${colorUnderline}h${colorReset}${colorDim}abit | ${colorUnderline}t${colorReset}${colorDim}ask | ${colorUnderline}d${colorReset}${colorDim}elete-${colorUnderline}i${colorReset}${colorDim}tem${colorReset}"
  echo
  echo -e "${colorDim}Global actions: ${colorUnderline}a${colorReset}${colorDim}dd (inbox) | ${colorUnderline}s${colorReset}${colorDim}ync | ${colorUnderline}q${colorReset}${colorDim}uit${colorReset}"
  echo

}

interactiveWork() {

  # Initializing variables
  usrMode="interactiveWork"
  usrChoice=""

  # Grabbing a habit
  habitShuffle

  while [ true ]; do

    statsGet

    interactiveWorkDraw

    case "${usrChoice}" in
      # Modes
      "d"|"decide")
        interactiveDecide
        ;;
      "r"|"review")
        interactiveReview
        ;;
      # Global Actions
      "a"|"add")
        interactiveInboxAdd   ; "${usrMode}"
        ;;
      "s"|"sync")
        clear ; databaseSync  ; "${usrMode}"
        ;;
      "q"|"quit")
        logPrint info "Good work. Bye!" ; exit 0
        ;;
      # Local Actions
      "ce"|"complete-event")
        eventComplete "${nextEventName}"
        "${usrMode}"
        ;;
      "ch"|"complete-habit")
        habitComplete "${nextHabitName}"
        "${usrMode}"
        ;;
      "ct"|"complete-task")
        taskComplete "${nextTaskName}"
        "${usrMode}"
        ;;
      "de"|"delete-event")
        eventDelete "${nextEventName}"
        "${usrMode}"
        ;;
      "dh"|"delete-habit")
        habitDelete "${nextHabitName}"
        "${usrMode}"
        ;;
      "dt"|"delete-task")
        taskDelete "${nextTaskName}"
        "${usrMode}"
        ;;
      "sh"|"skip-habit")
        habitShuffle
        "${usrMode}"
        ;;
      "st"|"skip-task")
        databaseTableSkip task
        "${usrMode}"
        ;;
      *)
        true
        ;;
    esac

    read -p "Choice => " usrChoice
  done

}

interactiveWorkDraw() {

  clear

  echo -e "${colorDim}+-----------------------${colorReset} ${colorBold}Lowbit Planner${colorReset} ${colorDim}(Bash Edition) ------------------------+${colorReset}"
  echo -e "${colorDim}|                                                                              |${colorReset}"
  echo -e "${colorDim}+-----------------------${colorReset} ${colorBold}Modes${colorReset}: ${colorUnderline}r${colorReset}eview ${colorDim}|${colorReset} ${colorUnderline}d${colorReset}ecide ${colorDim}|${colorReset} ${colorBgLightRed}${colorUnderline}w${colorReset}${colorBgLightRed}ork${colorReset} ${colorDim}------------------------+${colorReset}"
  echo
  echo -e "Next Items ${colorDim}${colorLightGray}(${colorLightGreen}${inboxCount}${colorLightGray}/${colorLightMagenta}${eventCount}${colorLightGray}/${colorLightYellow}${taskCount}${colorLightGray}/${colorLightCyan}${habitCount}${colorLightGray})${colorReset}"
  echo
  echo -e "  Event   : ${colorBold}${colorLightMagenta}${nextEventKey} ${nextEventName}${colorReset} (${nextEventTimestamp})"
  echo -e "  ${colorDim}Actions : ${colorUnderline}c${colorReset}${colorDim}omplete-${colorUnderline}e${colorReset}${colorDim}vent | ${colorUnderline}a${colorReset}${colorDim}dd-${colorUnderline}e${colorReset}${colorDim}vent | ${colorUnderline}d${colorReset}${colorDim}elete-${colorUnderline}e${colorReset}${colorDim}vent${colorReset}"
  echo
  echo -e "  Task    : ${colorBold}${colorLightYellow}${nextTaskKey} ${nextTaskName}${colorReset}"
  echo -e "  ${colorDim}Actions : ${colorUnderline}c${colorReset}${colorDim}omplete-${colorUnderline}t${colorReset}${colorDim}ask | ${colorUnderline}s${colorReset}${colorDim}kip-${colorUnderline}t${colorReset}${colorDim}ask | ${colorUnderline}a${colorReset}${colorDim}dd-${colorUnderline}t${colorReset}${colorDim}ask | ${colorUnderline}d${colorReset}${colorDim}elete-${colorUnderline}t${colorReset}${colorDim}ask${colorReset}"
  echo
  echo -e "  Habit   : ${colorBold}${colorLightCyan}${nextHabitKey} ${nextHabitName}${colorReset}"
  echo -e "${colorDim}  Actions : ${colorUnderline}c${colorReset}${colorDim}omplete-${colorUnderline}h${colorReset}${colorDim}abit | ${colorUnderline}s${colorReset}${colorDim}kip-${colorUnderline}h${colorReset}${colorDim}abit | ${colorUnderline}a${colorReset}${colorDim}dd-${colorUnderline}h${colorReset}${colorDim}abit | ${colorUnderline}d${colorReset}${colorDim}elete-${colorUnderline}h${colorReset}${colorDim}abit${colorReset}"
  echo
  echo -e "${colorDim}Global actions: ${colorUnderline}a${colorReset}${colorDim}dd (inbox) | ${colorUnderline}s${colorReset}${colorDim}ync | ${colorUnderline}q${colorReset}${colorDim}uit${colorReset}"
  echo

}
