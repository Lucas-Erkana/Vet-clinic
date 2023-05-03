/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY,
    name varchar(150),
    date_of_birth DATE,
    escape_attempts INT,
    neutered bool,
    weight_kg float
);

ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

ALTER TABLE animals
ALTER COLUMN weight_kg TYPE DECIMAL(10,2);

CREATE TABLE owners (
  id BIGSERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);
