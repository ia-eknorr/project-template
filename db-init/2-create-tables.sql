-- Create Schema example
SET SEARCH_PATH TO public;

-- Table example_table
CREATE TABLE IF NOT EXISTS example_table (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(45),
  description TEXT,
  status CHAR(1),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
