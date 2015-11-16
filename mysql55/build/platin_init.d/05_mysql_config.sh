# Restart mysql service, if it exists.
if [ -e /etc/service/mysql/run ]; then
  echo "Reloading mysql."
  killall mysqld
  sleep 1s
fi
