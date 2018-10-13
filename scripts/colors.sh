#!/bin/bash

# Reset Color
RESET_COLOR='\e[0m';

# Types
TYPE_REGULAR='REGULAR';
TYPE_BOLD='BOLD';
TYPE_UNDERLINE='UNDERLINE';
TYPE_HIGH_INTENSITY='HIGH_INTENSITY';
TYPE_BOLD_HIGH_INTENSITY='BOLD_HIGH_INTENSITY';
TYPE_BACKGROUND='BACKGROUND';
TYPE_HIGH_INTENSITY_BACKGROUND='HIGH_INTENSITY_BACKGROUND';

# Colors
COLOR_BLACK='BLACK';
COLOR_RED='RED';
COLOR_GREEN='GREEN';
COLOR_YELLOW='YELLOW';
COLOR_BLUE='BLUE';
COLOR_PURPLE='PURPLE';
COLOR_CYAN='CYAN';
COLOR_WHITE='WHITE';

# Regular                                                                                                                        
REGULAR_BLACK='\e[0;30m';                              
REGULAR_RED='\e[0;31m';                                    
REGULAR_GREEN='\e[0;32m';                                  
REGULAR_YELLOW='\e[0;33m';                         
REGULAR_BLUE='\e[0;34m';                                     
REGULAR_PURPLE='\e[0;35m';                               
REGULAR_CYAN='\e[0;36m'; 
REGULAR_WHITE='\e[0;37m';                              

# Bold
BOLD_BLACK='\e[1;30m';
BOLD_RED='\e[1;31m'; 
BOLD_GREEN='\e[1;32m';
BOLD_YELLOW='\e[1;33m';
BOLD_BLUE='\e[1;34m';
BOLD_PURPLE='\e[1;35m';
BOLD_CYAN='\e[1;36m';
BOLD_WHITE='\e[1;37m';

# Underline
UNDERLINE_BLACK='\e[4;30m';
UNDERLINE_RED='\e[4;31m';
UNDERLINE_GREEN='\e[4;32m';
UNDERLINE_YELLOW='\e[4;33m';
UNDERLINE_BLUE='\e[4;34m';
UNDERLINE_PURPLE='\e[4;35m';
UNDERLINE_CYAN='\e[4;36m';
UNDERLINE_WHITE='\e[4;37m';

# High Intensity
HIGH_INTENSITY_BLACK='\e[0;90m'; 
HIGH_INTENSITY_RED='\e[0;91m';
HIGH_INTENSITY_GREEN='\e[0;92m';
HIGH_INTENSITY_YELLOW='\e[0;93m';
HIGH_INTENSITY_BLUE='\e[0;94m';
HIGH_INTENSITY_PURPLE='\e[0;95m';
HIGH_INTENSITY_CYAN='\e[0;96m';
HIGH_INTENSITY_WHITE='\e[0;97m';

# Bold High Intensity
BOLD_HIGH_INTENSITY_BLACK='\e[1;90m';
BOLD_HIGH_INTENSITY_RED='\e[1;91m';
BOLD_HIGH_INTENSITY_GREEN='\e[1;92m';
BOLD_HIGH_INTENSITY_YELLOW='\e[1;93m';
BOLD_HIGH_INTENSITY_BLUE='\e[1;94m';
BOLD_HIGH_INTENSITY_PURPLE='\e[1;95m';
BOLD_HIGH_INTENSITY_CYAN='\e[1;96m';
BOLD_HIGH_INTENSITY_WHITE='\e[1;97m';

# Background
BACKGROUND_BLACK='\e[40m';
BACKGROUND_RED='\e[41m';
BACKGROUND_GREEN='\e[42m';
BACKGROUND_YELLOW='\e[43m';
BACKGROUND_BLUE='\e[44m';
BACKGROUND_PURPLE='\e[45m';
BACKGROUND_CYAN='\e[46m';
BACKGROUND_WHITE='\e[47m';

# High Intensity Backgrounds
HIGH_INTENSITY_BACKGROUND_BLACK='\e[0;100m';
HIGH_INTENSITY_BACKGROUND_RED='\e[0;101m';
HIGH_INTENSITY_BACKGROUND_GREEN='\e[0;102m';
HIGH_INTENSITY_BACKGROUND_YELLOW='\e[0;103m';
HIGH_INTENSITY_BACKGROUND_BLUE='\e[0;104m';
HIGH_INTENSITY_BACKGROUND_PURPLE='\e[0;105m';
HIGH_INTENSITY_BACKGROUND_CYAN='\e[0;106m';
HIGH_INTENSITY_BACKGROUND_WHITE='\e[0;107m';

# Base Color Function
function baseColor() {
    FINALE_COLOR="$2_$1";
    eval FINALE_TEXT="$3";
    echo -e "${!FINALE_COLOR}${FINALE_TEXT}${RESET_COLOR}"
}

# Color Functions
function black() {
    TEMP_TEXT=$2;
    baseColor $COLOR_BLACK $1 "\${TEMP_TEXT}"
}

function red() {
    TEMP_TEXT=$2;
    baseColor $COLOR_RED $1 "\${TEMP_TEXT}"
}

function green() {
    TEMP_TEXT=$2;
    baseColor $COLOR_GREEN $1 "\${TEMP_TEXT}"
}

function yellow() {
    TEMP_TEXT=$2;
    baseColor $COLOR_YELLOW $1 "\${TEMP_TEXT}"
}

function blue() {
    TEMP_TEXT=$2;
    baseColor $COLOR_BLUE $1 "\${TEMP_TEXT}"
}

function purple() {
    TEMP_TEXT=$2;
    baseColor $COLOR_PURPLE $1 "\${TEMP_TEXT}"
}

function cyan() {
    TEMP_TEXT=$2;
    baseColor $COLOR_CYAN $1 "\${TEMP_TEXT}"
}

function white() {
    TEMP_TEXT=$2;
    baseColor $COLOR_WHITE $1 "\${TEMP_TEXT}"
}

# Alerts Functions
function success() {
    green $1 "$2"
}

function warning() {
    yellow $1 "$2"
}

function info() {
    cyan $1 "$2"
}

function danger() {
    red $1 "$2"
}
