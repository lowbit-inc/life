#!/usr/bin/env bash

#############
# Timestamp #
#############

timestampGetNow() {
  date "+%Y-%m-%d %H:%M"
}

timestampGetNowWithWeek() {
  date "+%Y-%m-%d %H:%M %U"
}

timestampValidateDate() {

  if [ $1 ]; then
    thisDate="${1}" ; logPrint debug "Validating date => ${thisDate}"
  else
    logPrint error "Missing date argument to validate"
    return 1
  fi

  if [[ $(echo "${thisDate}" | grep -e "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$") ]] ; then
    return 0
  else
    logPrint error "Invalid date format - Must be YYYY-MM-DD"
    return 1
  fi

}

timestampValidateTime() {

  if [ $1 ]; then
    thisTime="${1}" ; logPrint debug "Validating time => ${thisTime}"
  else
    logPrint error "Missing time argument to validate"
    return 1
  fi

  if [[ $(echo "${thisTime}" | grep -e "^[0-9][0-9]:[0-9][0-9]$") ]] ; then
    return 0
  else
    logPrint error "Invalid time format - Must be HH:MM"
    return 1
  fi

}
