/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL,
    name VARCHAR(160),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL

);
--Add a column species of type string to your animals table.
ALTER TABLE animals ADD species VARCHAR(250);


-- Add two tables owners and species
CREATE TABLE owners(
   id INT GENERATED ALWAYS AS IDENTITY,
   full_name VARCHAR(150) ,
   age INT NOT NULL,
   PRIMARY KEY(id)   
);

CREATE TABLE species(
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(150) ,
   PRIMARY KEY(id)
);

-- Modify animals table:
ALTER TABLE animals DROP COLUMN species;

-- Add forign key for species in animals table
ALTER TABLE animals 
ADD species_id INT references species (id);

-- Add forign key for owners in animals table
ALTER TABLE animals 
ADD owner_id  INT references owners (id);