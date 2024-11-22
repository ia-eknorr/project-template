# `db-connections` Directory

Database connections can be added by mapping in the SQL files to the `/init-db-connections` folder in the container. 

The following syntax is expected in `.json` files to add a database connection:

```json
{
  "name": "ExamplePostgres",
  "type": "POSTGRES",
  "description": "Example PostgreSQL Server Connection",
  "connect_url": "jdbc:postgresql://localhost:5432/database",
  "username": "${DB_USERNAME}",
  "password": "${DB_PASSWORD}",
  "connection_props": ""
}
```

Accepted values for `type` are: `MSSQL`, `POSTGRES`, `SQLITE`, `MYSQL`, `ORACLE`, `MARIADB` 

This functionality will either insert or update existing database connections based off the name of the connection.

For more information, see the [Derived Ignition Image Readme](https://github.com/inductive-automation/common-docker-ignition)
