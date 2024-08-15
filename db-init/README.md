# `db-init` Directory

## Usage

Place database instantiation .sql scripts in this directory to be run on `docker compose up` using MySQL's `docker-entrypoint-initdb.d`. By convention, the following prefixes should be used to differentiate each file and ensure files are executed in the proper order:

- `01-`: Schema/user creation
- `02-`: Table creation within a previously created schema
- `03-`: Seed data to be inserted in previously created table
