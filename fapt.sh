#!/usr/bin/env  bash
## An quick setup to get you going  with apt functions that give you all the parrot upgrades
## to get the "Security" version with tools and what not
# set -ex

## CTRL-C
trap INT
whoami
## Root Of the Repo Directory
ScriptRoot=$(echo $PWD)

## Source Color Variables
source "${ScriptRoot}"/docs/colors.conf

## =====================================================================================
## ==                  LOCAL            SCRIPT            FUNCTIONS                   ==
## =====================================================================================

## Check to see if User is Root Exit script if he is not
check_root() {
  if [ "$(whoami)" != "root" ]; then
    echo -e "$ExitStatement"
    exit 1
  fi
}

apt_sources_list() {
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat "${ScriptHome}"/docs/sources.list | tee /etc/apt/sources.list
}
adopt_dot_files() {
echo "${ScriptRoot}/docs/z{shrc,env,alias" "${HOME}/.z{shrc,env,alias}"
}
apt_upgrade_clean() {
apt-get update
apt-get upgrade -y 
apt-get autoremove -y
apt-get autoclean
}
secInstall() {
  apt-get -y install 
}
coreInstall() {
  apt-get install -y parrot-core parrot-interface parrot-meta-devel parrot-displaymanager \ 
  parrot-drivers parrot-updater
}
zshInstall() {
  while true; do
  apt-get install -y zsh zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting zsh-dev time zsh-antigen;
  break;
  done
  chsh -s /usr/bin/zsh
  _adoptDot
  source ${HOME}/.zshrc
}

byeFelicia() {
  echo "After all we've been through?!?" 
  sleep 3 
  echo "fine!" 
}

# Check to see if the User is root
check_root
# clone repo
cd
git clone "https://github.com/phive151/ParrotWSL"
cd ParrotWSL
clear

# move sources.list to /etc/apt
echo "Updating sources..."
echo '================================================================'
echo "Please read /etc/apt/sources.list for list of alternate mirrors"
echo '================================================================'
echo ""

# update upgrade remove and clean files
while true; do
apt_sources_list;
done

while true; do
apt_upgrade_clean;
done

echo -e "please select from the options below." 
echo -e "Script defaults to full install of"
echo -e "Parrot security Meta Package."
echo ""
echo -e "\n\t 1.\) Install ParrotOS Full Security tools, and change my shell to ZSH"
echo -e "\n\t 2.\) Install security tools but leave my shell as Bash"
echo -e "\n\t 3.\) Install Parrot core tools \"Home Edition\" and change my shell to ZSH"
echo -e "\n\t 4.\) Install core tools only. leave shell as Bash"
echo -e "\n\t 5.\) You have done enough go away and never come back!"
echo ""
echo ""
echo -e "\n\tPlease select 1 - 5"
read -p " : " napt

while true; do
  case "$napt" in
    1)  
        _secInstall && _zshInstall
    ;;
   2)   
        _secInstall
    ;;
    3)  
        _coreInstall && _zshInstall
    ;;
    4)  
       _coreInstall
    ;;
    5)  
        _byeFelicia && exit 1
    ;;
  esac
  done
exit 0