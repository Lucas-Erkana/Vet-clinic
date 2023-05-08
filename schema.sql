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

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals 
ADD COLUMN species_id INTEGER REFERENCES species(id);

ALTER TABLE animals 
ADD COLUMN owner_id INTEGER REFERENCES owners(id);

CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INTEGER,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

CREATE TABLE visits (
    vet_id INTEGER REFERENCES vets(id),
    animal_id INTEGER REFERENCES animals(id),
    visit_date DATE,
    PRIMARY KEY (vet_id, animal_id, visit_date)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);