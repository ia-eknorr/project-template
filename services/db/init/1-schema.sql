-- Create database
CREATE DATABASE db;

-- Connect to the database
\c db

-- Grant privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON TABLES TO ignition;