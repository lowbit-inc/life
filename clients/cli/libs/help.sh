#!/usr/bin/env bash

########
# Help #
########

helpGet() {

  echo -e "${colorBold}Lowbit Life - CLI${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0`${colorReset} ${colorDim}[${colorReset}${colorUnderline}${colorLightCyan}object${colorReset}${colorDim}]${colorReset} ${colorUnderline}${colorLightMagenta}command${colorReset} ${colorDim}[${colorReset}${colorUnderline}${colorLightYellow}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Cash objects:${colorReset}"
  echo -e "  ${colorLightCyan}account${colorReset}        ${colorDim}- Account operations${colorReset}"
  echo -e "  ${colorLightCyan}budget${colorReset}         ${colorDim}- Budget operations${colorReset}"
  echo -e "  ${colorLightCyan}transaction${colorReset}    ${colorDim}- Transactions operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Event objects:${colorReset}"
  echo -e "  ${colorLightCyan}event${colorReset}          ${colorDim}- Events operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}GTD objects:${colorReset}"
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
  echo -e "${colorBold}${colorLightGreen}Habit objects:${colorReset}"
  echo -e "  ${colorLightCyan}habit${colorReset}          ${colorDim}- Habits operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Quick commands:${colorReset}"
  echo -e "  ${colorLightMagenta}add ${colorLightYellow}item${colorReset}       ${colorDim}- Adds an item to the Inbox${colorReset}"
  echo -e "  ${colorLightMagenta}completed${colorReset}      ${colorDim}- Prints a list of last completed items${colorReset}"
  echo -e "  ${colorLightMagenta}search${colorReset} ${colorLightYellow}item${colorReset}    ${colorDim}- Search matching items in all available objects${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Interactive commands:${colorReset}"
  echo -e "  ${colorLightMagenta}gtd${colorReset}            ${colorDim}- Starts the interactive GTD mode${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}System commands:${colorReset}"
  echo -e "  ${colorLightMagenta}config${colorReset}         ${colorDim}- Configuration assistant${colorReset}"
  echo -e "  ${colorLightMagenta}help${colorReset}           ${colorDim}- Prints this help message${colorReset}"
  echo -e "  ${colorLightMagenta}install${colorReset}        ${colorDim}- Installs this CLI system-wide${colorReset}"
  echo -e "  ${colorLightMagenta}sync${colorReset}           ${colorDim}- Sync the backend (when supported)${colorReset}"
  echo -e "  ${colorLightMagenta}version${colorReset}        ${colorDim}- Prints the CLI version${colorReset}"
  echo
  exit 0

}
