#!/usr/bin/env bash

########
# Item #
########

itemSearch() {
  
  logPrint debug "Searching items"

  ## Input
  if [ "${1}" ]; then
    thisSearchTerm="${1}" ; shift ; logPrint debug "Term => ${thisSearchTerm}"
  else
    logPrint error "Missing search term"
    exit 1
  fi

  ## Output
  databaseTableListFilter inbox "${thisSearchTerm}" 1 3       ; echo
  databaseTableListFilter event "${thisSearchTerm}" 1 2 3     ; echo
  databaseTableListFilter task "${thisSearchTerm}" 1 4        ; echo
  databaseTableListFilter habit "${thisSearchTerm}" 1 5 3 6   ; echo
  databaseTableListFilter completed "${thisSearchTerm}" 1 2 3 ; echo

}
