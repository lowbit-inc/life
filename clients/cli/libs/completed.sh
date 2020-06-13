#!/usr/bin/env bash

#############
# Completed #
#############

completedList() {

  logPrint debug "Completed List"

  databaseTableList completed 100 desc 1 2 3

}
