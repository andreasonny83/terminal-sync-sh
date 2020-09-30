#!/bin/bash
set +x

PWD=${PWD}

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

read -p "Enter the URL containing your Terminal Sync configuration " terminalsyncconfig
curl -fsSL $terminalsyncconfig > $PWD/.terminal-sync-tmp.sh
source $PWD/.terminal-sync-tmp.sh
rm $PWD/.terminal-sync-tmp.sh

echo -e "\n"
read -p  "Do you want to install Homebrew? (Y/n) " homebrew

if [[ -z "$homebrew" ]] || [[ "${homebrew:0:1}" == "y" ]] || [[ "${homebrew:0:1}" == "Y" ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo -e "\n"
read -p "Do you want to install iTerm2 (This requires Homebrew to be installed)? (Y/n) " iterm

if [[ -z "$iterm" ]] || [[ "${iterm:0:1}" == "y" ]] || [[ "${iterm:0:1}" == "Y" ]]; then
  echo "Installing iTerm2..."
  brew cask install iterm2
fi

echo -e "\n"
read -p "Do you want to download your custom iTerm2 configuration? (Y/n) " itermconfig

if [[ -z "$itermconfig" ]] || [[ "${itermconfig:0:1}" == "y" ]] || [[ "${itermconfig:0:1}" == "Y" ]]; then
  if [[ -d "$HOME/itermConfig" ]]; then
    echo "itermConfig folder already exists"
  else
    mkdir $HOME/itermConfig
  fi

  curl $itermconfigurl > $HOME/itermConfig/iterm2.plist
  echo "iTerm configuration file saved to $HOME/itermConfig/iterm2.plist"
fi

echo -e "\n"
read -p "Do you want to install Oh-my-zsh? (Y/n) " ohmyzsh

if [[ -z "$ohmyzsh" ]] || [[ "${ohmyzsh:0:1}" == "y" ]] || [[ "${ohmyzsh:0:1}" == "Y" ]]; then
  echo "You will need to restart your terminal and run this script again after Oh-my-zsh is installed."$'\n'"(Press any key to continue) " anykey
  echo "Installing Oh-my-zsh..."
  /bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo -e "\n"
read -p "Do you want to import your existing zsh configuration? (Y/n) " importzshell

if [[ -z "$importzshell" ]] || [[ "${importzshell:0:1}" == "y" ]] || [[ "${importzshell:0:1}" == "Y" ]]; then
  curl $zshrc > $HOME/.zshrc

  echo -e "\n"
  read -p "Do you want to install your custom terminal plugins and themes? (Y/n) " zshplugins

  if [[ -z "$zshplugins" ]] || [[ "${zshplugins:0:1}" == "y" ]] || [[ "${zshplugins:0:1}" == "Y" ]]; then
    /bin/bash -c "$(curl -fsSL $zshpluginsurl)"
  fi
fi

echo -e "\n"
read -p "Do you want to install Terminal Fonts? (Y/n) " fonts

if [[ -z "$fonts" ]] || [[ "${fonts:0:1}" == "y" ]] || [[ "${fonts:0:1}" == "Y" ]]; then
  echo "brew tap homebrew/cask-fonts"
  brew update --force --verbose
  brew tap homebrew/cask-fonts
  echo "Installing font meslo..."
  brew cask install font-meslo-lg
  brew cask install font-meslo-for-powerline
  echo "Installing font hack-nerd..."
  brew cask install font-hack-nerd-font
  echo "Installing font fira-code..."
  brew cask install font-fira-code-nerd-font
  brew cask install font-fira-code
fi

echo "done"
exit 0