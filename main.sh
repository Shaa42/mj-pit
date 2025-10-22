# !/usr/bin/bash

input="$1"

function afficher_aide() {
	echo "--help ou -h	Affiche cette aide"
	echo "--hello		Affiche Hello World"
}

function calcul() {
	local num="$1"
	echo $(("$num" * "$num"))
}

if [[ "$input" == "--help" || "$input" == "-h" ]]; then
	afficher_aide

elif [[ "$input" == "--hello" ]] then
	echo "Hello world"

elif [[ "$input" =~ ^[0-9]+$ ]] then
	calcul "$input"

else
	echo "Input non valide"
fi
