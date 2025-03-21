/*database"iwt_assignment"*/
-- Drop database if it exists (use this if you want a clean start)
DROP DATABASE IF EXISTS iwt_assignment;
CREATE DATABASE iwt_assignment;
USE iwt_assignment;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Claim;
DROP TABLE IF EXISTS Policy;
DROP TABLE IF EXISTS Registered_User;
DROP TABLE IF EXISTS Health_Care_Provider;
DROP TABLE IF EXISTS Package;
DROP TABLE IF EXISTS Insurance_Company;
DROP TABLE IF EXISTS System;

-- CREATE TABLE Registered User
CREATE TABLE Registered_User (
    User_ID VARCHAR(15) NOT NULL PRIMARY KEY,
    User_Type ENUM('Admin', 'User', 'Developer', 'Agent') NOT NULL,
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    U_Email VARCHAR(50) NOT NULL,
    Home_No VARCHAR(10) NOT NULL,
    Street VARCHAR(50) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Postal_Code VARCHAR(15) NOT NULL,
    Country VARCHAR(30) NOT NULL,
    U_PNumber VARCHAR(15) NOT NULL, -- Changed from DECIMAL to VARCHAR
    DOB DATE NOT NULL,
    Gender ENUM('Male', 'Female', 'Custom') NOT NULL,
    Username VARCHAR(20) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    CONSTRAINT U_Email_Chk CHECK (U_Email LIKE '%_@__%.__%')
);

-- CREATE TABLE Health Care Provider
CREATE TABLE Health_Care_Provider (
    HCP_ID VARCHAR(20) NOT NULL PRIMARY KEY,
    HCP_Name VARCHAR(50) NOT NULL,
    HCP_Email VARCHAR(50) NOT NULL CHECK (HCP_Email LIKE '%_@__%.__%'),
    HCP_PNo VARCHAR(15) NOT NULL, -- Changed from DECIMAL to VARCHAR
    HCP_Address VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Service VARCHAR(100) NOT NULL,
    Certification VARCHAR(100) NOT NULL,
    License VARCHAR(100) NOT NULL
);

-- CREATE TABLE Package
CREATE TABLE Package (
    Pkg_ID VARCHAR(20) NOT NULL PRIMARY KEY,
    Pkg_Name VARCHAR(50) NOT NULL,
    Pkg_Description VARCHAR(255) NOT NULL,
    Deductible DECIMAL(10,2) NOT NULL,
    Co_Payment DECIMAL(10,2) NOT NULL,
    Max_Coverage_Limit DECIMAL(15,2) NOT NULL,
    Payment_Interval VARCHAR(15) NOT NULL,
    Waiting_Period VARCHAR(10) NOT NULL,
    Premium_Amount DECIMAL(10,2) NOT NULL,
    Regulation VARCHAR(255) NOT NULL,
    Total_Amount DECIMAL(15,2) NOT NULL
);

-- CREATE TABLE System
CREATE TABLE System (
    S_ID VARCHAR(15) NOT NULL PRIMARY KEY,
    Version VARCHAR(50) NOT NULL,
    S_Name VARCHAR(50) NOT NULL,
    Installation_Date DATE NOT NULL
);

-- CREATE TABLE Insurance Company
CREATE TABLE Insurance_Company (
    Licence_No VARCHAR(20) NOT NULL PRIMARY KEY,
    C_Name VARCHAR(50) NOT NULL,
    C_PNumber VARCHAR(15) NOT NULL, -- Changed from DECIMAL to VARCHAR
    C_Email VARCHAR(50) NOT NULL CHECK (C_Email LIKE '%_@__%.__%'),
    Home_No VARCHAR(10) NOT NULL,
    Street VARCHAR(50) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Postal_Code VARCHAR(15) NOT NULL,
    Country VARCHAR(30) NOT NULL
);

-- CREATE TABLE Policy
CREATE TABLE Policy (
    Policy_ID VARCHAR(20) NOT NULL PRIMARY KEY,
    User_ID VARCHAR(15) NOT NULL,
    Pkg_ID VARCHAR(20) NOT NULL,
    Policy_Type VARCHAR(50) NOT NULL,
    Effective_Date DATE NOT NULL,
    Expiration_Date DATE NOT NULL,
    Policy_Status ENUM('Active', 'Inactive', 'Pending', 'Denied') NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Registered_User (User_ID),
    FOREIGN KEY (Pkg_ID) REFERENCES Package (Pkg_ID)
);

-- CREATE TABLE Claim
CREATE TABLE Claim (
    Claim_ID VARCHAR(20) NOT NULL PRIMARY KEY,
    Policy_ID VARCHAR(20) NOT NULL,
    User_ID VARCHAR(15) NOT NULL,
    HCP_ID VARCHAR(20) NOT NULL,
    Claim_Type VARCHAR(50) NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    Status_Type ENUM('Approved', 'Denied', 'Pending') NOT NULL,
    Submission_Date DATE NOT NULL,
    Processing_Date DATE NOT NULL,
    Payment_Date DATE,
    Reason VARCHAR(100) NOT NULL,
    FOREIGN KEY (Policy_ID) REFERENCES Policy (Policy_ID),
    FOREIGN KEY (User_ID) REFERENCES Registered_User (User_ID),
    FOREIGN KEY (HCP_ID) REFERENCES Health_Care_Provider (HCP_ID)
);

-- INSERT DATA INTO Registered_User
INSERT INTO Registered_User 
VALUES 
('198863184203', 'User', 'Saman', 'Silva', 'samansilva@gmail.com', 'N0.45/2', 'Araliya Road', 'Ja-Ela', '11350', 'Sri Lanka', '713560160', '1998-03-11', 'Male', 'SamanSilva', '455268a3ff2c93e5010f48baf269d964'),
('197313046228', 'Admin', 'Ramesh', 'Fernando', 'rameshfernando@gmail.com', 'N0.124/7', 'Deans Road', 'Batticaloa', '30016', 'Sri Lanka', '714447345', '1973-12-07', 'Male', 'RameshFernando', '3c591ecd96a4d5c39232eb425378b0fb');

-- INSERT DATA INTO Health_Care_Provider
INSERT INTO Health_Care_Provider 
VALUES 
('H0001', 'Asiri Health Hospital', 'infochl@asiri.lk', '0114665500', 'No.144, Norris Canal Road, Colombo-10', 'Cardiology', 'Inpatient Care', 'ISO Certified', 'Private Hospital License');

-- INSERT DATA INTO Package
INSERT INTO Package 
VALUES 
('P0001', 'Basic Package', 'Coverage for hospitalization and check-ups', 8000.00, 10000.00, 100000.00, 'Monthly', '5 months', 20000.00, 'Regulatory Requirements', 150000.00);

-- INSERT DATA INTO Policy
INSERT INTO Policy 
VALUES 
('P100', '198863184203', 'P0001', 'Access Policy', '2019-03-05', '2024-03-05', 'Active');

-- INSERT DATA INTO Claim
INSERT INTO Claim 
VALUES 
('C01', 'P100', '198863184203', 'H0001', 'Medical Claim', 20000.00, 'Pending', '2023-05-31', '2023-06-05', NULL, 'Medical Treatment');
