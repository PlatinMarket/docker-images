#!/bin/bash

# Set directories
MYSQL_DATA_DIR=/var/lib/mysql
DATA_DIR=/data
HOME_DIR=/root

# Cleanup previous sockets
if [ -e $BASEFOLDER/$tag/hosts ]; then
  rm -f /run/mysqld/mysqld.sock 2> /dev/null
fi

if [ ! -d /var/log/mysql ]; then
  mkdir -p /var/log/mysql 2> /dev/null
fi

wait_for_first_run() {
  # Wait for mysql to finish starting up first.
  while [[ ! -e /var/run/mysqld/mysqld.sock ]] ; do
      inotifywait -q -e create /var/run/mysqld/ >> /dev/null
  done

  # After first run create users
  after_first_start
}

after_first_start() {
  # The password for 'debian-sys-maint'@'localhost' is auto generated.
  # The database inside of DATA_DIR may not have been generated with this password.
  # So, we need to set this for our database to be portable.
  DB_MAINT_PASS=$(cat /etc/mysql/debian.cnf | grep -m 1 "password\s*=\s*"| sed 's/^password\s*=\s*//')
  mysql -u root -e \
      "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '$DB_MAINT_PASS';"

  # Create the superuser.
  mysql -u root <<-EOF
      DELETE FROM mysql.user WHERE user = '$USER';
      FLUSH PRIVILEGES;
      CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASS';
      GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;
      CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
      GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;
      FLUSH PRIVILEGES;
EOF

  # Remove first run flag
  rm /firstrun
}

# test if DATA_DIR has content
if [[ ! "$(ls -A $DATA_DIR)" ]]; then
  echo "Initializing MySQL at $DATA_DIR"
  cp -R /var/lib/mysql/* $DATA_DIR

  # Ensure mysql owns the DATA_DIR
  chown -R mysql:mysql $DATA_DIR
  chmod -R 775 $DATA_DIR
  chown -R mysql /var/log/mysql
  chown -R 775 /var/log/mysql
fi

if [ -e /firstrun ]; then
  echo "First run detected..."

  # Create MySQL user data
  USER=${USER:-admin}
  PASS=${PASS:-$(pwgen -s -1 16)}

  if [ -e $BASEFOLDER/$tag/hosts ]; then
    # Get existsing user data
    USER=$(cat $HOME_DIR/.mysql/mysql_user)
    PASS=$(cat $HOME_DIR/.mysql/mysql_pass)
  else
    # Make .mysql folder
    mkdir -p $HOME_DIR/.mysql
    # Note MySql user data to root home dir
    echo "$USER" > $HOME_DIR/.mysql/mysql_user
    echo "$PASS" > $HOME_DIR/.mysql/mysql_pass
  fi

  # Wait for start
  wait_for_first_run &
fi

# Start Mysql
echo "Starting MySQL..."
/usr/bin/mysqld_safe
