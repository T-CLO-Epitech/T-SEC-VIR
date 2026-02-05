<div align="center">

# 🔐 T-SEC-911 Virology

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![DNS](https://img.shields.io/badge/DNS-Protocole-orange?style=for-the-badge&logo=cloudflare&logoColor=white)]()
[![Morse](https://img.shields.io/badge/Morse-Encoding-green?style=for-the-badge&logo=signal&logoColor=white)]()

**Recherche et développement de techniques d'exfiltration de données et d'obfuscation**

---
</div>

## 📋 Description
* Le schéma fonctionnel du projet nous permet d'illustrer les différentes étapes du processus de fonctionnement de la charge utile.
 ---

### Étape 1 : Collecte du premier Ordre
* Le processus commence par la collecte du premier ordre à partir d'un enregistrement TXT présent dans la configuration du serveur DNS et ainsi récupérer les premières instructions.
![Schema Fonctionnel 1](../images/Shema_Fonctionnel_1.png)
Schéma réalisé sur Excalidraw : https://excalidraw.com/
---

### Étape 2 : Collecte du deuxième Ordre

* Une fois le premier ordre exécuté, la charge utile récupère le second, puis envoie une requête ping au serveur maître afin de l'informer qu'elle est opérationnelle et prête à traiter les tâches suivantes.
![Schema Fonctionnel 2](../images/Shema_Fonctionnel_2.png)
Schéma réalisé sur Excalidraw : https://excalidraw.com/
---
### Étape 3 : Collecte du troisième Ordre

* Dès la récupération du troisième ordre, la charge utile lit le contenu d'un fichier sensible et l'encode en code Morse.![Schema Fonctionnel 3](../images/Shema_Fonctionnel_3.png)
  Schéma réalisé sur Excalidraw : https://excalidraw.com/
---

### Étape 4 : Collecte du quatrième Ordre

* Enfin, la charge utile récupère le dernier ordre et exfiltre les données encodées en code Morse au moyen de requêtes ping envoyées vers le serveur maître.
  Il ne reste alors plus qu'à décoder les données reçues afin de reconstituer le contenu du fichier sensible.

![Schema Fonctionnel 4](../images/Shema_Fonctionnel_4.png)
Schéma réalisé sur Excalidraw : https://excalidraw.com/

---

<div align="center">

**T-SEC-911 Virology**

</div>