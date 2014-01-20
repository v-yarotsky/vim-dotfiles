#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
MSG_WIDTH=$(expr $(tput cols) - 13)

function echo_step() {
  printf "%-*s%s" "$MSG_WIDTH" "$1"
}

function echo_ok() {
  printf " %s%s%s\n" "$GREEN" "[OK]" "$NORMAL"
}

function echo_err() {
  printf " %s%s%s\n" "$RED" "[FAIL]" "$NORMAL"
}

function echo_hint() {
  if [ -n "$1" ]; then
    echo >&2 "$1"
  fi
}

function run_or_fail() {
  local command_string=$1 command_out
  command_out=$(eval "$command_string" 2>&1) || {
    echo_err
    echo_hint "$command_out"
    exit 1
  }
  echo_ok
  [[ $SHOW_STDOUT && $command_out ]] && echo -e "\n$command_out\n" || true
}

VUNDLE_REPO="https://github.com/gmarik/vundle.git"

echo_step "Creating bundle directory (if it does not exist)"
run_or_fail "mkdir -p bundle"

if [ ! -d bundle/vundle ]; then
  echo_step "Cloning vundle repo to bundle/vundle"
  run_or_fail "git clone $VUNDLE_REPO bundle/vundle"
else
  echo "bundle/vundle exists. Skipping clone."
fi

echo_step "Installing plugins..."
run_or_fail "vim +BundleInstall +qall"

echo "Done."

