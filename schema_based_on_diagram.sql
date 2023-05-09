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

--create the invoice_items
CREATE TABLE invoice_items (
  id INT PRIMARY KEY,
  unit_price DECIMAL(10,2),
  quantity INT,
  total_price DECIMAL(10,2),
  invoice_id INT,
  treatment_id INT,
  FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(Id)
);

-- create join tables for many to many relations
CREATE TABLE medical_histories_treatment (
  medical_histories_id INT NOT NULL,
  treatments_id INT NOT NULL,
  CONSTRAINT fk_medical_histories
   FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),
  CONSTRAINT fk_treatments
   FOREIGN KEY(treatments_id) REFERENCES treatments(id)
);