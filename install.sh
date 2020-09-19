#!/bin/bash

tryDoing()
{
    if ! $@; then
        status=$?
        printf "\033[1;31mFAILED!\033[0m\n"
        exit $status
        fi
}

declare -r thumbnailer_entries_folder="/usr/share/thumbnailers"

# get the script's own path
if [[ "$0" != /* ]]; then
    if [[ "$0" == './'* ]]; then declare -r selfpath="$PWD/${0#.\/}"
    elif [[ -f "$PWD/$0" ]]; then declare -r selfpath="$PWD/$0"
    else declare -r selfpath=$(find /bin /sbin /usr/bin /usr/sbin -type f -name '$0' -print 2>/dev/null); fi
else
    declare -r selfpath="$0"
    fi

# take command line arguments
MODE=1
if [[ "$#" -gt 1 ]]; then
    printf "Usage: '$0' [--reinstall|--uninstall|--full-uninstall]\n"
    exit 1
elif [[ "$#" -gt 0 ]]; then
    if [[ "$1" == "--reinstall" ]]; then MODE=2
    elif [[ "$1" == "--full-uninstall" ]]; then MODE=3
    elif [[ "$1" == "--uninstall" ]]; then MODE=4
    else printf "Usage: '$0' [--reinstall|--uninstall|--full-uninstall]\n"; fi
    fi

# default mode's first step (installing dependencies)
if [[ "$MODE" -lt 2 ]]; then
    printf "\033[1mInstalling dependencies...\033[0m\n"
    tryDoing sudo apt -y install gedit python3-pip
    tryDoing sudo pip3 install pillow pefile

# non-default modes' first step (removing old files)
else
    sudo rm -vf "$thumbnailer_entries_folder"/{epub,ms,webp}.thumbnailer
    sudo rm -vf /usr/bin/{epub,ms,webp}-thumbnailer
    if [[ "$MODE" -gt 2 ]]; then
        # finishing
        printf "\033[1mCleaning Thumbnails Cache...\033[0m\n"
        rm -fr "$HOME/.cache/thumbnails/"*
        printf "\n\033[2m[press any key to restart Nautilus]\033[0m "; read -n 1 -s; printf "\n\n"
        sudo -u "${HOME##*/}" nautilus -q &> /dev/null &
        sudo killall nautilus &> /dev/null
        sudo -u "${HOME##*/}" nautilus &> /dev/null &
        printf "\033[1;32mDONE!\033[0m\n"
        exit
        fi
    fi

# self-explainatory step
printf "\033[1mCopying Binaries...\033[0m\n"
tryDoing sudo cp -vn "${selfpath%/*}/"{epub,ms,webp}-thumbnailer /usr/bin
sudo chmod +x /usr/bin/{epub,ms,webp}-thumbnailer
printf "\033[1mCopying Thumbnailer Entries...\033[0m\n"
tryDoing sudo cp -vn "${selfpath%/*}/"{epub,ms,webp}.thumbnailer "$thumbnailer_entries_folder"

# finishing
printf "\033[1mCleaning Thumbnails Cache...\033[0m\n"
rm -fr "$HOME/.cache/thumbnails/"*
printf "\n\033[2m[press any key to restart Nautilus]\033[0m "; read -n 1 -s; printf "\n\n"
sudo -u "${HOME##*/}" nautilus -q &> /dev/null &
sudo killall nautilus &> /dev/null
sudo -u "${HOME##*/}" nautilus &> /dev/null &
printf "\033[1;32mDONE!\033[0m\n"
