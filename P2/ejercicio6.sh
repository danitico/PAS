#!/bin/bash
cat /etc/passwd | grep -E $1 | sed -r -e 's/(.*):.*:(.*):(.*):(.*):(.*):(.*)/==========\nLogname: \1\n->UID: \2\n->Grupo: \3\n->GID: \4\n->Home: \5\n->Shell por defecto: \6/'
