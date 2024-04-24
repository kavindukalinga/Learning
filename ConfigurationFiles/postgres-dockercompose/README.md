# PostgreSQL

## Run

```bash
docker compose up
```  

```bash
docker exec -it pgdb4 bash
```

```bash
# Inside the container
psql -n postgres -U postgres`  
```

```bash
# Inside the psql
\l
\c testdb
\dt
```

```bash
docker compose down
```

## SQL-Queries

```sql
-- Add columns to the existing table
ALTER TABLE public.testtable
ADD COLUMN integer_column INTEGER,
ADD COLUMN float_column FLOAT,
ADD COLUMN boolean_column BOOLEAN,
ADD COLUMN date_column DATE,
ADD COLUMN timestamp_column TIMESTAMP;

-- Insert sample data into the expanded table
INSERT INTO public.testtable (id, text, integer_column, float_column, boolean_column, date_column, timestamp_column) VALUES
  (1, 'Sample text 1', 10, 3.14, TRUE, '2024-04-24', '2024-04-24 10:00:00'),
  (2, 'Sample text 2', 20, 6.28, FALSE, '2024-04-25', '2024-04-25 10:00:00'),
  (3, 'Sample text 3', 30, 9.42, TRUE, '2024-04-26', '2024-04-26 10:00:00'),
  (4, 'Sample text 4', 40, 12.56, FALSE, '2024-04-27', '2024-04-27 10:00:00'),
  (5, 'Sample text 5', 50, 15.70, TRUE, '2024-04-28', '2024-04-28 10:00:00'),
  (6, 'Sample text 6', 60, 18.84, FALSE, '2024-04-29', '2024-04-29 10:00:00'),
  (7, 'Sample text 7', 70, 21.98, TRUE, '2024-04-30', '2024-04-30 10:00:00'),
  (8, 'Sample text 8', 80, 25.12, FALSE, '2024-05-01', '2024-05-01 10:00:00'),
  (9, 'Sample text 9', 90, 28.26, TRUE, '2024-05-02', '2024-05-02 10:00:00'),
  (10, 'Sample text 10', 100, 31.40, FALSE, '2024-05-03', '2024-05-03 10:00:00');
```
