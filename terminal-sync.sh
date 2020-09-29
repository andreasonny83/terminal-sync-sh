#!/bin/bash
set +x

# download config from server
# Git
# Git config
# .ssh

echo "Checking XCode Tools..."

if [[ -d "$(xcode-select -p)" ]]; then
  echo "XCode Tools is already installed"
else
  xcode-select --install
fi

echo -e "\n"
read -p  "Do you want to install Homebrew? (Y/n) " homebrew

if [[ -z "$homebrew" ]] || [[ "${homebrew:0:1}" == "y" ]] || [[ "${homebrew:0:1}" == "Y" ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo -e "\n"
read -p   "Do you want to install iTerm2 (This requires Homebrew to be installed)? (Y/n) " iterm

if [[ -z "$iterm" ]] || [[ "${iterm:0:1}" == "y" ]] || [[ "${iterm:0:1}" == "Y" ]]; then
  echo "Installing iTerm2..."
  brew cask install iterm2
fi

echo -e "\n"
read -p "Do you want to install Oh-my-zsh? (Y/n) " ohmyzsh

if [[ -z "$ohmyzsh" ]] || [[ "${ohmyzsh:0:1}" == "y" ]] || [[ "${ohmyzsh:0:1}" == "Y" ]]; then
  echo "You will need to restart your terminal and run this script again after Oh-my-zsh is installed."$'\n'"(Press any key to continue) " anykey
  echo "Installing Oh-my-zsh..."
  /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo -e "\n"
read -p "Do you want to import an existing zsh configuration? (Y/n) " importzshell

if [[ -z "$importzshell" ]] || [[ "${importzshell:0:1}" == "y" ]] || [[ "${importzshell:0:1}" == "Y" ]]; then
  read -p "Enter the URL containing the zsh configuration " zshrc
  curl $zshrc > $HOME/.zshrc

  echo -e "\n"
  read -p "Do you want to need to install some plugins from a remote script? (Y/n) " zshplugins

  if [[ -z "$zshplugins" ]] || [[ "${zshplugins:0:1}" == "y" ]] || [[ "${zshplugins:0:1}" == "Y" ]]; then
    read -p "Enter the URL containing the zsh plugins script " zshpluginsurl
    /bin/bash -c "$(curl -fsSL $zshpluginsurl)"
  fi
fi

echo "done"
exit 0