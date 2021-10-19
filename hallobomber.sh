#!/bin/bash

## HalloBomber - Scaring Tool Formed Of Whatsapp API And SMS Bombing
## Version - 1.0
## Author - ProHarshit
## Github - https://github.com/ProHarshit
## Dev.To - https://dev.to/ProHarshit

## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
RESETBG="$(printf '\e[0m\n')"

## Script termination
exit_on_signal_SIGINT() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}^${RED}]${RED} HalloBomber Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}^${RED}]${RED} HalloBomber Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
    return
}

##Banner
banner() {
    cat <<- EOF
${ORANGE} __    __                   __   __
${ORANGE}|  |  |  |       ${GREEN} __      ${ORANGE} |  | |  |
${ORANGE}|  |  |  |       ${GREEN}/ /     ${ORANGE}  |  | |  |
${ORANGE}|  |__|  |   ____${GREEN}| |${ORANGE}____   |  | |  |    _____
${ORANGE}|        |  / _  \ \  _ \  |  | |  |   / ___ \\
${ORANGE}|   __   | ${GREEN}/ /_\  _  /_\ \\ ${ORANGE}|  | |  |  / /   \ \\
${ORANGE}|  |  |  | |_   ${GREEN} |_|   ${ORANGE} _| |  | |  | | /     \ |
${ORANGE}|  |  |  | ${GREEN}\/\\\/\/\/\/\/\/${ORANGE} |  | |  |  \ \___/ /
${ORANGE}|__|  |__|  \___________/  |__| |__|   \_____/
${ORANGE} ____                  _
${ORANGE}| __ )  ___  _ __ ___ | |__   ___ _ __
${ORANGE}|  _ \ / _ \| '_ ' _ \| '_ \ / _ \ '__|
${ORANGE}| |_) | (_) | | | | | | |_) |  __/ |
${ORANGE}|____/ \___/|_| |_| |_|_.__/ \___|_|

${CYAN}Author : ProHarshit

${RED}Version : 1.0
EOF
}

## Dependencies
dependencies() {
	echo -e "\n${GREEN}[${WHITE}^${GREEN}]${CYAN} Installing required packages..."
    
    pkg install python >> /dev/null 2>&1
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Installation Successful"

	sleep 3

}

##Python Modules
pymodules() {
    { clear; banner; echo; }
    echo -e "${GREEN}[${WHITE}^${GREEN}]${CYAN} Installing Python modules..."
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${CYAN} This may take up to 5 minutes!"
    
    pip install --upgrade pip >> /dev/null 2>&1
    
    pip3 install -r requirements.txt >> /dev/null 2>&1
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Installation Successful"
    
    sleep 3
}
##Main Menu
main_menu() {
    { clear; banner; echo; }
    read -p "${RED}[${WHITE}^${RED}]${GREEN} Are you ready to scare ? ${BLUE}(Y/N) ${CYAN}"
    
    case $REPLY in
            Y | y)
                    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN}Ok\n";;
            N | n)
                    echo -e "\n${RED}[${WHITE}^${RED}]${RED}Then Please Be";
                    exit;;
    esac
    
    read -p "${RED}[${WHITE}^${RED}]${GREEN} Have you setup profile pic ?${BLUE}(Y/N) ${CYAN}"
    
    case $REPLY in
            Y | y)
                    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Ok\n";;
            N | n)
                    echo -e "\n${RED}[${WHITE}^${RED}]${RED} Then Please Setup";
                    exit;;
    esac                
                    
    read -p "${RED}[${WHITE}^${RED}]${GREEN} Have you hid your number ?${BLUE}(Y/N) ${CYAN}"
    
    case $REPLY in
            Y | y)
                    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Ok\n";;
            N | n)
                    echo -e "\n${RED}[${WHITE}^${RED}]${RED} Then Please Hide";
                    exit;;
                    
    esac
    
    read -p "${RED}[${WHITE}^${RED}]${GREEN} Please Enter Victim's Number with Country Code without +:  ${CYAN}" number
    
    echo -e "\n${RED}[${WHITE}^${RED}] Note : ${BLUE} Please Press Send Key And Come back Here As Soon As Possible"
    
    for i in {1..5}
    
    do
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Message 1"
    
    sleep 5
    
    xdg-open https://api.whatsapp.com/send\?phone\=$number\&text\=___________%0A%2F%2F%20%20%20%20%20%20%20%20%20%20%20%20%20%20%5C%5C%0A%2F%20%20%20%20_%20%20%20%20%20%20_%20%20%20%20%5C%0A%7C%20%20%20%2F_%5C%20%20%2F_%5C%20%20%20%7C%0A%7C%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7C%0A%5C%20________%20%2F%0A%20%5C%5C%2F%5C%2F%5C%2F%5C%2F%2F%0A%20%20%7C%20%20%20%20%20%20%20%20%20%20%20%20%20%7C%0A%20%20%20%5C_____%2F
    
    sleep 2
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Sent $i times"
    
    done
    
    for i in {1..5}
    
    do
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Message 2"
    
    sleep 5
    
    xdg-open https://api.whatsapp.com/send\?phone\=$number\&text\=Hi%0AI%20am%20Ghost%20X
    
    sleep 2
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Sent $i times"
    
    done
    
    for i in {1..5}
    
    do
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Message 3"
    
    sleep 5
    
    xdg-open https://api.whatsapp.com/send\?phone\=$number\&text\=May%20I%20text%20you%20?
    
    sleep 2
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Sent $i times"
    
    done
    
    for i in {1..5}
    
    do
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Message 4"
    
    sleep 5
    
    xdg-open https://api.whatsapp.com/send\?phone\=$number\&text\=Please%20reply%20me%20back
    
    sleep 2
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Sent $i times"
    
    done
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${CYAN} Starting SMS Bombing..."
    
    clear
    banner
    
    cd .addons && python smsbomber.py
    
    { clear; banner; echo; }
    
    for i in {1..5}
    
    do
    
    echo -e "${GREEN}[${WHITE}^${GREEN}]${GREEN} Message 5"
    
    sleep 5
    
    xdg-open https://api.whatsapp.com/send\?phone\=$number\&text\=Why%20didnt%20you%20reply%20me%20?
    
    sleep 2
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Sent $i times"
    done
    
    for i in {1..5}
    
    do
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Message 6"
    
    sleep 5
    
    xdg-open https://api.whatsapp.com/send\?phone\=$number\&text\=Bye%20Bye
    
    sleep 2
    
    echo -e "\n${GREEN}[${WHITE}^${GREEN}]${GREEN} Sent $i times"
    
    done
    
    echo -e "\n${GREEN}Thanks for Using This Tool \nPlease Follow Me On Github And Dev.to\n${RESETBG}"
    
}

dependencies
pymodules
main_menu