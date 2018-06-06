#!/bin/sh

echo "Starting OpenLDAP..."

process_init_file() {
	local f="$1"; shift

	case "$f" in
		*.sh)     echo "$0: running $f"; . "$f" ;;
		*.ldif)   echo "$0: running $f"; /usr/sbin/slapadd -l "$f"; echo ;;
		*)        echo "$0: ignoring $f" ;;
	esac
	echo
}

if [ ! -d "/var/lib/openldap/openldap-data" ]; then
  echo "Initializing OpenLDAP..."
  mkdir /var/lib/openldap/openldap-data
  for f in /docker-entrypoint-init/*; do
    process_init_file "$f"
  done
	chown -R ldap:ldap /var/lib/openldap/openldap-data
fi

exec "$@"