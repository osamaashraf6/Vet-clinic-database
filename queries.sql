/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

--  List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' And '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered =TRUE And escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * from animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;


-- the two day
-- Inside a transaction update the animals table by setting the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';

-- Verify that change was made
SELECT * FROM animals;

--  roll back the change
ROLLBACK;

-- verify that species columns went back to the state before transaction.
SELECT * FROM animals;

-- make a transcation
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

-- Verify that change was made
SELECT * FROM animals;


-- Deleting all animals
BEGIN;

DELETE FROM animals;

-- Verify that the animnals table is empty
SELECT * FROM animals;

ROLLBACK;

--verify that thet changes were rolledback
SELECT * FROM animals;


BEGIN;
DELETE FROM animals WHERE date_of_birth >'2022-01-01';
select * from animals;
SAVEPOINT save_point1;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO save_point1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


-- 

SELECT count(*) from animals where escape_attempts = 0;

-- What is the average weight of animals?
SELECT avg(weight_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species,min(weight_kg), max(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' And '2000-01-01' GROUP BY species;

-- 

-- What animals belong to Melody Pond?
SELECT full_name, name from owners o INNER JOIN animals a ON o.id=a.id where o.full_name= 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT * from animals a INNER JOIN species s ON s.id=a.species_id where s.name= 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id ;

-- How many animals are there per species?
select count(*) FROM species s LEFT JOIN animals a ON s.id=a.species_id  GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
select * from animals a INNER JOIN owners o ON a.owner_id=o.id INNER JOIN species s ON s.id=a.species_id where s.name='Digimon' AND o.full_name='Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals a INNER JOIN owners o ON o.id = a.owner_id where o.full_name='Dean Winchester' AND a.escape_attempts=0;

-- Who owns the most animals?
SELECT o.full_name,count(*) FROM animals a INNER JOIN owners o ON o.id = a.owner_id GROUP BY o.full_name ORDER BY COUNT DESC LIMIT 1;

-- 

-- complex queries that answer analytical questions appplying for Many to Many relationships
-- Who was the last animal seen by William Tatcher?
SELECT d.name as vet_name,a.name as animal_name,v.date_of_visit as last_visit  from animals a INNER JOIN visits v ON a.id=v.animal_id INNER JOIN vets d ON d.id=v.vet_id where d.name='William Tatcher' ORDER BY  date_of_visit DESC LIMIT 1 ;   

-- How many different animals did Stephanie Mendez see?
SELECT d.name as vet_name , count(v.date_of_visit) as number_of_visits from visits v 
INNER JOIN vets d ON d.id=v.vet_id where d.name='Stephanie Mendez' GROUP BY d.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT sp.species_id, sp.vet_id, v.name AS vet_name, s.name AS species_name  
  FROM specializations sp FULL OUTER JOIN species s ON s.id = sp.species_id
  FULL OUTER JOIN vets v ON v.id = sp.vet_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT d.name as vet_name,a.name as animal_name,v.date_of_visit as visit_date  from animals a
INNER JOIN visits v ON a.id=v.animal_id INNER JOIN
vets d ON d.id=v.vet_id where d.name='Stephanie Mendez' AND  date_of_visit BETWEEN '2020-04-01' And '2020-08-30';;   

-- What animal has the most visits to vets?
SELECT a.name as animal_name , COUNT(v.date_of_visit) as number_of_visits from visits v 
INNER JOIN animals a ON a.id=v.animal_id GROUP BY  a.name ORDER BY COUNT(v.date_of_visit) DESC LIMIT 1 ;

-- Who was Maisy Smith's first visit?
SELECT d.name as vet_name,a.name as animal_name,v.date_of_visit as First_visit  from animals a INNER JOIN visits v ON a.id=v.animal_id INNER JOIN vets d ON d.id=v.vet_id where d.name='Maisy Smith' ORDER BY  date_of_visit ASC limit 1;   

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT 
  a.id AS animal_id,  a.name AS animal_name,a.date_of_birth, d.id AS vet_id,  d.name AS vet_name, 
  d.age AS vet_age,
  date_of_visit
  FROM visits v INNER JOIN animals a ON a.id = v.animal_id
  INNER JOIN vets d
  ON d.id = v.vet_id;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT d.name AS vet_name, COUNT(*)
  FROM visits v LEFT JOIN vets d ON d.id = v.vet_id
  LEFT JOIN specializations sp 
    ON sp.vet_id = v.vet_id
  WHERE sp.species_id IS NULL
  GROUP BY d.name;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT d.name AS vet_name, s.name AS species_name, COUNT(s.name)
  FROM visits v LEFT JOIN animals a ON a.id = v.animal_id
  LEFT JOIN vets d 
    ON d.id = v.vet_id
  LEFT JOIN species s
    ON s.id = a.species_id
  WHERE d.name = 'Maisy Smith'
  GROUP BY d.name, s.name
  ORDER BY COUNT DESC
  LIMIT 1;