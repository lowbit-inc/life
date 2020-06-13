#!/usr/bin/env bash

############
# Database #
############

databasePath="${HOME}/.lowbit-planner"
databaseTables="
  completed
  events
  habits
  inbox
  task
"

databaseCheckIfExists() {
  if [ -d "${databasePath}" ]; then
    logPrint debug "Database found at => ${databasePath}"
  else
    logPrint info "Database not found - Creating one at [${databasePath}]"
    databaseCreate
  fi
}

databaseCreate() {

  # Database (directory)
  mkdir -p "${databasePath}"    ; systemCheckReturnCode "Initializing database structure" "Error creating database structure"

  # Tables (files)
  for table in $databaseTables; do
    touch "${databasePath}/${table}.db" ; systemCheckReturnCode "Initializing table: ${table}" "Failed to initialize table '${table}'"
  done

}

databaseSync() {

  logPrint debug "Starting sync process"

  cd "${databasePath}"                                ; systemCheckReturnCode "Database - OK" "Database not found at '${databasePath}'"
  git pull                                            > /dev/null 2>&1  ; systemCheckReturnCode "Pulling remote changes - OK" "Failed to pull from git repository"
  git add .                                           > /dev/null 2>&1  ; systemCheckReturnCode "Adding local changes - OK" "Failed to add database for commit"
  git commit -m "Database update - `timestampGetNow`" > /dev/null 2>&1  # This step is not checked (it fails when there are no changes)
  git push                                            > /dev/null 2>&1  ; systemCheckReturnCode "Pushing to repository - OK" "Failed to push to git repository"

}

databaseTableCheckEntryExists() {

  logPrint debug "Checking if an entry exists in a column of a table"

  if [ "${2}" ]; then
    thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"
    thisString="${1}" ; shift ; logPrint debug "String => ${thisString}"
  else
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  if [[ $(grep -e "${thisString}" "${databasePath}/${thisTable}.db") ]] ; then
    logPrint debug "Entry found"
    return 0
  else
    logPrint debug "Entry not found"
    return 1
  fi

}

databaseTableCount() {

  if [ "${1}" ]; then
    thisTable="${1}" ; shift
  else
    logPrint error "Missing table name"
    exit 1
  fi

  wc -l "${databasePath}/${thisTable}.db" | awk '{print $1}'

}

databaseTableDeleteByString() {

  logPrint debug "Database => Deleting entry by string"

  if [ ! "${2}" ]; then
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  # Assigning the user args
  thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"
  thisString="${1}" ; shift ; logPrint debug "String => ${thisTable}"

  # Deleting
  sed -i .bkp "/${thisString}/d" "${databasePath}/${thisTable}.db"

}

databaseTableDeleteFirst() {

  logPrint debug "Database => Delete first"

  if [ ! "${1}" ]; then
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  # Assigning the user args
  thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"

  sed -i .bkp '1d' "${databasePath}/${thisTable}.db"

}

databaseTableGetByString() {

  ## Input
  if [ $2 ]; then
    thisTable=$1  ; shift
    thisString=$1 ; shift
  else
    logPrint error "Missing one of required arguments"
    return 1
  fi

  ## Output
  grep "${thisString}" "${databasePath}/${thisTable}.db"

}

databaseTableGetFirst() {

  ## Input
  if [ $1 ]; then
    thisTable=$1  ; shift
  else
    logPrint error "Missing table name"
  fi

  ## Output
  head -n 1 "${databasePath}/${thisTable}.db"

}

databaseTableInsert() {

  logPrint debug "Database => Insert"

  if [ ! "${2}" ]; then
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  # Assigning the user args
  thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"
  thisKey="${1}"    ; shift ; logPrint debug "Key => ${thisKey}"

  # Preparing the entry
  thisEntry="${thisKey}"

  # Appending additional/optional fields
  while [ "${1}" ]; do
    thisEntry="${thisEntry}|${1}"
    shift
  done

  # Adding entry to the table
  logPrint debug "Entry => ${thisEntry}"
  echo "${thisEntry}" >> "${databasePath}/${thisTable}.db"
  systemCheckReturnCode "Database operation - OK" "Failed to write to database"

}

