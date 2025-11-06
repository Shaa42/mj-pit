#!/usr/bin/env bash
set -euo pipefail

# Encode une chaîne en hexadécimal
toHex() {
  local in="${1-}"
  printf '%s' "$in" | od -A n -t x1 | tr -d ' \n'
}

# Encode une chaîne en Base64
toB64() {
  local in="${1-}"
  printf '%s' "$in" | base64
}

toRot13() {
    local in="${1-}"
    printf '%s' "$in" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

toMorse() {
  local in="${1-}"
  # Met en majuscules, garde uniquement A-Z 0-9 et espaces, compresse les espaces
  local upper
  upper=$(printf '%s' "$in" | tr 'a-z' 'A-Z' | sed 's/[^A-Z0-9 ]//g; s/  */ /g; s/^ //; s/ $//')

  local result=""
  local word
  for word in $upper; do
    local word_out=""
    local letter code
    for ((i=0; i<${#word}; i++)); do
      letter="${word:i:1}"
      case "$letter" in
        A) code=".-";;
        B) code="-...";;
        C) code="-.-.";;
        D) code="-..";;
        E) code=".";;
        F) code="..-.";;
        G) code="--.";;
        H) code="....";;
        I) code="..";;
        J) code=".---";;
        K) code="-.-";;
        L) code=".-..";;
        M) code="--";;
        N) code="-.";;
        O) code="---";;
        P) code=".--.";;
        Q) code="--.-";;
        R) code=".-.";;
        S) code="...";;
        T) code="-";;
        U) code="..-";;
        V) code="...-";;
        W) code=".--";;
        X) code="-..-";;
        Y) code="-.--";;
        Z) code="--..";;
        0) code="-----";;
        1) code=".----";;
        2) code="..---";;
        3) code="...--";;
        4) code="....-";;
        5) code=".....";;
        6) code="-....";;
        7) code="--...";;
        8) code="---..";;
        9) code="----.";;
        *) code="";;
      esac
      if [[ -n "$code" ]]; then
        if [[ -n "$word_out" ]]; then
          word_out+="/"
        fi
        word_out+="$code"
      fi
    done
    if [[ -n "$word_out" ]]; then
      if [[ -n "$result" ]]; then
        result+="/"
      fi
      result+="$word_out"
    fi
  done

  printf '%s\n' "$result"
}

# Démonstration
str1=$( cat ../assets/l2/t2 )
str2=$(toB64 "$str1")
str3=$(toHex "$str2")
str4=$(toRot13 "$str3")
str5=$(toMorse "$str4")
printf "%s\n" "$str5" > code.txt
echo "Le code à déchiffrer a été écrit dans le fichier code.txt"
echo ""

# Affichage de l'instruction
cat instructions.txt
