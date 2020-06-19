#!/usr/bin/env bash

##########
# System #
##########

systemName="Lowbit Life - CLI"
systemVersion="v0.3.0"

systemCheckReturnCode() {

  thisRC=$?
  thisStringOK="${1}"
  thisStringError="${2}"

  if [ $thisRC -eq 0 ]; then
    logPrint info "${thisStringOK}"
  else
    logPrint error "${thisStringError}"
    exit 1
  fi

}

systemGetVersion() {

  echo "${systemName} (${systemVersion})"
  exit 0

}

systemHeader() {

  echo ""

}

systemInstall() {

  logPrint error "Sorry, this feature is not yet available."
  exit 1

}

systemLink() {

  if [ -h /usr/local/bin/plan ]; then
    logPrint info "The symbolic link already exists"
  else
    logPrint info "Creating a symbolic link to this script"
    logPrint user "You will be prompted to your 'sudo' password"
    sudo ln -s `realpath $0` /usr/local/bin/plan  ; systemCheckReturnCode "Symbolic link created" "Failed to create symbolic link"
  fi

}
