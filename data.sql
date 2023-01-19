/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Charmander','2020-02-08', 0, FALSE, -11 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Plantmon','2021-11-15', 2, TRUE, -5.7 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Squirtle','1994-04-02', 3, FALSE, -12.13 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Angemon','2005-06-12', 1, TRUE, -45 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Boarmon','2005-06-07', 7, TRUE, 20.4 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Blossom','1998-10-13', 3, TRUE, 17 );

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Ditto','1998-05-14', 4, TRUE, 22 );


-- 

-- inser data in owners table

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Sam Smith',
  34
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Jennifer Orwell',
  19
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Bob',
  45
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Melody Pond',
  77
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Dean Winchester',
  14
);

INSERT INTO owners(
  full_name,
  age
) VALUES(
  'Jodie Whittaker',
  38
);

-- insert data in species table
INSERT INTO species(name) VALUES ('Pokemon');
INSERT INTO species(name) VALUES ('Digimon');


-- Modify inserted animals so it includes the species_id value
UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
  WHERE name LIKE '%mon';

-- All other animals are Pokemon 
UPDATE animals
  SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
  WHERE species_id IS NULL;


-- Modify your inserted animals to include owner information (owner_id): 
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHERE name LIKE 'Agumon';

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
  WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHERE name IN ('Angemon', 'Boarmon');