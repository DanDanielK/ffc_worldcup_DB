#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#read lines -loop
cat games.csv | while IFS=',' read year round winner opponent winner_goals opponent_goals
do

#skip first line
if [[ $year != 'year' ]]
then

  winner_name=$($PSQL "select name from teams where name='$winner'")

  if [[ -z $winner_name ]]
  then

    #insert new team
    echo $($PSQL "insert into teams(name) values('$winner')")

  fi

  opponent_name=$($PSQL "select name from teams where name='$opponent'")

  if [[ -z $opponent_name ]]
  then

    #insert new team
    echo $($PSQL "insert into teams(name) values('$opponent')")

  fi


fi

done



#read lines -loop
cat games.csv | while IFS=',' read year round winner opponent winner_goals opponent_goals
do

#skip first line
if [[ $year != 'year' ]]
then

  winner_id=$($PSQL "select team_id from teams where name='$winner'")
  opponent_id=$($PSQL "select team_id from teams where name='$opponent'")

  #insert new gmae
    echo $($PSQL "insert into games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) values($year,'$round',$winner_id,$opponent_id,$winner_goals,$opponent_goals)")





fi

done
