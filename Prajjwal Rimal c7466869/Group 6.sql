-- Table Creation --

-- Dropping all the tables

Drop table Police_Officer cascade constraints;
Drop table Event cascade constraints;
Drop table Crime cascade constraints;
Drop table Department cascade constraints;
Drop table Offender cascade constraints;
Drop table Evidence cascade constraints;
Drop table Locations cascade constraints;
Drop table Detective cascade constraints;
Drop table Person cascade constraints;
Drop table Offense cascade constraints;
Drop table Inspector cascade constraints;
Drop table Primary_Crime cascade constraints;
Drop table Secondary_Crime cascade constraints;
Drop table Victim cascade constraints;
Drop table Witness cascade constraints;
Drop table Reporter cascade constraints;
Drop table Crime_Offender cascade constraints;
Drop table Event_Person cascade constraints;
Drop table Related_Crime cascade constraints;
Drop table Suspect cascade constraints;


-- Inspector Table

CREATE TABLE Inspector(
	Inspector_ID NUMBER(20,2) NOT NULL,          --PRIMARY KEY
	Inspector_First_Name VARCHAR2(20) NOT NULL,
    Inspector_Last_Name VARCHAR2(20) NOT NULL,
	CONSTRAINT pk_Inspector_ID PRIMARY KEY (Inspector_ID) 
);

-- Department Table

CREATE TABLE Department (
    Department_ID NUMBER(20,2) NOT NULL,      --PRIMARY KEY
    Department_Name VARCHAR2(50) NOT NULL,
    DEPT_Description VARCHAR2(255),
    CONSTRAINT pk_Department_ID1 PRIMARY KEY (Department_ID) 
);

--Detective Table

CREATE TABLE Detective(
	Detective_ID NUMBER(20,2) NOT NULL,      --PRIMARY KEY
	Detective_Name VARCHAR2(20) NOT NULL,
	CONSTRAINT pk_Detective_ID PRIMARY KEY (Detective_ID) 
);

-- Police_Officer Table

CREATE TABLE Police_Officer(
	Officer_ID	NUMBER(15,2) NOT NULL,            --PRIMARY KEY
	Officer_First_Name	VARCHAR2(50) NOT NULL,
    Officer_Last_Name	VARCHAR2(50) NOT NULL,
	Inspector_ID	NUMBER(20,2),                 --FOREIGN KEY1
    Department_ID NUMBER(20,2) NOT NULL,          --FOREIGN KEY2
	CONSTRAINT pk_Police_Officer PRIMARY KEY (Officer_ID), 
    CONSTRAINT fk_Inspector_ID FOREIGN KEY (Inspector_ID) REFERENCES Inspector(Inspector_ID), 
    CONSTRAINT fk_Department_ID1 FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID) 
);

--Offender Table

CREATE TABLE Offender(
	Offender_ID	NUMBER(20,2) NOT NULL,      --PRIMARY KEY
	Offender_Name VARCHAR2(50) NOT NULL,
	Offender_History VARCHAR2(100),
    Date_of_Birth DATE,
	CONSTRAINT pk_Offender PRIMARY KEY (Offender_ID) 
);

--Offence Table

CREATE TABLE Offense(
	Offense_ID NUMBER(20,2) NOT NULL,        --PRIMARY KEY
	Offense_Date DATE,
	Offense_Name VARCHAR2(20) NOT NULL,
    Offense_Detail VARCHAR2(255),
	CONSTRAINT pk_Offense_ID PRIMARY KEY (Offense_ID) 
);

--Location Table

CREATE TABLE Locations(
	Location_ID	NUMBER(20,2) NOT NULL,        --PRIMARY KEY
	City VARCHAR2(20) NOT NULL,
	Region VARCHAR2(20) NOT NULL,
	CONSTRAINT pk_Location_ID1 PRIMARY KEY (Location_ID) 
);

--Person Table

