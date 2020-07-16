#!/usr/bin/env bash

#################
# Backend - Git #
#################

backendPath="${HOME}/.lowbit/life/backend"

backendInitialize() {

  # Inbox
  echo "item_name,created_at" > "${backendPath}/inbox.csv"

}

backendCheck() {

  # Checking if backend directory exists locally
  if [ ! -d "${backendPath}" ]; then
    logPrint info "Backend: Repository not found - Cloning..."
    backendPrepare
  fi

  # Checking if backend database exists
  if [ ! -f "${backendPath}/inbox.csv" ]; then
    logPrint info "Backend: Database not found - Initializing..."
    backendInitialize
    backendSync
  fi

}

backendPrepare() {

  if git clone "${usrConfigURI}" "${backendPath}" >/dev/null 2>&1 ; then
    logPrint debug "Backend: Cloned"
  else
    logPrint warn "Failed to clone backend"
    return 1
  fi

}

backendSync() {

  logPrint debug "Backend: Syncing..."

  cd "${backendPath}"
  git pull --no-rebase > /dev/null 2>&1

  git add *.csv > /dev/null 2>&1

  git commit -m "Database update - `timestampGetNow`" > /dev/null 2>&1

  if ! git push origin master > /dev/null 2>&1 ; then
    logPrint warn "Failed to push to remote repository"
    return 1
  fi

  cd "${OLDPWD}"

}