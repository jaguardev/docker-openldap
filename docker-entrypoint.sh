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

INITIALIZED=0

if [ -d "/var/lib/openldap/openldap-data" ]; then
	INITIALIZED=1
fi

if [ $INITIALIZED -eq 0 ]; then
	mkdir /var/lib/openldap/openldap-data
fi

if [ -n "$FORCE_SLAPADD_CN_CONFIG_LDIF_FILE_PATH" ] && [ -f "$FORCE_SLAPADD_CN_CONFIG_LDIF_FILE_PATH" ]; then
 	echo "Configuring OpenLDAP..."
 	rm -rf /etc/openldap/slapd.d
	mkdir /etc/openldap/slapd.d
 	/usr/sbin/slapadd -n 0 -F /etc/openldap/slapd.d -l $FORCE_SLAPADD_CN_CONFIG_LDIF_FILE_PATH
	chown -R ldap:ldap /etc/openldap/slapd.d
	chmod -R 700 /etc/openldap/slapd.d
fi

if [ $INITIALIZED -eq 0 ]; then
	echo "Initializing OpenLDAP..."
	for f in /docker-entrypoint-init/*; do
		process_init_file "$f"
	done
	chown -R ldap:ldap /var/lib/openldap/openldap-data
	chmod -R 700 /var/lib/openldap/openldap-data
fi

exec "$@"