CREATE DATABASE medical;

-- Create the patients table
CREATE TABLE patients (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);

--Create medical_histories table
CREATE TABLE medical_histories (
  id INT PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients(Id)
);

--create the treatments
CREATE TABLE treatments (
  id INT PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255)
);

--Create the invoices
CREATE TABLE invoices (
  id INT PRIMARY KEY,
  total_amount DECIMAL(10,2),
  generated_id TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(Id)
);