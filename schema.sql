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