#!/bin/bash

# declaration
GREEN="\033[32m"
RED="\033[31m"

# PHPFlex function
php_flex_function='
phpFlex() {
  local version=$1
  if [[ -z $version ]]; then
    echo "Please specify a PHP version, e.g., phpFlex 8.1 -v"
    return 1
  fi

  # ignore parameter one because it is not necessary for the php command
  shift

  local php_path=$(find /usr/local/Cellar/php@${version} -name "php" 2>/dev/null | head -n 1)
  if [[ -z $php_path ]]; then
    php_path=$(find /usr/local/Cellar/php/${version} -name "php" 2>/dev/null | head -n 1)
  fi
  if [[ -n $php_path ]]; then
    "$php_path" "$@"
  else
    echo "PHP $version not found."
    return 1
  fi
}
'

# Check, which shell is currently being used to find the correct configuration file
if [[ $SHELL == *"zsh"* ]]; then
  shell_config="$HOME/.zshrc"
elif [[ $SHELL == *"bash"* ]]; then
  shell_config="$HOME/.bashrc"
else
  echo "Unsupported shell. Only zsh and bash are supported."
  exit 1
fi

# Add the function if it does not yet exist.
if grep -q "phpFlex()" "$shell_config"; then
  echo -e "${RED}The phpFlex function is already defined in $shell_config."
else
  echo "$php_flex_function" >> "$shell_config"
  echo "phpFlex function added to $shell_config."
  echo "Please run 'source $shell_config' or restart your terminal to apply the changes. You can use \"source "
  echo -e "${GREEN}You can use following command to reload your configuration file:"

  COMMAND=source $shell_config
  LINK_TEXT="source $shell_config"

  CLICKABLE_LINK="\033]8;;${COMMAND}\033\\${LINK_TEXT}\033]8;;\033\\"

  echo -e "${GREEN}${CLICKABLE_LINK}"
fi