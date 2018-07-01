FROM alpine

VOLUME ["/var/lib/openldap"]

RUN  apk --no-cache add openldap=2.4.45-r3 openldap-back-mdb

RUN mkdir /run/openldap/ && chmod 777 /run/openldap/

RUN mkdir /docker-entrypoint-init

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 389

CMD ["slapd", "-d", "32768", "-u", "ldap", "-g", "ldap"]
