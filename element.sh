#!/bin/bash

#fix
#feat
#refactor
#chore

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
fi

if [[ $1 =~ [0-9]+ ]]
then
  REQ_ATONUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
else
  REQ_ATONUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")
fi

if [[ $REQ_ATONUM ]]
then
  REQ_ATODAT=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$REQ_ATONUM")
  echo "$REQ_ATODAT" | while read TYPEID BAR ATONUM BAR SYM BAR NAME BAR MAS BAR MEL BAR BOL BAR TYPE
  do
    echo "The element with atomic number $ATONUM is $NAME ($SYM). It's a $TYPE, with a mass of $MAS amu. $NAME has a melting point of $MEL celsius and a boiling point of $BOL celsius."
  done
else
  echo "I could not find that element in the database."
fi

