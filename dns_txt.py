import dns.resolver

domain = input("Nom de domaine : ")
answers = dns.resolver.resolve(domain, 'TXT')

txt_value = ""

for rdata in answers:
    print(" ".join(s.decode() for s in rdata.strings))
    txt_value = " ".join(s.decode() for s in rdata.strings)
