ssh -N   -L  -4  localhost:9000:localhost:9000   -L localhost:3000:localhost:3000    debian@51.178.52.51 -i .ssh/id_ed25519

ssh -4 -N \
  -L 127.0.0.1:19000:127.0.0.1:9000 \
  -L 127.0.0.1:13000:127.0.0.1:3000 \
  -L 127.0.0.1:19999:127.0.0.1:9999 \ debian@51.178.52.51 -i .ssh/id_ed25519
