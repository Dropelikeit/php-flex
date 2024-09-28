#!/usr/bin/env bats

HOME_DIR=$HOME
ZSHRC="$HOME_DIR/.zshrc"
BASHRC="$HOME_DIR/.bashrc"

setup() {
  # Create temporary config files
  touch "$ZSHRC"
  touch "$BASHRC"
}

teardown() {
  # Remove temporary config files
  rm -f "$ZSHRC"*
  rm -f "$BASHRC"*
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

@test "Check install script behavior for unsupported shell" {
  SHELL="/usr/bin/fish"
  export SHELL

  run bash /usr/local/bin/install.sh
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Unsupported shell. Only zsh and bash are supported." ]]
}

@test "Run uninstall.sh without errors" {
  SHELL="/bin/zsh"
  export SHELL

  # First, install the function
  run bash /usr/local/bin/install.sh
  [ "$status" -eq 0 ]

  # Then, uninstall it
  run bash /usr/local/bin/uninstall.sh
  [ "$status" -eq 0 ]
}

@test "Check if phpFlex function is removed from .zshrc when using zsh" {
  SHELL="/bin/zsh"
  export SHELL

  # First, install the function
  run bash /usr/local/bin/install.sh
  [ "$status" -eq 0 ]

  # Then, uninstall it
  run bash /usr/local/bin/uninstall.sh
  [ "$status" -eq 0 ]

  # Ensure the function is removed
  ! grep -q "phpFlex()" "$ZSHRC"
  [ "$status" -eq 0 ]
}

@test "Check if phpFlex function is removed from .bashrc when using bash" {
  SHELL="/bin/bash"
  export SHELL

  # First, install the function
  run bash /usr/local/bin/install.sh
  [ "$status" -eq 0 ]

  # Then, uninstall it
  run bash /usr/local/bin/uninstall.sh
  [ "$status" -eq 0 ]

  # Ensure the function is removed
  ! grep -q "phpFlex()" "$BASHRC"
  [ "$status" -eq 0 ]
}

@test "Check uninstall script behavior for unsupported shell" {
  SHELL="/usr/bin/fish"
  export SHELL

  run bash /usr/local/bin/uninstall.sh
  [ "$status" -eq 1 ]
  [[ "$output" =~ "Unsupported shell. Only zsh and bash are supported." ]]
}