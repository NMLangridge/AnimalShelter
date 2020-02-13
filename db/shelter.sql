DROP TABLE owners;
DROP TABLE animals;

CREATE TABLE animals(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  species VARCHAR(255),
  admission_date VARCHAR(255),
  image_url VARCHAR(255)
);

CREATE TABLE owners(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  animal_id INT8 REFERENCES animals(id) ON DELETE CASCADE
);