CREATE TABLE Person(
    Person_ID NUMBER(20,2) NOT NULL,         --PRIMARY KEY
    Person_Name VARCHAR2(255) NOT NULL,
    Age Number(5,2),
    Gender VARCHAR2(50),
    Contact_Number NUMBER(20),
    Person_Role VARCHAR2(20) CHECK (Person_Role IN('Victim', 'Witness', 'Reporter')) NOT NULL,
    CONSTRAINT pk_Person_ID PRIMARY KEY (Person_ID) 
);

--Crime Table

CREATE TABLE Crime (
    Crime_ID NUMBER(20,2) NOT NULL,        --PRIMARY KEY
    Reported_Date DATE NOT NULL,
    Crime_Type VARCHAR2(50) CHECK (Crime_Type IN ('Primary','Secondary')) NOT NULL,
    Severity_Level VARCHAR2(50) CHECK (Severity_Level IN ('High','Medium','Low')) NOT NULL,
    Status VARCHAR2(20) CHECK (Status IN ('Open', 'Closed')) NOT NULL,
    Solved_Date DATE,
    Officer_ID	NUMBER(15,2) NOT NULL,          --FOREIGN KEY1
    Detective_ID NUMBER(20,2) NOT NULL,         --FOREIGN KEY2
    Location_ID	NUMBER(20,2) NOT NULL,          --FOREIGN KEY3
    Offense_ID NUMBER(10,2) NOT NULL,           --FOREIGN KEY4
    CONSTRAINT pk_Crime_ID PRIMARY KEY (Crime_ID),
    CONSTRAINT fk_Police_Officer_ID1 FOREIGN KEY (Officer_ID) REFERENCES Police_Officer(Officer_ID),
    CONSTRAINT fk_Detective_ID1 FOREIGN KEY (Detective_ID) REFERENCES Detective(Detective_ID),
    CONSTRAINT fk_Location_ID1 FOREIGN KEY (Location_ID) REFERENCES Locations(Location_ID),
    CONSTRAINT fk_Offense_ID1 FOREIGN KEY (Offense_ID) REFERENCES Offense(Offense_ID)
);

--Primary_Crime Table

CREATE TABLE Primary_Crime (
    Crime_ID NUMBER(20,2) NOT NULL,         --Primary Key/ FOREIGN KEY
    Crime_Name VARCHAR2(255),
    Victim_Count NUMBER(20,2),
    Crime_Detail VARCHAR2(255),
    CONSTRAINT pk_primarycrime_ID1 PRIMARY KEY (Crime_ID),
    CONSTRAINT fk_primarycrime_ID1 FOREIGN KEY (Crime_ID) REFERENCES Crime(Crime_ID)
);

--Secondary_Crime Table

CREATE TABLE Secondary_Crime (
    Crime_ID NUMBER(20,2) NOT NULL,         --Primary Key/ FOREIGN KEY
    Crime_Name VARCHAR2(255),
    Penalty VARCHAR2(255),
    Crime_Detail VARCHAR2(255),
    CONSTRAINT pk_secondarycrime_ID1 PRIMARY KEY (Crime_ID),
    CONSTRAINT fk_secondarycrime_ID1 FOREIGN KEY (Crime_ID) REFERENCES Crime(Crime_ID)
);

--Event Table

CREATE TABLE Event(
	Event_Id NUMBER(20,2) NOT NULL,         --PRIMARY KEY
	Event_Date DATE NOT NULL,
	Event_Detail VARCHAR2(255),
	Crime_ID NUMBER(20,2) NOT NULL,         --FOREIGN KEY1
	CONSTRAINT pk_Event_ID1 PRIMARY KEY (Event_Id),
    CONSTRAINT fk_Event_ID1 FOREIGN KEY (Crime_ID) REFERENCES CRIME(Crime_ID)
);

--Evidence Table

CREATE TABLE Evidence(
	Evidence_ID	NUMBER(20,2) NOT NULL,      --PRIMARY KEY
	Evidence_Name VARCHAR2(20) NOT NULL,
    Evidence_Details VARCHAR2(255),
	Crime_ID NUMBER(20,2) NOT NULL,         --FOREIGN KEY1
	CONSTRAINT pk_Evidence_ID1 PRIMARY KEY (Evidence_ID),
    CONSTRAINT fk_Evidence_ID1 FOREIGN KEY (Crime_ID) REFERENCES CRIME(Crime_ID)
);

