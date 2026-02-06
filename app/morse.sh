#!/bin/bash

file=""

# Parse options
while getopts "f:" opt; do
  case $opt in
    f)
      file="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 -f filename"
      exit 1
      ;;
  esac
done

# Check if the file variable is empty
if [ -z "$file" ]; then
  echo "Error: No file provided. Use -f <filename>"
  exit 1
fi

echo "You provided the file: $file"
declare -A SIZE_MAP=(
    [130]="."
    [131]="-"
    [132]=" "     # séparateur de lettres
    [133]="/"     # séparateur de mots
    [134]="0"     # fin de séquence
)

declare -A MORSE_CODE=(
    # Lettres A-Z
    [".-"]="A"
    ["-..."]="B"
    ["-.-."]="C"
    ["-.."]="D"
    ["."]="E"
    ["..-."]="F"
    ["--."]="G"
    ["...."]="H"
    [".."]="I"
    [".---"]="J"
    ["-.-"]="K"
    [".-.."]="L"
    ["--"]="M"
    ["-."]="N"
    ["---"]="O"
    [".--."]="P"
    ["--.-"]="Q"
    [".-."]="R"
    ["..."]="S"
    ["-"]="T"
    ["..-"]="U"
    ["...-"]="V"
    [".--"]="W"
    ["-..-"]="X"
    ["-.--"]="Y"
    ["--.."]="Z"

    # Chiffres 0-9
    ["-----"]="0"
    [".----"]="1"
    ["..---"]="2"
    ["...--"]="3"
    ["....-"]="4"
    ["....."]="5"
    ["-...."]="6"
    ["--..."]="7"
    ["---.."]="8"
    ["----."]="9"

    # Ponctuation
    [".-.-.-"]="."      # Point
    ["--..--"]=","      # Virgule
    ["..--.."]="\?"     # Point d'interrogation
    [".----."]="\'"     # Apostrophe
    ["-.-.--"]="!"      # Point d'exclamation
    ["-..-."]="/"       # Slash
    ["-.--."]="("       # Parenthèse ouvrante
    ["-.--.-"]=")"      # Parenthèse fermante
    [".-..."]="&"       # Et commercial
    ["---..."]=":"      # Deux-points
    ["-.-.-."]=";"      # Point-virgule
    ["-...-"]="="       # Égal
    [".-.-."]="+"       # Plus
    ["-....-"]="-"      # Moins/trait d'union
    ["..--.-"]="_"      # Underscore
    [".-..-."]='\"'     # Guillemet
    ["...-..-"]="$"     # Dollar
    [".--.-."]="@"      # Arobase

    ["/"]=" "
)


INPUT_FILE= $file
OUTPUT_MORSE="decoded_morse_$(date +%Y%m%d_%H%M%S).txt"
OUTPUT_TEXT="decoded_text_$(date +%Y%m%d_%H%M%S).txt"


if [ ! -f "$INPUT_FILE" ]; then
    echo "❌ Erreur: Fichier '$INPUT_FILE' introuvable"
    echo ""
    echo "Usage: $0 [fichier_input]"
    echo "Exemple: $0 icmp_length.txt"
    exit 1
fi

echo "📂 Fichier d'entrée: $INPUT_FILE"
echo "📄 Sortie Morse: $OUTPUT_MORSE"
echo "📄 Sortie Texte: $OUTPUT_TEXT"
echo ""


morse_sequence=""
unknown_lengths=0
line_num=0

while IFS= read -r length; do
    ((line_num++))

    [ -z "$length" ] && continue

    if [ "$length" = "134" ]; then
        echo "Ligne $line_num: $length → 0 (FIN DE SÉQUENCE)"
        morse_sequence+="0"
        break
    fi

    if [ -n "${SIZE_MAP[$length]}" ]; then
        symbol="${SIZE_MAP[$length]}"
        morse_sequence+="$symbol"

    else
        ((unknown_lengths++))
        echo "Ligne $line_num: $length → ? (INCONNU)"
        morse_sequence+="?"
    fi
done < "$INPUT_FILE"

echo "$morse_sequence" > "$OUTPUT_MORSE"


decoded_text=""
unknown_morse=0

morse_sequence="${morse_sequence//0/}"

IFS='/' read -ra WORDS <<< "$morse_sequence"

word_count=0
for word in "${WORDS[@]}"; do
    ((word_count++))

    IFS=' ' read -ra LETTERS <<< "$word"

    echo "Mot $word_count:"
    for letter_code in "${LETTERS[@]}"; do
        [ -z "$letter_code" ] && continue

        if [ -n "${MORSE_CODE[$letter_code]}" ]; then
            char="${MORSE_CODE[$letter_code]}"
            decoded_text+="$char"
            echo "  $letter_code → $char"
        else
            decoded_text+="?"
            ((unknown_morse++))
            echo "  $letter_code → ? (INCONNU)"
        fi
    done

    decoded_text+=" "
done

decoded_text="${decoded_text% }"

echo "$decoded_text" > "$OUTPUT_TEXT"
