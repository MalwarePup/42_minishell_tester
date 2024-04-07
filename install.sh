#!/usr/bin/env bash

HOME_DIR="$HOME"
TESTER_DIR="$HOME_DIR/.local/minishell_tester"
RC_FILE="$HOME_DIR/.zshrc"

# Exit on error
set -e

# Clean up previous installation
rm -rf "$TESTER_DIR"
mkdir -p "$TESTER_DIR"

# Clone the repository
git clone git@github.com:MalwarePup/minishell_tester.git "$TESTER_DIR"

# Determine the RC file based on the shell
if [[ "$SHELL" == *"bash"* ]]; then
		RC_FILE="$HOME_DIR/.bashrc"
fi

# Add mstest alias if not present
if ! grep -Fq "mstest=" "$RC_FILE"; then
		echo -e "\nalias mstest=\"bash $TESTER_DIR/tester.sh\"\n" >> "$RC_FILE"
		echo "mstest alias added to $RC_FILE"
fi

# Source the RC file to apply changes
# Check if we are in an interactive shell before sourcing
if [[ $- == *i* ]]; then
	source "$RC_FILE"
else
	echo "Not sourcing $RC_FILE because the shell is not interactive. You may need to source it manually."
fi
