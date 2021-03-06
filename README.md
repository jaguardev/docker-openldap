# OpenLDAP installation based on Alpine


## Quick start

Run:
```
docker run -p 389:389 vladchernikov/openldap
```

Use you favorite ldap client to connect with credentials:

Login DN: __cn=Manager,dc=my-domain,dc=com__

Password: __secret__

## Customization

See [example](https://github.com/jaguardev/docker-openldap/tree/master/example)

### Initialization

To execute ```.sh``` scripts or ```.ldif``` files on the first run, add them to ```/docker-entrypoint-init```

### Volume

To persist data, mount volume to ```/var/lib/openldap```

### Environment variables

To initialize __cn=config__ specify __FORCE_SLAPADD_CN_CONFIG_LDIF_FILE_PATH__ variable. Even if it was previously initialized it will erase existed db on next start