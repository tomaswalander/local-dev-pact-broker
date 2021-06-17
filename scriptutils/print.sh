#!/bin/bash

STEP_COUNT=0
CURRENT_STEP=""
BOLD=true
COLOR_BLACK="30"
COLOR_RED="31"
COLOR_GREEN="32"
COLOR_YELLOW="93"
COLOR_BLUE="34"
COLOR_CYAN="36"

argParser_getPrintColor() {
  echo $1
}

argParser_getShouldPrintBold() {
  shift
  local potentialBoldValue=$1
  local isBold=false
  if [ "$potentialBoldValue" = true ] || [ "$potentialBoldValue" = false ]; then
      isBold=$potentialBoldValue
  fi
  echo $isBold
}

argParser_getPrintText() {
  shift
  local potentialBoldValue=$1
  shift
  local text=$@
  if [ "$potentialBoldValue" != true ] && [ "$potentialBoldValue" != false ]; then
    text="$potentialBoldValue $text"
  fi
  echo $text
}

print() {
  local color=$(argParser_getPrintColor $@)
  local isBold=$(argParser_getShouldPrintBold $@)
  local text=$(argParser_getPrintText $@)
  if [ $isBold = true ]; then
    printf "\033[${color};1m${text}\033[0m"
  else 
    printf "\033[${color};0m${text}\033[0m"
  fi
}

println() {
  echo $(print $@)
}

print_char_times() {
 str=$1
 num=$2
 v=$(printf "%-${num}s" "$str")
 echo "${v// /${str}}"
}
print_spaces_times() {
  printf "%-${1}s"
}

title() {
  local textLength=${#1}
  local borderLength=$(($(tput cols)-2))
  local spacerLength=$(($(($borderLength-$textLength))/2))
  breakline 2
  println $COLOR_BLACK $BOLD "#$(print_char_times "#" ${borderLength})#"
  printf "#"
  print_spaces_times ${spacerLength}
  print $COLOR_BLACK $BOLD $1
  print_spaces_times ${spacerLength}
  printf "#"
  println $COLOR_BLACK $BOLD "#$(print_char_times "#" ${borderLength})#"
}

step_print() {
  local color=$(argParser_getPrintColor $@)
  local isBold=$(argParser_getShouldPrintBold $@)
  local text=$(argParser_getPrintText $@)
  println $color $isBold "[STEP ${STEP_COUNT}] - ${text}"
}

step_start() {
  ((STEP_COUNT++))
  CURRENT_STEP=$1
  breakline
  step_print $COLOR_BLUE $BOLD "$CURRENT_STEP"
  start=$(date +%s)
}

step_end() {
  end=$(date +%s)
  step_print $COLOR_BLUE $BOLD "${CURRENT_STEP} - Completed in $((($end-$start)%60))s"
  CURRENT_STEP=""
}

print_step_or_normal() {
  if [ "$CURRENT_STEP" = "" ]; then
    println $@
  else
    step_print $@
  fi
}

success() {
  print_step_or_normal $COLOR_GREEN $BOLD $1
}

error() {
  print_step_or_normal $COLOR_RED $BOLD $1
}

info() {
  print_step_or_normal $COLOR_CYAN $BOLD $1
}

warn() {
  print_step_or_normal $COLOR_YELLOW $BOLD $1
}

breakline() {
  local count=${1:-1}
  COUNTER=0
  while [  $COUNTER -lt $count ]; do
      printf "\n"
      let COUNTER=COUNTER+1 
  done 
}
