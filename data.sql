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


  -- 


  INSERT INTO vets (name,age,date_of_graduation)
VALUES ('William Tatcher', 45 , '2000-4-23');

INSERT INTO vets (name,age,date_of_graduation)
VALUES ('Maisy Smith', 26 , '2019-01-17');

INSERT INTO vets (name,age,date_of_graduation)
VALUES ('Stephanie Mendez', 64 , '1981-05-14');

INSERT INTO vets (name,age,date_of_graduation)
VALUES ('Jack Harkness', 38 , '2008-06-18');

-- Inserting data into Specializations table
INSERT INTO specializations (species_id, vet_id) VALUES (1,(SELECT id FROM vets WHERE name = 'William Tatcher'));

INSERT INTO specializations (species_id, vet_id) VALUES (1,(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
(2,(SELECT id FROM vets WHERE name = 'Stephanie Mendez'));

INSERT INTO specializations (species_id, vet_id) VALUES (2,(SELECT id FROM vets WHERE name = 'Jack Harkness'));


-- insert data in visits table
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES((SELECT id from animals where name='Agumon'),(SELECT id from vets where name='William Tatcher'),'2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES((SELECT id from animals where name='Gabumon'),(SELECT id from vets where name='Jack Harkness'),'2021-02-02'),
((SELECT id from animals where name='Agumon'),(SELECT id from vets where name='Stephanie Mendez'),'2020-07-22'),
((SELECT id from animals where name='Pikachu'),(SELECT id from vets where name='Maisy Smith'),'2020-01-05'),
((SELECT id from animals where name='Pikachu'),(SELECT id from vets where name='Maisy Smith'),'2020-03-08'),
((SELECT id from animals where name='Agumon'),(SELECT id from vets where name='Maisy Smith'),'2020-05-14');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES((SELECT id from animals where name='Devimon'),(SELECT id from vets where name='Stephanie Mendez'),'2021-5-4'),
((SELECT id from animals where name='Charmander'),(SELECT id from vets where name='Jack Harkness'),'2021-02-24'),
((SELECT id from animals where name='Plantmon'),(SELECT id from vets where name='Maisy Smith'),'2019-12-21'),
((SELECT id from animals where name='Plantmon'),(SELECT id from vets where name='William Tatcher'),'2020-08-10'),
((SELECT id from animals where name='Plantmon'),(SELECT id from vets where name='Maisy Smith'),'2021-04-7');

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES((SELECT id from animals where name='Squirtle'),(SELECT id from vets where name='Stephanie Mendez'),'2019-09-29'),
((SELECT id from animals where name='Angemon'),(SELECT id from vets where name='Jack Harkness'),'2021-10-03'),
((SELECT id from animals where name='Angemon'),(SELECT id from vets where name='Jack Harkness'),'2020-11-04'),
((SELECT id from animals where name='Boarmon'),(SELECT id from vets where name='Maisy Smith'),'2019-01-24'),
((SELECT id from animals where name='Boarmon'),(SELECT id from vets where name='Maisy Smith'),'2019-05-15'),
((SELECT id from animals where name='Boarmon'),(SELECT id from vets where name='Maisy Smith'),'2020-02-27'),
((SELECT id from animals where name='Boarmon'),(SELECT id from vets where name='Maisy Smith'),'2020-08-03'),
((SELECT id from animals where name='Blossom'),(SELECT id from vets where name='Stephanie Mendez'),'2020-05-24'),
((SELECT id from animals where name='Blossom'),(SELECT id from vets where name='William Tatcher'),'2021-01-11');