```
sequenceDiagram
    Windows->>+Reception: ping (content-length: 129)
    Windows->>+DNS: DIG xxxxx.com
    DNS->>+Windows: TXT = v=spf1 a (attent)
    Windows->>+DNS: DIG xxxxx.com
    DNS->>+Windows: TXT = v=spf1 b (envoie)
    Windows->>+Reception: ping (content-length: 130-131-132-133)
    Windows->>+Windows: Encodage text
    Windows->>+Windows: Encodage morse
    Windows->>+Reception: ping (content-length: 134 fin de sequence)
    Reception->>+Reception: decodage morse
    Reception->>+Reception: decodage text
```