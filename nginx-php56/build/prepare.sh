#!/usr/bin/env bash
echo "Copy all platin init scripts to its place."
chmod +x /build/platin_init.d/*.sh
cp /build/platin_init.d/*.sh /etc/platin_init.d/