databaseTableList() {

  logPrint debug "Database => List $@"

  if [ ! "${4}" ]; then
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  # Assigning the user args
  thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"
  thisLimit="${1}"  ; shift ; logPrint debug "Limit => ${thisLimit}"
  thisOrder="${1}"  ; shift ; logPrint debug "Order => ${thisOrder}"
  thisKey="${1}"    ; shift ; logPrint debug "Key => ${thisKey}"

  # Validating Order arg
  case "${thisOrder}" in
    "asc"|"ASC")
      thisOrderCommand="head"
      ;;
    "desc"|"DESC")
      thisOrderCommand="tail"
      ;;
    *)
      logPrint error "Wrong value for 'order' argument"
      exit 1
      ;;
  esac

  # Header
  echo -e "${colorBold}${colorUnderline}${colorLightGreen}${thisTable^}${colorReset} ${colorDim}(limited to ${thisLimit})${colorReset}"
  echo

  # Looping through each entry
  IFS=$'\n'
  for entry in $(${thisOrderCommand} -n ${thisLimit} "${databasePath}/${thisTable}.db"); do

    # Key
    echo -en "${thisPrefix}${colorBold}`echo "${entry}" | cut -d'|' -f${thisKey}`${colorReset}"

    # Additional/optional fields
    unset IFS
    for field in $@; do
      echo -n " `echo "${entry}" | cut -d'|' -f$field`"
    done

    # New line
    echo

  done

}

databaseTableListFilter() {

  logPrint debug "Database => Listing with Filter"

  if [ ! "${3}" ]; then
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  # Assigning the user args
  thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"
  thisString="${1}" ; shift ; logPrint debug "String => ${thisString}"
  thisKey="${1}"    ; shift ; logPrint debug "Key => ${thisKey}"

  # Header
  echo -e "${colorBold}${colorUnderline}${colorLightGreen}${thisTable^}${colorReset} ${colorDim}(results for '${thisString}')${colorReset}"
  echo

  # Looping through each entry
  IFS=$'\n'
  for entry in $(grep -i "${thisString}" "${databasePath}/${thisTable}.db"); do

    # Key
    echo -en "${thisPrefix}${colorBold}`echo "${entry}" | cut -d'|' -f${thisKey}`${colorReset}"

    # Additional/optional fields
    unset IFS
    for field in $@; do
      echo -n " `echo "${entry}" | cut -d'|' -f$field`"
    done

    # New line
    echo

  done

}

databaseTableShuffle() {

  logPrint debug "Shuffling table entries"

  ## Input
  if [ $1 ]; then
    thisTable="${1}" ; shift ; logPrint debug "Table => ${thisTable}"
  fi

  ## Output
  if sort "${databasePath}/${thisTable}.db" --random-sort --output="${databasePath}/${thisTable}.db" ; then
    logPrint debug "Table shuffled"
    return 0
  else
    logPrint debug "Failed to shuffle table"
    return 1
  fi
  
}

databaseTableSkip() {

  logPrint debug "Skipping item in database"

  ## Input
  if [ "${1}" ]; then
    thisTable="${1}" ; shift ; logPrint debug "Table => ${thisTable}"
  else
    logPrint error "Missing table name"
    return 1
  fi

  # Copying first entry of "database" to the end of the file
  head -n1 "${databasePath}/${thisTable}.db" >> "${databasePath}/${thisTable}.db"

  # Deleting first entry from the "database"
  sed -i .bkp '1d' "${databasePath}/${thisTable}.db"


}

databaseTableSort() {

  logPrint debug "Sorting table entries"

  ## Input
  if [ $3 ]; then
    thisTable="${1}"  ; shift ; logPrint debug "Table => ${thisTable}"
    thisColumn="${1}" ; shift ; logPrint debug "Column => ${thisColumn}"
    thisOrder="${1}"  ; shift ; logPrint debug "Order => ${thisOrder}"
  fi

  # Validating Order arg
  case "${thisOrder}" in
    "asc"|"ASC")
      thisOrderCommand=""
      ;;
    "desc"|"DESC")
      thisOrderCommand="--reverse"
      ;;
    *)
      logPrint error "Wrong value for 'order' argument"
      exit 1
      ;;
  esac

  ## Output
  if sort "${databasePath}/${thisTable}.db" -s --field-separator "|" --key "${thisColumn}" ${thisOrderCommand} --output="${databasePath}/${thisTable}.db" ; then
    logPrint debug "Table sorted"
    return 0
  else
    logPrint debug "Failed to sort table"
    return 1
  fi
  
}

databaseTableUpdateEntry() {

  logPrint debug "Database => Updating an entry"

  if [ "${3}" ]; then
    # Assigning the user args
    thisTable="${1}"    ; shift ; logPrint debug "Table => ${thisTable}"
    thisOldValue="${1}" ; shift ; logPrint debug "Old Value => ${thisOldValue}"
    thisNewValue="${1}" ; shift ; logPrint debug "New Value => ${thisNewValue}"
  else
    logPrint error "Missing at least one of the required arguments"
    exit 1
  fi

  # Updating the entry
  if sed -i .bkp s^"${thisOldValue}"^"${thisNewValue}"^ "${databasePath}/${thisTable}.db" ; then
    logPrint debug "OK - entry updated"
    return 0
  else
    logPrint error "Failed to update entry in table: ${thisTable}"
    exit 1
  fi

}
