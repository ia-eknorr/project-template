# `db-init` Directory

## Usage

Place database initialization .sql scripts in this directory to be run on service startup using the container's `docker-entrypoint-initdb.d`. Files in this directory are run by the sql entrypoint alphanumerically. By convention, the following prefixes should be used to differentiate each file and ensure files are executed in the proper order:

- `01-`: Schema/user creation
- `02-`: Table creation within a previously created schema
- `03-`: Seed data to be inserted in previously created table

## Example

- `01-schema.sql`
- `01-mydb-schema.sql`
