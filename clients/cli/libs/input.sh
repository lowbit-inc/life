#!/usr/bin/env bash

#########
# Input #
#########

inputAskString() {

  if [ "${1}" ] ; then
    thisName="${1}"
  else
    logPrint error "Missing required arg for 'inputAskString' function"
  fi

  unset inputUserAnswer

  until validateString "${inputUserAnswer}" ; do
    read -p "${thisName} => " inputUserAnswer
  done

}

inputGet() {

  # Cleaning
  unset inputReturn

  # Getting required args
  if [ "${2}" ] ; then
    thisInputType="${1}" ; logPrint debug "Input Type => ${thisInputType}" ; shift
    thisInputDescription="${1}" ; logPrint debug "Input Name => ${thisInputDescription}" ; shift
  else
    logPrint error "Missing required args for function 'inputGet'"
  fi

  # Validating input type
  case "${thisInputType}" in
    "string")
      thisValidator="validateString"
      ;;
    *)
      logPrint error "Unknown 'input type' for function 'inputGet'"
      ;;
  esac

  # Getting the input
  if [ "${1}" ]; then
    thisInputValue="${@}"

    if "${thisValidator}" "${thisInputValue}" ; then

      export inputReturn="${thisInputValue}"
      return 0

    else
      logPrint error "Invalid value for input type '${thisInputType}' (${thisInputValue})"
    fi

  else
  
    while [ true ] ; do
      read -p "${thisInputDescription}: " thisInputValue

      if "${thisValidator}" "${thisInputValue}" ; then

        export inputReturn="${thisInputValue}"
        return 0

      else
        logPrint warn "Invalid value for input type '${thisInputType}' - Please, try again..."
      fi
    done


  fi

  logPrint debug "Input Value => ${thisInputValue}"

}
