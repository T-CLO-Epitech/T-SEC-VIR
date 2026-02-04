#!/bin/bash

OUTPUT_FILE="icmp_length_$(date +%Y%m%d_%H%M%S).txt"

echo "Démarrage de la capture ICMP..."
echo "Les longueurs IP seront écrites dans: $OUTPUT_FILE"
echo ""

sudo tcpdump -l -i any 'icmp[0] == 8 and len >= 129 and len <= 134' -vv 2>&1 | \
while IFS= read -r line; do
    echo "$line"

    if [[ $line =~ proto\ ICMP.*length\ ([0-9]+) ]]; then
        length="${BASH_REMATCH[1]}"

        case $length in
            129)
                # Créer le fichier
                touch "$OUTPUT_FILE"
                ;;
            130|131|132|133)
                # Écrire la valeur dans le fichier
                echo "$length" >> "$OUTPUT_FILE"
                ;;
            134)
                sudo pkill -f "tcpdump.*icmp"
                exit 0
                ;;
        esac
    fi
done

echo ""
echo "Capture terminée. Données sauvegardées dans: $OUTPUT_FILE"