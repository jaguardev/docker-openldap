FROM alpine

VOLUME ["/var/lib/openldap"]

RUN  apk update \
  && apk add openldap openldap-back-mdb \
  && rm -rf /var/cache/apk/*

RUN mkdir /run/openldap/ && chmod 777 /run/openldap/

RUN mkdir /docker-entrypoint-init

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 389

CMD ["slapd", "-d", "32768", "-u", "ldap", "-g", "ldap"]
