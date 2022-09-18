#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINGOALS OPPGOALS
do
if [[ $WINNER != winner && $OPPONENT != opponent ]]
then
echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
echo "$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
fi
WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
if [[ $YEAR != year && $ROUND != round && $WINNER != winner && $OPPONENT != opponent && $WINGOALS != winner_goals && $OPPGOALS != opponent_goals ]]
then
echo "$($PSQL"INSERT INTO games(year,round,winner_id, opponent_id, winner_goals, opponent_goals) VALUES
($YEAR, '$ROUND', $WIN_ID, $OPP_ID, $WINGOALS, $OPPGOALS)")"
fi
done