--Suspect Table
CREATE TABLE Suspect(
	Suspect_ID	NUMBER(20,2),      --PRIMARY KEY
	Suspect_Name VARCHAR2(20),
	Crime_ID NUMBER(20,2) NOT NULL,         --FOREIGN KEY1
	CONSTRAINT pk_Suspect_ID1 PRIMARY KEY (Suspect_ID),
    CONSTRAINT fk_Suspect_ID1 FOREIGN KEY (Crime_ID) REFERENCES CRIME(Crime_ID)
);

--Victim Table

CREATE TABLE Victim(
	Person_Id NUMBER(20,2) NOT NULL,            --Primary Key/ FOREIGN KEY
    Victim_Health_Status VARCHAR2(255),
    Victim_Statement VARCHAR2(255),
	CONSTRAINT pk_Victim_ID1 PRIMARY KEY (Person_Id),
    CONSTRAINT fk_Victim_ID1 FOREIGN KEY (Person_Id) REFERENCES Person(Person_Id)
);

--Witness Table

CREATE TABLE Witness(
	Person_Id NUMBER(20,2) NOT NULL,            --Primary Key/ FOREIGN KEY
    Witness_Statement VARCHAR2(255),
    Witness_Status VARCHAR2(255), --IN CONTACT/OUT OF CONTACT
    Consent VARCHAR2(20),   --YES/NO
	CONSTRAINT pk_Witness_ID1 PRIMARY KEY (Person_Id),
    CONSTRAINT fk_Witness_ID1 FOREIGN KEY (Person_Id) REFERENCES Person(Person_Id)
);

--Reporter Table

CREATE TABLE Reporter(
	Person_Id NUMBER(20,2) NOT NULL,            --Primary Key/ FOREIGN KEY
    Reporter_Statement VARCHAR2(255),
    Reported_Medium VARCHAR2(255), --ONLINE, INPERSON, PHONE
	CONSTRAINT pk_Reporter_ID1 PRIMARY KEY (Person_Id),
    CONSTRAINT fk_Reporter_ID1 FOREIGN KEY (Person_Id) REFERENCES Person(Person_Id)
);

-- Create LINK tables --
/* These tables do not appear as entities on the model. The reason they are created
  is to allow certain types of relationships to be implemented in a Relational type Database.
*/
-- Create a link table to represent the "Crime_Offender" relationship.

CREATE TABLE Crime_Offender(
	Crime_ID NUMBER(20,2) NOT NULL,
	Offender_ID	NUMBER(20,2) NOT NULL,
    CONSTRAINT pk_CrimeOffender_ID PRIMARY KEY (Crime_ID,Offender_ID),
    CONSTRAINT fk_Crime_ID21 FOREIGN KEY (Crime_ID) REFERENCES Crime(Crime_ID),
    CONSTRAINT fk_Offender_ID23 FOREIGN KEY (Offender_ID) REFERENCES Offender(Offender_Id)
);

-- Create a link table to represent the "Event_Person" relationship.

CREATE TABLE Event_Person (
    Event_ID NUMBER(20,2) NOT NULL,
    Person_ID NUMBER(20,2) NOT NULL,
    CONSTRAINT pk_EventPerson_ID PRIMARY KEY (Event_ID, Person_ID),
    CONSTRAINT fk_Event_ID3 FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID),
    CONSTRAINT fk_Person_ID3 FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

-- Create a link table to represent the "Related_Crime" relationship.

CREATE TABLE Related_Crime (
    Crime_ID1 NUMBER(20,2) NOT NULL,
    Crime_ID2 NUMBER(20,2) NOT NULL,
    CONSTRAINT pk_Related_Crime_ID PRIMARY KEY (Crime_ID1, Crime_ID2),
    CONSTRAINT fk_Crime_ID11 FOREIGN KEY (Crime_ID1) REFERENCES Crime(Crime_ID),
    CONSTRAINT fk_Crime_ID22 FOREIGN KEY (Crime_ID2) REFERENCES Crime(Crime_ID)
);

