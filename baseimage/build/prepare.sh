#!/usr/bin/env bash
echo "Creating platin init dir."
mkdir -p /etc/platin_init.d

echo "Copy all platin init scripts to its place."
chmod +x /build/platin_init.d/*.sh
cp /build/platin_init.d/*.sh /etc/platin_init.d/

echo "Copy all my_init.d scripts to its place."
chmod +x /build/my_init.d/*.sh
cp /build/my_init.d/*.sh /etc/my_init.d/

echo "Copying binaries."
chmod +x /build/bin/*
cp /build/bin/* /usr/bin/
