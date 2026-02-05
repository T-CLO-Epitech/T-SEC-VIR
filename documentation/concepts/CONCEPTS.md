<div align="center">

# 🔐 T-SEC-911 Virology

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![DNS](https://img.shields.io/badge/DNS-Protocole-orange?style=for-the-badge&logo=cloudflare&logoColor=white)]()
[![Morse](https://img.shields.io/badge/Morse-Encoding-green?style=for-the-badge&logo=signal&logoColor=white)]()

**Recherche et développement de techniques d'exfiltration de données et d'obfuscation**

---
</div>

## 📖 Glossaire

| Terme | Définition |
|-------|------------|
| **Charge utile** | Programme malveillant exécuté sur une machine compromise pour réaliser des actions spécifiques (collecte de données, communication avec un serveur, etc.). |
| **Command and Control ** | Serveur utilisé par un attaquant pour envoyer des ordres à une charge utile et recevoir des informations en retour. |
| **DNS (Domain Name System)** | Protocole qui traduit les noms de domaine en adresses IP. Ici, il est détourné pour transmettre des ordres via les enregistrements TXT. |
| **Enregistrement TXT** | Type d'enregistrement DNS permettant de stocker du texte arbitraire, utilisé ici pour cacher des instructions. |
| **Exfiltration de données** | Technique permettant d'extraire des données sensibles d'un système compromis vers un serveur contrôlé par l'attaquant. |
| **DIG** | Commande Linux permettant d'interroger les serveurs DNS et de récupérer des enregistrements (A, TXT, MX, etc.). |
| **ICMP / Ping** | Protocole réseau utilisé pour tester la connectivité. Ici, il est détourné pour transmettre des données encodées. |
| **Machine compromise** | Ordinateur infecté par une charge utile et contrôlé à distance par un attaquant. |
| **Code Morse** | Système d'encodage représentant les caractères par des combinaisons de points et de traits, utilisé ici pour dissimuler les données. |
| **Obfuscation** | Technique visant à rendre un code ou des données difficiles à analyser pour échapper à la détection. |
| **Serveur maître** | Serveur de réception contrôlé par l'attaquant qui collecte les données exfiltrées. |

---

## 📊 Dictionnaires des protocoles de communication

### 🔤 Dictionnaire Morse

| Caractère | Code Morse | Caractère | Code Morse |
|:---------:|:----------:|:---------:|:----------:|
| A | .- | N | -. |
| B | -... | O | --- |
| C | -.-. | P | .--. |
| D | -.. | Q | --.- |
| E | . | R | .-. |
| F | ..-. | S | ... |
| G | --. | T | - |
| H | .... | U | ..- |
| I | .. | V | ...- |
| J | .--- | W | .-- |
| K | -.- | X | -..- |
| L | .-.. | Y | -.-- |
| M | -- | Z | --.. |

| Chiffre | Code Morse | Chiffre | Code Morse |
|:-------:|:----------:|:-------:|:----------:|
| 0 | ----- | 5 | ..... |
| 1 | .---- | 6 | -.... |
| 2 | ..--- | 7 | --... |
| 3 | ...-- | 8 | ---.. |
| 4 | ....- | 9 | ----. |

---

### 📋 Dictionnaire des ordres

| Code | Ordre | Description |
|:----:|-------|-------------|
| A | Ne fait rien | La charge utile reste en attente |
| B | Signale-toi | Envoie un ping au serveur maître pour signaler que la charge est active |
| C | Récupère la donnée | Lit le fichier sensible et encode son contenu en Morse |
| D | Envoie la donnée | Exfiltre les données encodées via des requêtes ping |

---

### 📏 Dictionnaire des codes ping (longueur)

| Longueur du ping (octets) | Signification |
|:-------------------------:|---------------|
| 129 | Début de transmission (création du fichier) |
| 130 | Point (.) |
| 131 | Trait (-) |
| 132 | Séparateur de caractère |
| 133 | Séparateur de mot (espace) |
| 134 | Fin de transmission |

---


<div align="center">

**T-SEC-911 Virology**

</div>