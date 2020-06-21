#!/usr/bin/env bash

#######
# Log #
#######

logPrint() {
  thisLogLevel="${1}"
  thisLogString="${2}"

  case $thisLogLevel in

    "debug")
      if [ "${DEBUG}" == "true" ]; then
        echo -e "${colorDarkGray}[`date +'%Y-%m-%d %H:%M:%S'`${colorDarkGray}] [${colorDarkGray}debug${colorReset}${colorDarkGray}]${colorReset} ${thisLogString}"
      fi
      ;;
    "error")
      echo -e "${colorDarkGray}[`date +'%Y-%m-%d %H:%M:%S'`${colorDarkGray}] [${colorLightRed}error${colorReset}${colorDarkGray}]${colorReset} ${thisLogString}"
      exit 1
      ;;
    "info")
      echo -e "${colorDarkGray}[`date +'%Y-%m-%d %H:%M:%S'`${colorDarkGray}] [${colorLightGreen}info ${colorReset}${colorDarkGray}]${colorReset} ${thisLogString}"
      ;;
    "user")
      echo -e "${colorDarkGray}[`date +'%Y-%m-%d %H:%M:%S'`${colorDarkGray}] [${colorBlink}${colorLightMagenta}user ${colorReset}${colorDarkGray}]${colorReset} ${thisLogString}"
      ;;
    "warn")
      echo -e "${colorDarkGray}[`date +'%Y-%m-%d %H:%M:%S'`${colorDarkGray}] [${colorLightYellow}warn ${colorReset}${colorDarkGray}]${colorReset} ${thisLogString}"
      ;;

    *)
      echo "Error: Wrong log type"
      ;;

  esac

}

logTest() {
  logPrint debug "Test message"
  logPrint info "Test message"
  logPrint warn "Test message"
  logPrint error "Test message"
  logPrint user "Test message"
}
