#!/usr/bin/env bash
echo "Copy all platin init scripts to its place."
chmod +x /build/platin_init.d/*.sh
cp /build/platin_init.d/*.sh /etc/platin_init.d/

echo "Copying binaries."
chmod +x /build/bin/*
cp /build/bin/* /usr/bin/
