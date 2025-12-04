import subprocess
def ping_la_boite(host):
        


    # Commande ping : Linux/Mac
    command = ["ping", host ,"-l", "666"]  # -c 4 : envoie 4 paquets

    try:
        # Exécution de la commande
        result = subprocess.run(command, capture_output=True, text=True, check=True)

        # Affichage du résultat
        print("Ping réussi ! Voici la sortie :")
        print(result.stdout)

    except subprocess.CalledProcessError as e:
        print("Ping échoué !")
        print(e.stdout)
        print(e.stderr)
