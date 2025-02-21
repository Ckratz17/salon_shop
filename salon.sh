#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=bikes --tuples-only -c"

echo -e '\n~~~~~ Welcom to the Salon Shop ~~~~~\n'

MAIN_MENU() {
    echo How may we help you?
    echo -e '\n1. Schedule an appointment\n2. Cancel an appointment\n3. Reschedule an appointment\n4. Exit'
    read MAIN_MENU_SELECTION
}

SCHEDULE_MENU() {
    echo Schedule Menu
}

CANCEL_MENU() {
    echo Cancel Menu
}

RESCHEDULE_MENU() {
    echo Reschedule Menu
}

EXIT() {
    echo -e '\nThank you for stopping in.\n'
}

MAIN_MENU

case $MAIN_MENU_SELECTION in
    1) SCHEDULE_MENU ;;
    2) CANCEL_MENU ;;
    3) RESCHEDULE_MENU ;;
    4) EXIT ;;
esac