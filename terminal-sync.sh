#!/bin/bash
set +x

# TODO: Git; Git config; .ssh; aws; npmrc; vim; vimconfig

PWD=${PWD}
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NC="\033[0m"

function AskQuestion ()
{
  local res
  echo -e "\n"
  read -p "$(echo -e $GREEN"?"$NC" $1? (Y/n) ")" res
  if [[ -z "$res" ]] || [[ "${res:0:1}" == "y" ]] || [[ "${res:0:1}" == "Y" ]]; then
    if [[ ! -z "$2" ]]; then
      echo "$2 ..."
    fi
    return 1
  fi

  return 0
}

echo "Checking XCode Tools..."

if [[ -d "$(xcode-select -p)" ]]; then
  echo "XCode Tools is already installed"
else
  xcode-select --install
fi

echo -e "\n"
read -p "Enter the URL containing your Terminal Sync configuration: " terminalsyncconfig
curl -fsSL $terminalsyncconfig > $PWD/.terminal-sync-tmp.sh
source $PWD/.terminal-sync-tmp.sh
rm $PWD/.terminal-sync-tmp.sh

AskQuestion "Do you want to install Homebrew" "Installing Homebrew"
if [[ "$?" == 1 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew tap homebrew/cask-versions
fi

AskQuestion "Do you want to install NodeJS" "Installing NodeJS"
if [[ "$?" == 1 ]]; then
  brew install node
fi

AskQuestion "Do you want to install Yarn" "Installing Yarn"
if [[ "$?" == 1 ]]; then
  brew install yarn
fi

AskQuestion "Do you want to install NVM" "Installing NVM"
if [[ "$?" == 1 ]]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi

AskQuestion "Do you want to install npmrc-cli" "Installing npmrc-cli"
if [[ "$?" == 1 ]]; then
  yarn global add npmrc
fi

AskQuestion "Do you want to install Terminal Fonts"
if [[ "$?" == 1 ]]; then
  echo "brew tap homebrew/cask-fonts"
  brew update --force --verbose
  brew tap homebrew/cask-fonts
  echo "Installing font Meslo..."
  brew install --cask font-meslo-lg
  brew install --cask font-meslo-for-powerline
  echo "Installing font Hack-Nerd..."
  brew install --cask font-hack-nerd-font
  echo "Installing font Fira-Code..."
  brew install --cask font-fira-code-nerd-font
  brew install --cask font-fira-code
fi

AskQuestion "Do you want to install iTerm2 (This requires Homebrew to be installed)" "Installing iTerm2"
if [[ "$?" == 1 ]]; then
  brew cask install iterm2
fi

AskQuestion "Do you want to download your custom iTerm2 configuration"
if [[ "$?" == 1 ]]; then
  if [[ -d "$HOME/itermConfig" ]]; then
    echo "itermConfig folder already exists"
  else
    mkdir $HOME/itermConfig
  fi
  curl $itermconfigurl > $HOME/itermConfig/iterm2.plist
  echo -e "\n${BLUE}iTerm configuration file saved to $HOME/itermConfig/iterm2.plist${NC}"
fi

AskQuestion "Do you want to install Oh-my-zsh"
if [[ "$?" == 1 ]]; then
  echo -e "\n${RED}You will need to restart your terminal and run this script again after Oh-my-zsh is installed.${NC}"
  read -p "(Press any key to continue) " anykey
  echo -e "\nInstalling Oh-my-zsh..."
  /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

AskQuestion "Do you want to import your existing zsh configuration"
if [[ "$?" == 1 ]]; then
  curl $zshrc > $HOME/.zshrc

  AskQuestion "Do you want to install your custom terminal plugins and themes"
  if [[ "$?" == 1 ]]; then
    /bin/bash -c "$(curl -fsSL $zshpluginsurl)"
  fi
fi

echo -e "\n\n${GREEN}All Done!${NC}\n\n"
exit 0
