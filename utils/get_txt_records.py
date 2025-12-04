import dns.resolver

def get_txt_records(domain):
    """
    Affiche directement les enregistrements TXT du domaine.
    Ne retourne rien.
    """
    try:
        answers = dns.resolver.resolve(domain, 'TXT')
        for rdata in answers:
            # Décoder chaque enregistrement et l'afficher
            return(" ".join(s.decode() for s in rdata.strings))
    except Exception as e:
        return(f"Erreur : {e}")
