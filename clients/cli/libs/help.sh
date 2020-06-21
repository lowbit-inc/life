#!/usr/bin/env bash

########
# Help #
########

helpGet() {

  echo -e "${colorBold}${systemName}${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0`${colorReset} ${colorUnderline}${colorLightCyan}command${colorReset} ${colorDim}[${colorReset}${colorUnderline}${colorLightMagenta}subcommand${colorReset}${colorDim}]${colorReset} ${colorDim}[${colorReset}${colorUnderline}${colorLightYellow}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Cash commands:${colorReset}"
  echo -e "  ${colorLightCyan}account${colorReset}        ${colorDim}- Account operations${colorReset}"
  echo -e "  ${colorLightCyan}budget${colorReset}         ${colorDim}- Budget operations${colorReset}"
  echo -e "  ${colorLightCyan}transaction${colorReset}    ${colorDim}- Transactions operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Event commands:${colorReset}"
  echo -e "  ${colorLightCyan}event${colorReset}          ${colorDim}- Events operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}GTD commands:${colorReset}"
  echo -e "  ${colorLightCyan}action${colorReset}         ${colorDim}- Actions (tasks) operations${colorReset}"
  echo -e "  ${colorLightCyan}area${colorReset}           ${colorDim}- Area operations${colorReset}"
  echo -e "  ${colorLightCyan}checklist${colorReset}      ${colorDim}- Checklists operations${colorReset}"
  echo -e "  ${colorLightCyan}goal${colorReset}           ${colorDim}- Goals operations${colorReset}"
  echo -e "  ${colorLightCyan}inbox${colorReset}          ${colorDim}- Inbox operations${colorReset}"
  echo -e "  ${colorLightCyan}principle${colorReset}      ${colorDim}- Principles operations${colorReset}"
  echo -e "  ${colorLightCyan}project${colorReset}        ${colorDim}- Projects operations${colorReset}"
  echo -e "  ${colorLightCyan}purpose${colorReset}        ${colorDim}- Purpose operations${colorReset}"
  echo -e "  ${colorLightCyan}responsibility${colorReset} ${colorDim}- Responsibilities operations${colorReset}"
  echo -e "  ${colorLightCyan}someday${colorReset}        ${colorDim}- Someday/Maybe (later) operations${colorReset}"
  echo -e "  ${colorLightCyan}vision${colorReset}         ${colorDim}- Vision operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Habit commands:${colorReset}"
  echo -e "  ${colorLightCyan}habit${colorReset}          ${colorDim}- Habits operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Quick commands:${colorReset}"
  echo -e "  ${colorLightCyan}add ${colorLightYellow}item${colorReset}       ${colorDim}- Adds an item to the Inbox${colorReset}"
  echo -e "  ${colorLightCyan}completed${colorReset}      ${colorDim}- Prints a list of last completed items${colorReset}"
  echo -e "  ${colorLightCyan}search${colorReset} ${colorLightYellow}item${colorReset}    ${colorDim}- Search matching items in all available objects${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Interactive commands:${colorReset}"
  echo -e "  ${colorLightCyan}gtd${colorReset}            ${colorDim}- Starts the interactive GTD mode${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}System commands:${colorReset}"
  echo -e "  ${colorLightCyan}config${colorReset}         ${colorDim}- Configuration assistant${colorReset}"
  echo -e "  ${colorLightCyan}help${colorReset}           ${colorDim}- Prints this help message${colorReset}"
  echo -e "  ${colorLightCyan}install${colorReset}        ${colorDim}- Installs this CLI system-wide${colorReset}"
  echo -e "  ${colorLightCyan}sync${colorReset}           ${colorDim}- Sync the backend (when supported)${colorReset}"
  echo -e "  ${colorLightCyan}version${colorReset}        ${colorDim}- Prints the CLI version${colorReset}"

  exit 0

}

helpGetInbox() {

  echo -e "${colorBold}${systemName} (Inbox)${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0` ${colorLightCyan}inbox${colorReset} ${colorUnderline}${colorLightMagenta}subcommand${colorReset}${colorDim} [${colorReset}${colorLightYellow}${colorUnderline}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Commands:${colorReset}"
  echo -e "  ${colorLightMagenta}add ${colorLightYellow}item${colorReset}                 ${colorDim}- Add an item to the inbox${colorReset}"
  echo -e "  ${colorLightMagenta}delete ${colorLightYellow}item${colorReset}              ${colorDim}- Delete an item from the inbox${colorReset}"
  echo -e "  ${colorLightMagenta}list${colorReset}                     ${colorDim}- List inbox items${colorReset}"
  echo -e "  ${colorLightMagenta}rename ${colorLightYellow}old_name new_name${colorReset} ${colorDim}- Rename an inbox item${colorReset}"

  exit 0

}