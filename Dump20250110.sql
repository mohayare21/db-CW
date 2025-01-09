CREATE DATABASE vu_db;
USE vu_db;

CREATE TABLE geographical_location (
    Location_ID INT PRIMARY KEY,
    Village VARCHAR(100),
    Parish VARCHAR(100),
    Sub_County VARCHAR(100),
    County VARCHAR(100),
    Region VARCHAR(100),
    Median_Age INT,
    Median_Income DECIMAL(10, 2),
    Education_Level VARCHAR(100),
    HH_Coverage DECIMAL(5, 2),
    Reported_Cases INT
);

CREATE TABLE supply_chain (
    Supply_ID INT PRIMARY KEY,
    Resource_ID INT,
    Facility_ID INT,
    Quantity_Shipped INT,
    Shipment_Date DATE,
    Added_By INT,
    Added_Date DATE,
    Update_Date DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Resource_ID) REFERENCES resource(Resource_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE resource (
    Resource_ID INT PRIMARY KEY,
    Resource_Type VARCHAR(50),
    Quantity INT,
    Unit VARCHAR(50),
    Last_Updated_Date DATE,
    Description TEXT
);

CREATE TABLE health_facility (
    Facility_ID INT PRIMARY KEY,
    Facility_Name VARCHAR(100),
    Location_ID INT,
    Capacity INT,
    Type_ID INT,
    Contact_Person VARCHAR(100),
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID),
    FOREIGN KEY (Type_ID) REFERENCES facility_type(Facility_Type_ID)
);

CREATE TABLE facility_type (
    Facility_Type_ID INT PRIMARY KEY,
    Description TEXT,
    Date_Added DATE,
    Date_Updated DATE
);

CREATE TABLE epidemiological_data (
    Data_ID INT PRIMARY KEY,
    Recorded_Date DATE,
    Cases_Per_Thousand_People INT,
    Rainfall INT,
    Temperature DECIMAL(5, 2),
    Added_By INT,
    Added_Date DATE
);

CREATE TABLE training (
    Training_ID INT PRIMARY KEY,
    Training_Type VARCHAR(100),
    Training_Date DATE,
    Completion_Status VARCHAR(50)
);

CREATE TABLE treatment (
    Treatment_ID INT PRIMARY KEY,
    Treatment_Name VARCHAR(100),
    Treatment_Description TEXT,
    Dosage VARCHAR(50),
    Side_Effects TEXT,
    Added_By INT,
    Added_Date DATE,
    Update_Date DATE
);

CREATE TABLE treatment_outcome (
    Outcome_ID INT PRIMARY KEY,
    Treatment_ID INT,
    Outcome_Description TEXT,
    Added_By INT,
    Added_Date DATE,
    Update_Date DATE,
    FOREIGN KEY (Treatment_ID) REFERENCES treatment(Treatment_ID)
);

CREATE TABLE laboratory_tests (
    Test_ID INT PRIMARY KEY,
    Test_Type VARCHAR(50),
    Test_Result VARCHAR(50),
    Test_Date DATE,
    Technician_ID INT,
    Visit_ID INT,
    FOREIGN KEY (Visit_ID) REFERENCES visit_record(Visit_ID)
);

CREATE TABLE visit_record (
    Visit_ID INT PRIMARY KEY,
    Patient_ID INT,
    Visit_Date DATE,
    Health_Facility_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Health_Facility_ID) REFERENCES health_facility(Facility_ID)
);

CREATE TABLE patient_data (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Added_By INT,
    Added_Date DATE,
    Update_Date DATE
);

CREATE TABLE referral (
    Referral_ID INT PRIMARY KEY,
    Patient_ID INT,
    Visit_ID INT,
    Referred_To VARCHAR(100),
    Description TEXT,
    Referral_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Visit_ID) REFERENCES visit_record(Visit_ID)
);

CREATE TABLE malaria (
    Case_ID INT PRIMARY KEY,
    Patient_ID INT,
    Date_Of_Diagnosis DATE,
    Treatment_ID INT,
    Outcome_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES treatment(Treatment_ID),
    FOREIGN KEY (Outcome_ID) REFERENCES treatment_outcome(Outcome_ID)
);

CREATE TABLE interventions (
    Intervention_ID INT PRIMARY KEY,
    Visit_ID INT,
    Intervention_Type VARCHAR(100),
    Start_Date DATE,
    End_Date DATE,
    Added_By INT,
    Added_Date DATE,
    FOREIGN KEY (Visit_ID) REFERENCES visit_record(Visit_ID)
);

CREATE TABLE system_log (
    Log_ID INT PRIMARY KEY,
    Facility_ID INT,
    User_ID INT,
    Timestamp DATETIME,
    IP_Address VARCHAR(50),
    Location VARCHAR(100),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (User_ID) REFERENCES user(User_ID)
);

CREATE TABLE user (
    User_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Role_ID INT,
    Password VARCHAR(100),
    FOREIGN KEY (Role_ID) REFERENCES user_role(Role_ID)
);

CREATE TABLE user_role (
    Role_ID INT PRIMARY KEY,
    Role_Name VARCHAR(50),
    Added_By INT,
    Date_Added DATE
);

CREATE TABLE malaria_cases_by_region (
    Region_ID INT PRIMARY KEY,
    Region_Name VARCHAR(100),
    Total_Cases INT,
    Last_Updated DATE
);

CREATE TABLE laboratory_tests_view (
    Test_ID INT PRIMARY KEY,
    Test_Type VARCHAR(50),
    Test_Result VARCHAR(50),
    Test_Date DATE,
    Facility_Name VARCHAR(100)
);

CREATE TABLE patient_view (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Facility_Visited VARCHAR(100),
    Last_Visit_Date DATE
);
