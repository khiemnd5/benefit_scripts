#!/bin/bash

### pg_restore -d [database] [slq file].sql -c -U [userdb]
### example
pg_restore -d dbuser data_database.sql -c -U userpostgres