--Insert data into Inspector Table
INSERT INTO Inspector VALUES (1, 'Prajjwal', 'Rimal');
INSERT INTO Inspector VALUES (2, 'Sahil', 'Kumar');
INSERT INTO Inspector VALUES (3, 'Rishi', 'Tamang');
INSERT INTO Inspector VALUES (4, 'Sujit', 'Rimal');
INSERT INTO Inspector VALUES (5, 'Anil', 'Aryal');
INSERT INTO Inspector VALUES (6, 'Bivek', 'Shah');


-- Insert data into Department
INSERT INTO Department VALUES (1, 'Criminal Investigation', 'Investigates serious criminal cases');
INSERT INTO Department VALUES (2, 'Forensics', 'Handles crime scene investigation and evidence analysis');
INSERT INTO Department VALUES (3, 'Patrol', 'Handles regular patrols and routine operations');
INSERT INTO Department VALUES (4, 'Special Operations', 'Handles high-risk operations and tactical units');
INSERT INTO Department VALUES (5, 'Narcotics', 'Department for drugs use');
INSERT INTO Department VALUES (6, 'Cybercrime', 'Investigates cyber-related crimes');

-- Insert data into Detective
INSERT INTO Detective VALUES (1, 'Pradyuman');
INSERT INTO Detective VALUES (2, 'Dayananda Shetty');
INSERT INTO Detective VALUES (3, 'Abmijeet Twari');
INSERT INTO Detective VALUES (4, 'Fredricks Noel');
INSERT INTO Detective VALUES (5, 'Daya Shetty');

-- Insert data into Police_Officer
INSERT INTO Police_Officer VALUES (1, 'Prajjwal', 'Shah', 1, 1);
INSERT INTO Police_Officer VALUES (2, 'Kaushal', 'Tamamng', 2, 1);
INSERT INTO Police_Officer VALUES (3, 'Sneha', 'Thapaliya', 3, 2);
INSERT INTO Police_Officer VALUES (4, 'Aazra', 'Vaidhya', 4, 3);
INSERT INTO Police_Officer VALUES (5, 'John', 'Rana', 5, 4);

-- Insert data into Offender
INSERT INTO Offender VALUES (1, 'Kancha Upadhya', 'Multiple robbery cases', '05-15-1990');
INSERT INTO Offender VALUES (2, 'Reecha Basnet', 'Financial fraud', '10-10-1975');
INSERT INTO Offender VALUES (3, 'Rasha Gandhi', 'Cybersecurity breach', '01-01-1985');
INSERT INTO Offender VALUES (4, 'Rajesh Jha', 'Drug Abuse', '05-21-1992');
INSERT INTO Offender VALUES (5, 'Dinu Acharya', 'Engaged in Fight', '09-17-1995');

-- Insert data into Offense
INSERT INTO Offense VALUES (1, '08-19-2024', 'Drug Dealing', 'Selling illegal drugs');
INSERT INTO Offense VALUES (2, '06-15-2024', 'Disturbance', 'Public Disturbance');
INSERT INTO Offense VALUES (3, '08-19-2024', 'Fraud','Financial scam');
INSERT INTO Offense VALUES (4, '01-25-2024', 'Robbery','Robbery at the bank');
INSERT INTO Offense VALUES (5, '05-11-2024', 'Burglary', 'Burglary of a private residence');

-- Insert data into Locations
INSERT INTO Locations VALUES (1, 'Kathmandu', 'Bagmati');
INSERT INTO Locations VALUES (2, 'Lalitpur', 'Bagmati');
INSERT INTO Locations VALUES (3, 'Pokhara', 'Gandaki');
INSERT INTO Locations VALUES (4, 'Bhaktapur', 'Bagmati');

