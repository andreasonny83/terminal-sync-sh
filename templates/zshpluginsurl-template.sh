#!/bin/bash
set -e

# Default settings
ZSH=${ZSH:-~/.oh-my-zsh}
ZSH_CUSTOM=${ZSH_CUSTOM:-$ZSH/custom}

main() {
  echo "Installing zsh-autosuggestions plugin..."
  if [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    echo "zsh-autosuggestions plugin already installed. Moving on"
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  fi

  echo "Installing zsh-nvm plugin..."
  if [[ -d "$ZSH_CUSTOM/plugins/zsh-nvm" ]]; then
    echo "zsh-nvm plugin already installed. Moving on"
  else
    git clone https://github.com/lukechilds/zsh-nvm.git $ZSH_CUSTOM/plugins/zsh-nvm
  fi

  echo "Installing powerlevel9k theme..."
  if [[ -d "$ZSH_CUSTOM/themes/powerlevel9k" ]]; then
    echo "powerlevel9k theme already installed. Moving on"
  else
    git clone https://github.com/Powerlevel9k/powerlevel9k.git $ZSH_CUSTOM/themes/powerlevel9k
  fi
}

main "$@"