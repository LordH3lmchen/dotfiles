#$PDF_VIEWER="evince"

function look-for-invoice() {
	# Searches for the latest invoice (specify a pattern ) and opens it with evince
  pattern=$1
  evince $(pdfgrep -i -R $pattern $HOME/Documents/PDF_Rechnungssablage/201[7-8]*.pdf | cut -d ':' -f 1 | tail -n 1)
}

function setup-arch() {
  install-archlinux-packages
  install-oh-my-zsh
  join-groups
  enable-services
}

function setup-arch-i3() {
  sudo pacman -S i3 
}

function setup-debian() {
  install-debian-packages
  install-oh-my-zsh
}


function install-archlinux-packages() {
  sudo pacman -S --needed $(cat $HOME/dotfiles/required-archlinux-packages.txt)
}

function enable-services() {
  sudo systemctl enable pcscd.service
}

function join-groups() {
  sudo usermod $USER -a -G kismet,wireshark
}

function install-oh-my-zsh() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ -d "$ZSH" ]; then
    printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
    printf "You'll need to remove $ZSH if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Oh My Zsh...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" || {
    printf "Error: git clone of oh-my-zsh repo failed\n"
    exit 1
  }
}

function setup-tmux() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}


function nmcli-road() {
  # Setup network for remote work
  # Celular network
  for i in {1..5}; do
  	nmcli con up 'Drei (3) Default'
	if [ $? -eq 0 ]; then
		break
	fi
	sleep 5
  done

 # Hotspot for printer and phone
 for i in {1..5}; do 
  	nmcli con up Hotspot
  	if [ $? -eq 0 ]; then
		break
	fi
	sleep 5
  done

 # Wireguard Connnection to the Office
 # nmcli con up wg0
 for i in {1..5}; do
  	sudo wg-quick up wg0 # More reliable than nmcli
	if [ $? -eq 0 ]; then
		break
	fi
	sleep 5
  done
}

function nmcli-home() {
  # Setup network for home-office
  #nmcli con down wg0
  sudo wg-quick down wg0 # More reliable than nmcli
  echo $?
  nmcli con down 'Drei (3) Default'
  echo $?
  nmcli con up trabauer50
  echo $?
}


function start-work-apps() {
	echo "starting work Apps"
	chromium &
	thunderbird &
}


function remote-work() {
	# Wait a little 3G Modem needs some time to work after boot
	sleep 5
	nmcli-road
	sleep 5
	#sudo wg-quick up wg0
	start-work-apps
}

function home-work() {
	nmcli-home
	start-work-apps
}

function mutt-office() {
  mutt -F "~/.mutt/muttrc-office"
}

function lblk() {
  lsblk -o NAME,SIZE,TYPE,FSTYPE,PTTYPE,PARTLABEL,LABEL,MODEL,MOUNTPOINT
}

function vpn-home() {
  if [ "$1" = "up" ]; then
    echo "vpn up"
    sudo wg-qick up wg0
    #nmcli con up wg0
  elif [ "$1" = "down" ]; then;
    echo "vpn down"
    sudo wg-quick down wg0
    # nmcli con down wg0
  else
    echo "usage: vpn-home up|down"
  fi
}

function shutdown-carpi() {
  ssh pi@192.168.199.254 shutdown now
}

function chia-start-all-if-needed() {
  if which chia > /dev/null; then
    if [ ! -f $HOME/.chia/mainnet/run/chia_full_node.pid ]; then
      echo "Chia not running starting chia!"
      chia start all
    fi
  fi
}

