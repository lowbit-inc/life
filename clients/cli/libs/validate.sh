#!/usr/bin/env bash

############
# Validate #
############

validateForbiddenCharacters=',|"'

validateString() {

  if [ "${1}" ] ; then
    thisString="${1}"
  else
    return 1
  fi

  if ! echo "${thisString}" | grep -E ${validateForbiddenCharacters} >/dev/null 2>&1 ; then
    logPrint debug "Valid string: ${thisString}"
    return 0
  else
    logPrint debug "Invalid string: ${thisString}"
    return 1
  fi
}