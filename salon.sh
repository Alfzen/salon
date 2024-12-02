#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
echo -e "\n ~~Gran Salón~~\n"

echo "Bienvenido al Gran Salón, ¿En que te puedo ayudar?"

MAIN_MENU(){

  if [[ $1 ]]
  then
  echo $1
  fi
  echo -e '\n1) Corte\n2) Color \n3) Rapado'
  read SERVICE_ID_SELECTED
  #si elige otro numero
if [[ ! $SERVICE_ID_SELECTED -ge 1 && $SERVICE_ID_SELECTED -le 5 ]]
then
MAIN_MENU "No pude encontrar ese servicio, en que te puedo ayudar?"
else
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
echo -e "\nCuál es tu teléfono?"
read CUSTOMER_PHONE
#CHEQUEAR SI EXISTE EL CLIENTE
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_ID ]]
then 
FIRST_TIME
echo -e "\nA que hora querés tu $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME

INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
else
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
echo -e "\nA que hora querés tu $SERVICE_NAME, $CUSTOMER_NAME?"
read SERVICE_TIME

INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
fi
fi
}


FIRST_TIME(){
echo -e "\nPrimera vez verdad? Cual es tu nombre?"
read CUSTOMER_NAME
INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
}
MAIN_MENU


