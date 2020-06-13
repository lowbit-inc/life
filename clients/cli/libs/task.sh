#!/usr/bin/env bash

########
# Task #
########

taskAdd() {

  logPrint debug "Task Add"

  if [ "${1}" ]; then
    thisTaskName="${@}" ; logPrint debug "${thisTaskName}"
  else
    logPrint error "Missing task name"
    return 1
  fi

  if databaseTableCheckEntryExists task ".|${thisTaskName}$" ; then
    logPrint error "Task already exists: '${thisTaskName}'"
    return 1
  fi

  if databaseTableInsert task "[ ]" "`timestampGetNow`" "0" "${thisTaskName}" ; then
    logPrint info "New task created: '${thisTaskName}'"
  else
    logPrint error "Failed to create task: '${thisTaskName}'"
  fi

}

taskComplete() {

  if [ ! "${1}" ]; then
    logPrint error "Missing task name"
    exit 1
  fi

  thisTaskName="${@}"

  if ! databaseTableCheckEntryExists task ".|${thisTaskName}$" ; then
    logPrint error "Task not found: '${thisTaskName}'"
    exit 1
  fi
  
  if ! databaseTableInsert completed "[X]" "`timestampGetNow`" "${thisTaskName}" ; then
    logPrint error "Failed to mark task as completed: '${thisTaskName}'"
    exit 1
  fi

  if ! databaseTableDeleteByString task "|${thisTaskName}$" ; then
    logPrint error "Failed to delete task after marking it as completed: '${thisTaskName}'"
    exit 1
  fi

  logPrint info "Yay! Another task completed: '${thisTaskName}'"

}


taskDelete() {

  if [ ! "${1}" ]; then
    logPrint error "Missing task name"
    exit 1
  fi

  thisTaskName="${@}"

  if ! databaseTableCheckEntryExists task ".|${thisTaskName}$" ; then
    logPrint error "Task not found: '${thisTaskName}'"
    exit 1
  fi
  
  if databaseTableDeleteByString task "|${thisTaskName}$" ; then
    logPrint info "Task deleted: '${thisTaskName}'"
  else
    logPrint error "Failed to delete task: '${thisTaskName}'"
  fi

}

taskList() {

  logPrint debug "Task List"

  databaseTableList task 10 asc 1 4

}

taskShowUsage() {

  echo -e "${colorBold}Lowbit Planner - Task${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Usage:${colorReset}"
  echo -e "  ${colorBold}`basename $0` task${colorReset} ${colorUnderline}${colorLightRed}action${colorReset}${colorDim} [${colorReset}${colorUnderline}arguments${colorReset}${colorDim}]${colorReset}"
  echo
  echo -e "${colorBold}${colorLightGreen}Actions:${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}add${colorReset} ${colorUnderline}task_name${colorReset}            ${colorDim}- Create a new task${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}complete${colorReset} ${colorUnderline}task_name${colorReset}       ${colorDim}- Complete a task${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}delete${colorReset} ${colorUnderline}task_name${colorReset}         ${colorDim}- Delete a task${colorReset}"
  echo -e "  ${colorUnderline}${colorLightRed}list${colorReset}                     ${colorDim}- List tasks${colorReset}"
  echo
  exit 0

}

taskRouter() {

  if [ ! $1 ]; then
    taskShowUsage
  fi

  usrAction=$1

  case ${usrAction} in
    "add")
      logPrint debug "Action => ${usrAction}"
      shift
      taskAdd "${@}"
      ;;
    "complete")
      logPrint debug "Action => ${usrAction}"
      shift
      taskComplete "${@}"
      ;;
    "delete")
      logPrint debug "Action => ${usrAction}"
      shift
      taskDelete "${@}"
      ;;
    "list")
      logPrint debug "Action => ${usrAction}"
      shift
      taskList
      ;;
    "--help"|"-h"|"help")
      logPrint debug "Action => ${usrAction}"
      taskShowUsage
      ;;
    *)
      logPrint error "Unknown action '${usrAction}'"
      ;;
  esac

}
