#!/usr/bin/env bash

#########
# Stats #
#########

statsGet() {

  # Inbox
  inboxCount=`databaseTableCount inbox`
  nextInbox=`databaseTableGetFirst inbox`
  nextInboxKey=`echo "${nextInbox}" | cut -d'|' -f1`
  nextInboxItemName=`echo "${nextInbox}" | cut -d'|' -f3`

  # Event
  eventCount=`databaseTableCount event`
  nextEvent=`databaseTableGetFirst event`
  nextEventKey=`echo "${nextEvent}" | cut -d'|' -f1`
  nextEventName=`echo "${nextEvent}" | cut -d'|' -f3`
  nextEventTimestamp=`echo "${nextEvent}" | cut -d'|' -f2`

  # Task
  taskCount=`databaseTableCount task`
  nextTask=`databaseTableGetFirst task`
  nextTaskKey=`echo "${nextTask}" | cut -d'|' -f1`
  nextTaskName=`echo "${nextTask}" | cut -d'|' -f4`

  # Habit
  habitCount=`databaseTableCount habit`
  nextHabit=`databaseTableGetFirst habit`
  nextHabitCompleted=`echo "${nextHabit}" | cut -d'|' -f5`

  if [[ "${nextHabitCompleted}" == "[ ]" ]]; then
    nextHabitKey=`echo "${nextHabit}" | cut -d'|' -f1`
    nextHabitName=`echo "${nextHabit}" | cut -d'|' -f6`
  else
    unset nextHabitKey
    unset nextHabitName
  fi

}
