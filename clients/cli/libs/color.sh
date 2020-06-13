#!/usr/bin/env bash

#########
# Color #
#########

if [ ! "${COLOR}" == "false" ]; then

  colorReset="\e[0m"
  colorBold="\e[1m"
  colorDim="\e[2m"
  colorUnderline="\e[4m"
  colorBlink="\e[5m"
  colorRed="\e[31m"
  colorGreen="\e[32m"
  colorYellow="\e[33m"
  colorBlue="\e[34m"
  colorMagenta="\e[35m"
  colorCyan="\e[36m"
  colorLightGray="\e[37m"
  colorDarkGray="\e[90m"
  colorLightRed="\e[91m"
  colorLightGreen="\e[92m"
  colorLightYellow="\e[93m"
  colorLightBlue="\e[94m"
  colorLightMagenta="\e[95m"
  colorLightCyan="\e[96m"
  colorBgLightRed="\e[101m"
  colorBgLightGreen="\e[102m"

fi
