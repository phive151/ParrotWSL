#!/usr/bin/env  bash
#
# An quick setup to get you going  with apt functions that give you all the parrot upgrades
# to get the "Security" version with tools and what not
# set -ex
_cr() {
  if [[ "$UID" != 0 ]]; then
    echo "You must execute this script as root"
    exit 1
  fi
}
_asl() {
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat "${cwd_}"/docs/sources.list | tee /etc/apt/sources.list
}
_adoptDot() {
cp "${cwd_}"/docs/z{shrc,path,alias} "${HOME}"/.z{shrc,path,alias}
}
_auu() {
apt-get update
apt-get upgrade -y 
apt-get autoremove -y
apt-get autoclean
}
_secInstall() {
  apt-get -y install parrot-tools-full parrot-meta-devel parrot-zsh-profiles parrot-interface-full \
  parrot-core parrot-menu parrot-desktop-xfce parrot-displaymanager parrot-drivers parrot-updater
}
_coreInstall() {
  apt-get install -y parrot-core parrot-interface parrot-meta-devel parrot-displaymanager \ 
  parrot-drivers parrot-updater
}
_zshInstall() {
  while true; do
  apt-get install -y zsh zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting zsh-dev time zsh-antigen;
  break;
  done
  chsh -s /usr/bin/zsh
  _adoptDot
  source ${HOME}/.zshrc
}

_byeFelicia() {
  echo "After all we've been through?!?" 
  sleep 3 
  echo "fine!" 
}

# Check to see if the User is root
_cr
# clone repo
git clone "https://github.com/phive151/ParrotWSL"
cd ParrotWSL
cwd_="${PWD}"
echo ""
echo ""

# move sources.list to /etc/apt
echo "Updating sources..."
echo '================================================================'
echo "Please read /etc/apt/sources.list for list of alternate mirrors"
echo '================================================================'
echo ""

# update upgrade remove and clean files
while true; do
_asl;
break
done

while true; do
_auu;
break
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
      _byeFelicia
      exit 1
  ;;
esac

exit 0
