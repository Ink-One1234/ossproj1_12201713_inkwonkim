#! /bin/bash
	
	if [ $# -ne 3 ]
	then
		echo "usage: ./proj1_12201713_inkwonkim file1 file2 file3"
		exit 1
	fi

	echo "***********OSS1 - Project1***********"
	echo "*       StudentID : 12201713        *"
	echo "*       Name : Inkwon Kim           *"
	echo "*************************************"
stop="N"
until [ "$stop" = "Y" ]
do
	echo ""
	echo "[MENU]"
	echo "1. Get the data of Heung-Min Son's Current Club, Appearance, Goals, Assists in players.csv"
	echo "2. Get the team data to enter a league position in teams.csv"
	echo "3. Get the Top-3 Attendance matches in matches.csv"
	echo "4. Get the team's league position and team's top scorer in teams.csv & players.csv"
	echo "5. Get the modified format of date_GMT in matches.csv"
	echo "6. Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
	echo "7.Exit"
	read -p "Enter your CHOICE (1~7) :" menuNum

	case "$menuNum" in
	1)
		read -p "Do you want to get the Heung-Min Son's data? (y/n) :" check
		if [ "$check" = "y" ]
		then
			cat players.csv | awk -F, '$1=="Heung-Min Son"{print"Team:"$4", Appearance:"$6", Goal:"$7", Assist:"$8}'
		fi
		;;
	2)
		read -p "What do you want to get the team data of league_position[1~20]: " leaguePosition
		cat teams.csv | awk -F, -v a=$leaguePosition '$6==a{print a,$1, $2/($2+$3+$4)}'		
		;;
	3)
		read -p "Do you want to know Top-3 attendance data and average attendance? (y/n): " check
		if [ "$check" = "y" ]
		then
			echo "**Top-3 Attendance Match**"
			echo ""
			cat matches.csv | sort -r -t',' -k 2 -g | head -n 3 | awk -F, '{print $3" vs "$4"\("$1"\)\n"$2,$7"\n"}'
		fi
		;;
	4)
		for num in $(seq 1 20)
		do
			echo ""
			cat teams.csv | awk -F, -v n=$num '$6==n{print n,$1}'
			team=$(cat teams.csv | awk -F, -v n=$num '$6==n{print $1}')
			cat players.csv | awk -F, -v t="$team" '$4==t{print $1","$7}' | sort -r -t',' -k 2 -g | head -n 1
		done
		;;
	5)
		read -p "Do you want to modify the format of date? (y/n): " check
		if [ "$check" = "y" ]
		then
			cat matches.csv | head -n 11 | awk -F, 'NR!=1{print $1}' | awk '{print $3"/"$1"/"$2,$5}' | sed -E 's/Aug/08/g'
		fi
		;;
	6)
		echo "1)Arsenal              11)Liverpool"
		echo "2)Tottenham Hotspur    12)Chelsea"
		echo "3)Manchester City      13)West Ham United"
		echo "4)Leicester City       14)Watford"
		echo "5)Crystal Palace       15)Newcastle United"
		echo "6)Everton              16)Cardiff City"
		echo "7)Burnley              17)Fulham"
		echo "8)Southampton          18)Brighton & Hove Albion"
		echo "9)AFC Bournemouth      19)Huddersfield"
		echo "10)Manchester United   20)Wolvehampton Wanderers"
		read -p "Enter your team number: " team_num
		team=$(cat teams.csv | awk -F, -v n=$team_num 'NR==n+1{print $1}')
		echo $team
		;;
	7)
		echo "Bye!"
		stop="Y"
		;;

	*)
		echo "Wrong Input..Please insert 1~7"
		;;		
	esac
done		
