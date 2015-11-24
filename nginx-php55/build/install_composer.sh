#!/usr/bin/env bash

echo "Installing composer ..."
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