-- Insert data into Person
INSERT INTO Person VALUES (1, 'Shirisha Sapkota', 25, 'Female', 9876543267, 'Witness');
INSERT INTO Person VALUES (2, 'Dennis Tamang', 40, 'Male', 9876543210, 'Reporter');
INSERT INTO Person VALUES (3, 'Karma Basnet', 30, 'Female', 9812563547, 'Victim');
INSERT INTO Person VALUES (4, 'Ram Karki', 55, 'Male', 0145672897, 'Witness');
INSERT INTO Person VALUES (5, 'Shristi Thapa', 25, 'Male', 9713387654, 'Witness');
INSERT INTO Person VALUES (6, 'Olivia Jones', 38, 'Female', 9813276876, 'Reporter');
INSERT INTO Person VALUES (7, 'Chloe Adams', 60, 'Female', 9861270956, 'Witness');
INSERT INTO Person VALUES (8, 'David Bechkham', 40, 'Male', 1122334455, 'Reporter');
INSERT INTO Person VALUES (9, 'Sophie Hall', 30, 'Female', 5566778899, 'Witness');
INSERT INTO Person VALUES (10,'Harry Brown', 35, 'Male', 9861236787, 'Victim');
INSERT INTO Person VALUES (11, 'Riva Thapa', 20, 'Female', 9815678899, 'Victim');


-- Insert data into Crime
INSERT INTO Crime VALUES (1, '08-19-2024', 'Primary', 'High', 'Open', NULL, 1, 1, 1, 1);
INSERT INTO Crime VALUES (2, '01-25-2024', 'Secondary', 'Medium', 'Closed', '08-01-2024', 2, 2, 2, 4);
INSERT INTO Crime VALUES (3, '05-25-2024', 'Secondary', 'Low', 'Closed', '09-10-2024', 1, 3, 2, 2);
INSERT INTO Crime VALUES (4, '08-19-2024', 'Primary', 'High', 'Open', NULL, 3, 2, 1, 3);
INSERT INTO Crime VALUES (5, '01-10-2024', 'Primary', 'High', 'Closed', '07-10-2024', 3, 2, 1, 3);
INSERT INTO Crime VALUES (6, '09-14-2024', 'Primary', 'High', 'Open',NULL, 3, 2, 1, 3);

-- Insert data into Primary_Crime
INSERT INTO Primary_Crime VALUES (1, 'Robbery', 2, 'Robbery With Knife');
INSERT INTO Primary_Crime VALUES (4, 'Hacking', 4, 'Cyber attack on corporate systems');


-- Insert data into Secondary_Crime
INSERT INTO Secondary_Crime VALUES (2, 'Public disturbance', '1 week jail', 'fine');
INSERT INTO Secondary_Crime VALUES (3, 'Bribery', '5 years in prison', 'Offering or accepting bribes');

-- Insert data into Event
INSERT INTO Event VALUES (1, '08-19-2024', 'Theft at home', 1);
INSERT INTO Event VALUES (2, '05-25-2024', 'Money Laundering',3);

-- Insert data into Evidence
INSERT INTO Evidence VALUES (1, 'CCTV Footage', 'Footage of the suspect', 1);
INSERT INTO Evidence VALUES (2, 'Fingerprint', 'Lifted from the crime scene', 2);
INSERT INTO Evidence VALUES (5, 'Hacked Data', 'Extracted during cyberattack', 5);

-- Insert data into Suspect
INSERT INTO Suspect VALUES (1, 'Nissim Bishwokarma', 1);
INSERT INTO Suspect VALUES (2, 'David Harris', 3);

-- Insert data into Victim
INSERT INTO Victim VALUES (3, 'Injured', 'Injured during the robbery');
INSERT INTO Victim VALUES (10, 'Stable', 'I was not in good mental state');

