/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';

ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

SELECT * FROM animals

BEGIN;
DELETE FROM animals;
SELECT * FROM animals

ROLLBACK;
SELECT * FROM animals

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO my_savepoint;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT * FROM animals

SELECT COUNT(*) FROM animals;

SELECT COUNT(id) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) as max_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY max_escape_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.id, animals.id;

SELECT species.name, COUNT(animals.id) AS num_animals
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name
ORDER BY num_animals DESC;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';


SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, animal_count.num_animals
FROM owners
JOIN (
SELECT owner_id, COUNT(*) AS num_animals
FROM animals
GROUP BY owner_id
) AS animal_count
ON owners.id = animal_count.owner_id
ORDER BY animal_count.num_animals DESC
LIMIT 1;

SELECT animals.name 
FROM animals 
INNER JOIN visits ON animals.id = visits.animal_id 
INNER JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC 
LIMIT 1;

SELECT COUNT(DISTINCT animal_id) AS animal_count
FROM visits
WHERE vet_id = (
  SELECT id
  FROM vets
  WHERE name = 'Stephanie Mendez'
);

SELECT vets.name, COALESCE(string_agg(specializations.species_name, ', '), 'No Specializations') AS specialties, vets.date_of_graduation
FROM vets 
LEFT JOIN (
    SELECT vets.id, species.name AS species_name
    FROM vets 
    JOIN specializations ON vets.id = specializations.vet_id 
    JOIN species ON specializations.species_id = species.id
) AS specializations ON vets.id = specializations.id
GROUP BY vets.name, vets.date_of_graduation;

SELECT animals.name, visits.visit_date
FROM animals
INNER JOIN visits ON animals.id = visits.animal_id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' 
  AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name AS animal_name, COUNT(visits.animal_id) AS num_visits 
FROM visits 
INNER JOIN animals ON visits.animal_id = animals.id 
GROUP BY visits.animal_id, animals.name 
ORDER BY num_visits DESC 
LIMIT 1;

SELECT animals.name AS animal_name, visits.visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT 
  animals.*, 
  vets.*, 
  visits.visit_date
FROM 
  visits
  JOIN vets ON visits.vet_id = vets.id
  JOIN animals ON visits.animal_id = animals.id
WHERE 
  visits.visit_date = (
    SELECT MAX(visit_date) FROM visits
  )

SELECT COUNT(*) AS num_visits_without_specialization
FROM visits v
INNER JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON v.vet_id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;

SELECT species.name AS species_name, COUNT(*) AS num_visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.id
ORDER BY num_visits DESC
LIMIT 1;

