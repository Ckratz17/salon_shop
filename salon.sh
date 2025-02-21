#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e '\n~~~~~ Welcome to My Salon, how can I help you? ~~~~~\n'

SERVICE_MENU() {
    SERVICES=$($PSQL "SELECT * FROM services")
    echo "$SERVICES" | while read SERVICE_ID BAR NAME
        do
            echo "$SERVICE_ID) $NAME"
        done
    read SERVICE_ID_SELECTED
}

APPOINTMENT_INFO() {
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    if [[ -z $CUSTOMER_ID ]]
      then
      echo -e "\nI don't have a record for that phone number, what is your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    EXISTING_CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $EXISTING_CUSTOMER_NAME | sed -r 's/^ *| *$//g').\n"
     
}

SERVICE_MENU

case $SERVICE_ID_SELECTED in
  1) APPOINTMENT_INFO ;;
  2) APPOINTMENT_INFO ;;
  3) APPOINTMENT_INFO ;;
  4) APPOINTMENT_INFO ;;
  5) APPOINTMENT_INFO ;;
  *) SERVICE_MENU ;;
esac