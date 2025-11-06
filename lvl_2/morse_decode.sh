#!/usr/bin/env bash
# Use: ./morse_decode.sh "../.-." ou ./morse_decode.sh $(output.sh)
# "output.sh" peut être par exemple "cat texte.txt" (output stdout)
set -euo pipefail

# Lit l'argument en entrée sinon renvoie une erreur
if (( $# > 0 )); then
  input="$*"
else
  printf "%s\n" "Please input a string."
  exit 1
fi

# Utilise 'awk' pour décoder le code morse à l'aide d'un "dictionnaire"
printf '%s' "$input" | awk '
BEGIN {
  ORS = ""

  # Morse map (A–Z)
  m[".-"]   = "A";  m["-..."] = "B";  m["-.-."] = "C";  m["-.."]  = "D";  m["."]    = "E";
  m["..-."] = "F";  m["--."]  = "G";  m["...."] = "H";  m[".."]   = "I";  m[".---"] = "J";
  m["-.-"]  = "K";  m[".-.."] = "L";  m["--"]   = "M";  m["-."]   = "N";  m["---"]  = "O";
  m[".--."] = "P";  m["--.-"] = "Q";  m[".-."]  = "R";  m["..."]  = "S";  m["-"]    = "T";
  m["..-"]  = "U";  m["...-"] = "V";  m[".--"] = "W";  m["-..-"] = "X";  m["-.--"] = "Y";  m["--.."] = "Z";
  # Digits 0–9
  m["-----"] = "0"; m[".----"] = "1"; m["..---"] = "2"; m["...--"] = "3"; m["....-"] = "4";
  m["....."] = "5"; m["-...."] = "6"; m["--..."] = "7"; m["---.."] = "8"; m["----."] = "9";
}
{
 gsub(/\/+/, " / ");
 # Split all tokens
 n = split($0, a, /[ ]+/);
 for (i = 1; i <= n; i++) {
   token = a[i];
   if (token == "" ) continue;
   if (token in m) { printf "%s", m[token]; }
 }
 print "";
 exit;
}'
