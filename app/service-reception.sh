#!/bin/bash

OUTPUT_DIR="./ping_triggers"
mkdir -p "$OUTPUT_DIR"

CURRENT_FILE=""
PENDING_LENGTH=""
#Init des dictionnaires
declare -A SIZE_MAP=(
    [130]="."
    [131]="-"
    [132]=" "
    [133]="/"
    [134]="0"
)

declare -A MORSE_CODE=(
    [".-"]="A"    ["-..."]="B"   ["-.-."]="C"   ["-.."]="D"
    ["."]="E"     ["..-."]="F"   ["--."]="G"    ["...."]="H"
    [".."]="I"    [".---"]="J"   ["-.-"]="K"    [".-.."]="L"
    ["--"]="M"    ["-."]="N"     ["---"]="O"    [".--."]="P"
    ["--.-"]="Q"  [".-."]="R"    ["..."]="S"    ["-"]="T"
    ["..-"]="U"   ["...-"]="V"   [".--"]="W"    ["-..-"]="X"
    ["-.--"]="Y"  ["--.."]="Z"
    ["-----"]="0" [".----"]="1"  ["..---"]="2"  ["...--"]="3"
    ["....-"]="4" ["....."]="5"  ["-...."]="6"  ["--..."]="7"
    ["---.."]="8" ["----."]="9"
    [".-.-.-"]="."    ["--..--"]=","    ["..--.."]="\?"
    [".----."]="\'"   ["-.-.--"]="!"    ["-..-."]="/"
    ["-.--."]="("     ["-.--.-"]=")"    [".-..."]="&"
    ["---..."]=":"    ["-.-.-."]=";"    ["-...-"]="="
    [".-.-."]="+"     ["-....-"]="-"    ["..--.-"]="_"
    [".-..-."]='\"'   ["...-..-"]="$"   [".--.-."]="@"
    ["/"]=" "
)

#Méthode de décodage des code ping en morse puis en texte
decode_file() {
    local input_file="$1"
    local folder_path=$(dirname "$input_file")
    local base_name=$(basename "$input_file" .txt)
    local morse_file="${folder_path}/${base_name}_morse.txt"
    local text_file="${folder_path}/${base_name}_decoded.txt"

    echo ""
    echo "[*] Décodage de: $input_file"

    morse_sequence=""

    while IFS= read -r length; do
        [ -z "$length" ] && continue
        [ "$length" = "134" ] && break
        if [ -n "${SIZE_MAP[$length]}" ]; then
            morse_sequence+="${SIZE_MAP[$length]}"
        fi
    done < "$input_file"

    echo "$morse_sequence" > "$morse_file"
    echo "[+] Séquence Morse: $morse_sequence"
    echo "[+] Morse sauvegardé dans: $morse_file"

    decoded_text=""
    morse_sequence="${morse_sequence//0/}"

    IFS='/' read -ra WORDS <<< "$morse_sequence"

    for word in "${WORDS[@]}"; do
        IFS=' ' read -ra LETTERS <<< "$word"
        for letter_code in "${LETTERS[@]}"; do
            [ -z "$letter_code" ] && continue
            if [ -n "${MORSE_CODE[$letter_code]}" ]; then
                decoded_text+="${MORSE_CODE[$letter_code]}"
            else
                decoded_text+="?"
            fi
        done
        decoded_text+=" "
    done

    decoded_text="${decoded_text% }"

    echo "$decoded_text" > "$text_file"
    echo "[+] Texte décodé: $decoded_text"
    echo "[+] Texte sauvegardé dans: $text_file"
    echo ""
}


#Méthode d'écoute des pings ICMP et de traitement des données
echo "[*] Écoute des pings ICMP (longueur 129-134)..."
echo "[*] Les dossiers seront créés dans: $OUTPUT_DIR"

while IFS= read -r line; do
    echo "$line"

    if [[ $line =~ proto\ ICMP.*length\ ([0-9]+) ]]; then
        PENDING_LENGTH="${BASH_REMATCH[1]}"

    elif [ -n "$PENDING_LENGTH" ]; then
        IP_SRC=$(echo "$line" | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -1)

        if [ -n "$IP_SRC" ]; then
            case $PENDING_LENGTH in
                129)
                    DATETIME=$(date +"%Y-%m-%d_%H-%M-%S")
                    FOLDER_NAME="${IP_SRC}_${DATETIME}"
                    mkdir -p "${OUTPUT_DIR}/${FOLDER_NAME}"
                    CURRENT_FILE="${OUTPUT_DIR}/${FOLDER_NAME}/${FOLDER_NAME}.txt"
                    touch "$CURRENT_FILE"
                    echo "[+] Ping 129 reçu de $IP_SRC - Dossier et fichier créés: ${FOLDER_NAME}"
                    ;;
                130|131|132|133)
                    if [ -n "$CURRENT_FILE" ]; then
                        echo "$PENDING_LENGTH" >> "$CURRENT_FILE"
                        echo "[+] Longueur $PENDING_LENGTH écrite dans: $CURRENT_FILE"
                    fi
                    ;;
                134)
                    if [ -n "$CURRENT_FILE" ]; then
                        echo "[*] Fin de transmission reçue (134)."
                        decode_file "$CURRENT_FILE"
                        CURRENT_FILE=""
                    fi
                    ;;
            esac
        fi

        PENDING_LENGTH=""
    fi
done < <(sudo tcpdump -n -l -i any 'icmp[0] == 8 and len >= 129 and len <= 134' -vv 2>&1)

echo ""
echo "Capture terminée."