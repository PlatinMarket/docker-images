#!/usr/bin/env bash
echo "Cloning docker-toolbox"
rm -rf /docker-toolbox && git clone https://github.com/PlatinMarket/docker-toolbox.git $TOOLBOXFOLDER
chmod +x $TOOLBOXFOLDER/*.sh
