DROP SCHEMA IF EXISTS Hicron_Hickathon2023;
CREATE SCHEMA Hicron_Hickathon2023;
USE Hicron_Hickathon2023;

CREATE TABLE Persons (
  id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  phone_number VARCHAR(20),
  address VARCHAR(100),
  city VARCHAR(50),
  country VARCHAR(50),
  postal_code VARCHAR(10),
  role ENUM('Employee', 'Manager') NOT NULL,
  total_absence_days INT,
  total_days INT GENERATED ALWAYS AS (
    SELECT SUM(DATEDIFF(end_date, start_date) + 1) 
    FROM Absences 
    WHERE Absences.person_id = Persons.id
  ) STORED
);

CREATE TABLE Absences (
  id INT PRIMARY KEY,
  person_id INT,
  start_date DATE,
  end_date DATE,
  reason VARCHAR(100),
  approved ENUM('Approved', 'Rejected', 'Pending') DEFAULT 'Pending';
  FOREIGN KEY (person_id) REFERENCES Persons(id)
);
