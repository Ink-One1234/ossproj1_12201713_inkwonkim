#! /bin/bash
	
	if [$# -ne 3]
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
		echo "4"
		;;
	5)
		read -p "Do you want to modify the format of date? (y/n): " check
		if [ "$check" = "y" ]
		then
			cat matches.csv | head -n 11 | awk -F, 'NR!=1{print $1}' | awk '{print $3"/"$1"/"$2,$5}' | sed -E 's/Aug/08/g'
		fi
		;;
	6)
		echo "6"
		;;
	7)
		echo "Bye!"
		stop="Y"
		;;
		
	esac
done		
