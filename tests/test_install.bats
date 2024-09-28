#!/usr/bin/env bats

HOME_DIR=$HOME
ZSHRC="$HOME_DIR/.zshrc"
BASHRC="$HOME_DIR/.bashrc"

GREEN="\033[32m"
RED="\033[31m"

setup() {
  # Create temporary config files
  touch "$ZSHRC"
  touch "$BASHRC"
}

teardown() {
  # Remove temporary config files
  rm -f "$ZSHRC"
  rm -f "$BASHRC"
}

@test "Run install.sh without errors" {
  run bash /usr/local/bin/install.sh
  [ "$status" -eq 0 ]
}

@test "Check if phpFlex function is added to .zshrc when using zsh" {
  SHELL="/bin/zsh"
  export SHELL

  run bash /usr/local/bin/install.sh
  grep -q "phpFlex()" "$ZSHRC"
  [ "$status" -eq 0 ]
}

@test "Check if phpFlex function is added to .bashrc when using bash" {
  SHELL="/bin/bash"
  export SHELL

  run bash /usr/local/bin/install.sh
  grep -q "phpFlex()" "$BASHRC"
  [ "$status" -eq 0 ]
}

@test "Check script behavior for unsupported shell" {
  SHELL="/usr/bin/fish"
  export SHELL

  run bash /usr/local/bin/install.sh
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Unsupported shell. Only zsh and bash are supported." ]]
}

@test "Ensure phpFlex function is not duplicated in .zshrc" {
  SHELL="/bin/zsh"
  export SHELL

  # Add function manually first
  echo "phpFlex()" >> "$ZSHRC"

  run bash /usr/local/bin/install.sh
  [ "$status" -eq 0 ]

  # Ensure there's only one occurrence of the phpFlex function
  occurrences=$(grep -c "phpFlex()" "$ZSHRC")
  [ "$occurrences" -eq 1 ]
}

@test "Check clickable link is generated for zsh" {
  SHELL="/bin/zsh"
  export SHELL

  run bash /usr/local/bin/install.sh
  [[ "$output" =~ "source $ZSHRC" ]]
}