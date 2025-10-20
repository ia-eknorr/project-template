-- Set the search path to the 'public' schema
SET SEARCH_PATH TO public;

-- Insert seed data into example_table
INSERT INTO example_table (name, description, status, created_at, updated_at)
VALUES
  ('John Doe', 'Software Engineer', 'A', '2023-01-01 12:34:56', '2023-02-15 08:45:30'),
  ('Alice Smith', 'Product Manager', 'B', '2023-03-10 09:15:22', '2023-04-25 16:20:45'),
  ('Bob Johnson', 'Data Analyst', 'C', '2023-05-18 18:02:10', '2023-06-30 22:55:12'),
  ('Eva Davis', 'UI/UX Designer', 'D', '2023-07-12 04:30:18', '2023-08-27 11:10:36');
