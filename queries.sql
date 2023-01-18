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