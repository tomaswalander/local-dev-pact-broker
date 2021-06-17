#!/bin/bash
source "$(pwd)/scriptutils/print.sh"

promptYesNo() {
  local message=$@
  while true; do
    read -p "$(info "${message} (y/Y or n/N):\t")" yn
    case $yn in
      [Yy]* ) break;;
      [Nn]* ) break;;
      * ) echo "Only y/Y (for yes) or n/N (for no) is accepted.";;
    esac
  done
  if [ "$yn" == "n" ]; then
    echo "n"
  fi
  if [ "$yn" == "N" ]; then
    echo "n"
  fi
  if [ "$yn" == "y" ]; then
    echo "y"
  fi
  if [ "$yn" == "Y" ]; then
    echo "y"
  fi
  
}

promptContinue() {
  local yn=$(promptYesNo "Do you want to continue (y/n)?")
  if [ "$yn" == "n" ]; then
    info "Exiting..."
    exit 0
  fi
}

promptQuestion () {
  local prompt_text=$@
  read -p "$(info "${prompt_text}:") " value
  echo ${value}
}

promptWithDefault() {
  local prompt_text=$1
  shift
  local prompt_default=$@
  shift
  local prompt_default_text=""
  if [ "$prompt_default" != "" ]; then
    prompt_default_text=" [${prompt_default}]"
  fi
  local value=$(promptQuestion ${prompt_text} ${prompt_default_text})
  echo ${value:-$prompt_default}
}