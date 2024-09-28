#!/bin/bash

# declaration
GREEN="\033[32m"

if [[ $SHELL == *"zsh"* ]]; then
  shell_config="$HOME/.zshrc"
elif [[ $SHELL == *"bash"* ]]; then
  shell_config="$HOME/.bashrc"
else
  echo "Unsupported shell. Only zsh and bash are supported."
  exit 1
fi

echo "A backup of your original configuration file is saved as ${shell_config}.bak."
cp "$shell_config" "${shell_config}.bak"

sed -i.bak '/phpFlex()/,/^}/d' "$shell_config"
echo "phpFlex function has been removed from $shell_config."

echo "Please run 'source $shell_config' or restart your terminal to apply the changes."
echo -e "${GREEN}You can use following command to reload your configuration file:"

COMMAND=source $shell_config
LINK_TEXT="source $shell_config"

CLICKABLE_LINK="\033]8;;${COMMAND}\033\\${LINK_TEXT}\033]8;;\033\\"

echo -e "${GREEN}${CLICKABLE_LINK}${RESET}"