-- Insert data into Witness
INSERT INTO Witness VALUES (1, 'Saw the suspect', 'In Contact', 'Yes');
INSERT INTO Witness VALUES (4, 'I saw a vehicle flee the area', 'In Contact', 'Yes');
INSERT INTO Witness VALUES (5, 'Nothing to say', 'In Contact', 'No');
INSERT INTO Witness VALUES (7, 'saw someone breaking in', 'In Contact', 'Yes');
INSERT INTO Witness VALUES (9, 'Nothing to say', 'Out of Contact', 'No');

-- Insert data into Reporter
INSERT INTO Reporter VALUES (2, 'Reported the disturbance', 'Phone');
INSERT INTO Reporter VALUES (6, 'Reported the crime', 'Inperson');

-- Insert data into Crime_Offender
INSERT INTO Crime_Offender VALUES (1, 2);
INSERT INTO Crime_Offender VALUES (2, 3);
INSERT INTO Crime_Offender VALUES (3, 4);

-- Insert data into Event_Person
INSERT INTO Event_Person VALUES (1, 2);
INSERT INTO Event_Person VALUES (2, 3);

-- Insert data into Related_Crime
INSERT INTO Related_Crime VALUES (1, 2);
INSERT INTO Related_Crime VALUES (3, 4);

--Implementation
--1
SELECT DISTINCT O.Officer_First_Name, O.Officer_Last_Name, C.Crime_ID, C.Reported_Date, C.Crime_Type, O.Officer_ID
FROM Crime C
JOIN Police_Officer O ON C.Officer_ID = O.Officer_ID
WHERE C.Offense_ID IN (
    SELECT Offense_ID
    FROM Crime
    WHERE Reported_Date = ('08-19-2024')
);

--2
SELECT 
    RC.Crime_ID1 AS Related_From, 
    RC.Crime_ID2 AS Related_To, 
    C1.Reported_Date AS From_Date, 
    C2.Reported_Date AS To_Date, 
    C1.Crime_Type AS From_Type, 
    C2.Crime_Type AS To_Type
FROM Related_Crime RC
JOIN Crime C1 ON RC.Crime_ID1 = C1.Crime_ID
JOIN Crime C2 ON RC.Crime_ID2 = C2.Crime_ID;

--3
SELECT C.Crime_ID, C.Reported_Date, C.Crime_Type, C.Status, 
       O.Officer_First_Name, O.Officer_Last_Name, O.Officer_ID
FROM Crime C
JOIN Police_Officer O ON C.Officer_ID = O.Officer_ID
WHERE C.Reported_Date = (SELECT MAX(Reported_Date) FROM Crime);

--4
SELECT SC.Crime_Name, O.Officer_First_Name, O.Officer_Last_Name, SC.Crime_ID
FROM Secondary_Crime SC
JOIN Crime C ON SC.Crime_ID = C.Crime_ID
JOIN Police_Officer O ON C.Officer_ID = O.Officer_ID;

--5
SELECT D.Department_Name, D.Department_ID, PC.Crime_Name, PC.Crime_Detail
FROM Department D
JOIN Police_Officer O ON D.Department_ID = O.Department_ID
JOIN Crime C ON O.Officer_ID = C.Officer_ID
JOIN Primary_Crime PC ON C.Crime_ID = PC.Crime_ID
WHERE C.Crime_Type = 'Primary'
GROUP BY D.Department_Name, D.Department_ID, PC.Crime_Name, PC.Crime_Detail
HAVING COUNT(PC.Crime_ID) < 2;

--6
SELECT C.Crime_ID, C.Reported_Date, C.Crime_Type, C.Status, 
       W.Person_ID, P.Person_Name, P.Gender, COUNT(W.Person_ID) AS Witness_Count
FROM Crime C
JOIN Event E ON C.Crime_ID = E.Crime_ID
JOIN Event_Person EP ON E.Event_ID = EP.Event_ID
JOIN Witness W ON EP.Person_ID = W.Person_ID
JOIN Person P ON W.Person_ID = P.Person_ID
WHERE C.Status = 'Open'
GROUP BY C.Crime_ID, C.Reported_Date, C.Crime_Type, C.Status, 
         W.Person_ID, P.Person_Name, P.Gender
HAVING COUNT(W.Person_ID) > 5;