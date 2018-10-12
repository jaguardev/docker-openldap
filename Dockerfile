FROM alpine:3.8

ENV FORCE_SLAPADD_CN_CONFIG_LDIF_FILE_PATH=

VOLUME ["/var/lib/openldap"]

RUN  apk --no-cache add openldap=2.4.46-r0 openldap-backend-all=2.4.46-r0 openldap-overlay-all=2.4.46-r0

RUN mkdir /run/openldap/ && chmod 777 /run/openldap/

RUN mkdir /docker-entrypoint-init

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 389

CMD ["slapd", "-d", "32768", "-u", "ldap", "-g", "ldap"]
