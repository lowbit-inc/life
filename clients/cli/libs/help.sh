#!/usr/bin/env bash

########
# Help #
########

helpShow() {

  echo "Help Topics:"
  echo "- Inbox"
  echo "- Tasks"
  echo "- Habits"
  echo "- Events"
  echo "- Quick Commands"
  echo "- Legend"
  echo "- Commands Usage"
  echo "- Search"
  echo "- Completed Items"
  echo "- Interactive Modes"
  echo "- Link"
  echo "- Update"
  echo "- Sync"

}

helpUsage() {

  echo "Lowbit Life - CLI"
  echo
  echo "Usage:"
  echo "  `basename $0` command [action] [arguments]"
  echo
  echo "Cash commands:"
  echo "  account"
  echo "  budget"
  echo "  transaction"
  echo
  echo "Event commands:"
  echo "  event"
  echo
  echo "GTD commands:"
  echo "  action"
  echo "  area"
  echo "  checklist"
  echo "  goal"
  echo "  inbox"
  echo "  principle"
  echo "  project"
  echo "  purpose"
  echo "  reference"
  echo "  responsibility"
  echo "  someday"
  echo "  vision"
  echo
  echo "Habit commands:"
  echo "  habit"
  echo
  echo "Quick commands:"
  echo "  add"
  echo "  completed"
  echo "  list"
  echo "  search"
  echo
  echo "Interactive commands:"
  echo "  plan"
  echo "  work"
  echo
  echo "System commands:"
  echo "  install"
  echo "  config"
  echo "  version"
  echo

  exit 0

}

helpUsageOld() {

  echo -e "${colorBold}Lowbit Planner - Bash Edition${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0`${colorReset} ${colorUnderline}${colorLightMagenta}command${colorReset} ${colorDim}[${colorReset}${colorUnderline}${colorLightRed}action${colorReset}${colorDim}] [${colorReset}${colorUnderline}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Quick commands:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}add${colorReset} ${colorUnderline}item_name${colorReset} ${colorDim}- Add an item to the inbox${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Basic commands:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}completed${colorReset}     ${colorDim}- List of completed items${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}event${colorReset}         ${colorDim}- Event operations${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}habit${colorReset}         ${colorDim}- Habit operations${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}inbox${colorReset}         ${colorDim}- Inbox operations${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}search${colorReset} ${colorUnderline}term${colorReset}   ${colorDim}- Search items in database${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}sync${colorReset}          ${colorDim}- Sync database using Git${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}task${colorReset}          ${colorDim}- Task operations${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Interactive commands:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}decide${colorReset}        ${colorDim}- Start the 'Decision' mode${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}review${colorReset}        ${colorDim}- Start the 'Revision' mode${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}work${colorReset}          ${colorDim}- Start the 'Work' mode${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}System Commands:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}--help${colorReset}        ${colorDim}- Display a help message${colorReset}"
  # echo -e "  ${colorUnderline}${colorLightMagenta}--install${colorReset}     ${colorDim}- Install this script${colorReset}"
  echo -e "  ${colorUnderline}${colorLightMagenta}--link${colorReset}        ${colorDim}- Create a symbolic link to this script${colorReset}"
  # echo -e "  ${colorUnderline}${colorLightMagenta}--version${colorReset}     ${colorDim}- Display the script version${colorReset}"
  echo
  exit 0

}
