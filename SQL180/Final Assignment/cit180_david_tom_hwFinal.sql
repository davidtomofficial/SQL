-- David Tom
-- CIT 180 Database Concepts & SQL
-- Assignment HW Final
-- December 10, 2023
-------------------------------------------------------------------------------
-- SQL Server
-- Run only in a disposable coursework database: the setup drops and recreates
-- the seven sample tables and views. Use a client that recognizes GO batches.

-- Question 1:
-- f) Define the library schema
-- g) Insert fictional sample data
-- h) Display table contents
-- i) Create and display views
-------------------------------------------------------------------------------

-- Question 1:
-- f) Define the library schema

-- Drop views before the tables they reference. IF EXISTS supports first runs.
DROP VIEW IF EXISTS View_Genre;
DROP VIEW IF EXISTS View_Book;
DROP VIEW IF EXISTS View_Member;
DROP VIEW IF EXISTS View_Staff;
DROP VIEW IF EXISTS View_Event;
DROP VIEW IF EXISTS View_Loan;
DROP VIEW IF EXISTS View_MemberEvent;

-- Dropping tables if they already exist
DROP TABLE IF EXISTS MemberEvent;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Genre;
GO

-- Creating Genre Table
CREATE TABLE Genre (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(100),
    Description TEXT
);

-- Creating Book Table
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    ISBN VARCHAR(17),
    GenreID INT,
    PubYear INT,
    Status VARCHAR(50),
    Description TEXT,
    ShelfLocation VARCHAR(100),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);

-- Creating Member Table
CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(255),
    ContactInfo VARCHAR(255),
    StartDate DATE,
    MembershipType VARCHAR(100)
);

-- Creating Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(100),
    ContactInfo VARCHAR(255),
    SupervisorID INT,
    FOREIGN KEY (SupervisorID) REFERENCES Staff(StaffID)
);

-- Creating Event Table
CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(255),
    Description TEXT,
    OrganizerID INT,
    EventDateTime DATETIME,
    EventLocation VARCHAR(255),
    MaxParticipants INT,
    FOREIGN KEY (OrganizerID) REFERENCES Staff(StaffID)
);

-- Creating Loan Table
CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    LateFee DECIMAL(10, 2),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

-- Creating MemberEvent Junction Table
CREATE TABLE MemberEvent (
    MemberEventID INT PRIMARY KEY,
    MemberID INT,
    EventID INT,
    RegistrationDate DATE,
    AttendanceStatus VARCHAR(50),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Question 1:
-- g) Insert fictional sample data

-- Inserting data into Genre Table
INSERT INTO Genre (GenreID, GenreName, Description) VALUES
(1, 'Fiction', 'Fictional works of literature'),
(2, 'Non-Fiction', 'Informative and factual texts'),
(3, 'Science Fiction', 'Sci-fi and futuristic themes'),
(4, 'Fantasy', 'Fantastical and mythical narratives');

-- Inserting data into Book Table
INSERT INTO Book (BookID, Title, Author, ISBN, GenreID, PubYear, Status, Description, ShelfLocation) VALUES
(1, 'Lorem', 'consectetur adipiscing', '123-4567890123', 1, 2020, 'Available', 'quis nostrud exercitation', 'A1'),
(2, 'Ipsum', ' elit, sed ', '123-4567890124', 2, 2019, 'Borrowed', 'Ut enim ad minim veniam,', 'B2'),
(3, 'Dolor', 'do eiusmod tempor', '123-4567890125', 3, 2018, 'Reserved', 'labore et dolore magna aliqua.', 'C3'),
(4, 'Sit Amet', 'incididunt ut', '123-4567890126', 4, 2017, 'Available', 'Lorem ipsum dolor sit amet', 'D4');

-- Inserting data into Member Table
INSERT INTO Member (MemberID, Name, ContactInfo, StartDate, MembershipType) VALUES
(1, 'John Doe', 'john.doe@email.com', '2021-01-10', 'Adult'),
(2, 'Jane Smith', 'jane.smith@email.com', '2020-06-15', 'Student'),
(3, 'Alice Johnson', 'alice.johnson@email.com', '2021-03-22', 'Senior'),
(4, 'Bob Brown', 'bob.brown@email.com', '2019-09-05', 'Young Adult');

-- Inserting data into Staff Table
INSERT INTO Staff (StaffID, Name, Role, ContactInfo, SupervisorID) VALUES
(1, 'Emily White', 'Librarian', 'emily.white@email.com', NULL),
(2, 'Daniel Green', 'Event Organizer', 'daniel.green@email.com', 1),
(3, 'Sophia Black', 'Assistant Librarian', 'sophia.black@email.com', 1),
(4, 'Michael Grey', 'Library Manager', 'michael.grey@email.com', NULL);

-- Inserting data into Event Table
INSERT INTO Event (EventID, EventName, Description, OrganizerID, EventDateTime, EventLocation, MaxParticipants) VALUES 
(1, 'Book Club Meeting', 'Monthly book club gathering', 2, '2022-07-15 18:00:00', 'Room A', 20), 
(2, 'Author Talk', 'Discussion with a local author', 2, '2022-08-10 17:00:00', 'Main Hall', 50), 
(3, 'Poetry Reading', 'Evening of poetry reading', 3, '2022-09-05 19:00:00', 'Room B', 15), 
(4, 'Story Time for Kids', 'Storytelling session for children', 3, '2022-07-20 10:00:00', 'Children''s Section', 25);

-- Inserting data into Loan Table
INSERT INTO Loan (LoanID, BookID, MemberID, LoanDate, DueDate, ReturnDate, LateFee) VALUES
(1, 1, 1, '2022-07-01', '2022-07-15', NULL, 0.00),
(2, 2, 2, '2022-06-20', '2022-07-04', '2022-07-05', 1.50),
(3, 3, 3, '2022-07-10', '2022-07-24', NULL, 0.00),
(4, 4, 4, '2022-07-05', '2022-07-19', NULL, 0.00);


-- Inserting data into MemberEvent Table
INSERT INTO MemberEvent (MemberEventID, MemberID, EventID, RegistrationDate, AttendanceStatus) VALUES
(1, 1, 1, '2022-07-10', 'Attended'),
(2, 2, 1, '2022-07-11', 'Missed'),
(3, 3, 2, '2022-08-05', 'Attended'),
(4, 4, 2, '2022-08-06', 'Attended'),
(5, 1, 3, '2022-08-30', 'Missed'),
(6, 2, 3, '2022-08-31', 'Attended'),
(7, 3, 4, '2022-07-15', 'Attended'),
(8, 4, 4, '2022-07-16', 'Missed');

-- Question 1:
-- h) Display table contents

-- Displaying contents of each table
SELECT * FROM Genre;
SELECT * FROM Book;
SELECT * FROM Member;
SELECT * FROM Staff;
SELECT * FROM Event;
SELECT * FROM Loan;
SELECT * FROM MemberEvent;

-- Question 1:
-- i) Create and display views

-- Each CREATE VIEW must begin its own SQL Server batch.
GO
CREATE VIEW View_Genre AS SELECT * FROM Genre;
GO
CREATE VIEW View_Book AS SELECT * FROM Book;
GO
CREATE VIEW View_Member AS SELECT * FROM Member;
GO
CREATE VIEW View_Staff AS SELECT * FROM Staff;
GO
CREATE VIEW View_Event AS SELECT * FROM Event;
GO
CREATE VIEW View_Loan AS SELECT * FROM Loan;
GO
CREATE VIEW View_MemberEvent AS SELECT * FROM MemberEvent;
GO

-- Showing the data in the views
SELECT * FROM View_Genre;
SELECT * FROM View_Book;
SELECT * FROM View_Member;
SELECT * FROM View_Staff;
SELECT * FROM View_Event;
SELECT * FROM View_Loan;
SELECT * FROM View_MemberEvent;

-- Example outputs from successful run
-- Note: copy issues may affect the column formats

-- SELECT * FROM View_Genre
-- GenreID	GenreName	Description
-- 1	Fiction	Fictional works of literature
-- 2	Non-Fiction	Informative and factual texts
-- 3	Science Fiction	Sci-fi and futuristic themes
-- 4	Fantasy	Fantastical and mythical narratives


-- SELECT * FROM View_Book
-- BookID	Title	Author	ISBN	GenreID	PubYear	Status	Description	ShelfLocation
-- 1	Lorem	consectetur adipiscing	123-4567890123	1	2020	Available	quis nostrud exercitation	A1
-- 2	Ipsum	elit, sed	123-4567890124	2	2019	Borrowed	Ut enim ad minim veniam,	B2
-- 3	Dolor	do eiusmod tempor	123-4567890125	3	2018	Reserved	labore et dolore magna aliqua.	C3
-- 4	Sit Amet	incididunt ut	123-4567890126	4	2017	Available	Lorem ipsum dolor sit amet	D4


-- SELECT * FROM View_Member
-- MemberID	Name	ContactInfo	StartDate	MembershipType
-- 1	John Doe	john.doe@email.com	2021-01-10	Adult
-- 2	Jane Smith	jane.smith@email.com	2020-06-15	Student
-- 3	Alice Johnson	alice.johnson@email.com	2021-03-22	Senior
-- 4	Bob Brown	bob.brown@email.com	2019-09-05	Young Adult


-- SELECT * FROM View_Staff
-- StaffID	Name	Role	ContactInfo	SupervisorID
-- 1	Emily White	Librarian	emily.white@email.com	
-- 2	Daniel Green	Event Organizer	daniel.green@email.com	1
-- 3	Sophia Black	Assistant Librarian	sophia.black@email.com	1
-- 4	Michael Grey	Library Manager	michael.grey@email.com	


-- SELECT * FROM View_Event
-- EventID	EventName	Description	OrganizerID	EventDateTime	EventLocation	MaxParticipants
-- 1	Book Club Meeting	Monthly book club gathering	2	7/15/2022 6:00:00 PM	Room A	20
-- 2	Author Talk	Discussion with a local author	2	8/10/2022 5:00:00 PM	Main Hall	50
-- 3	Poetry Reading	Evening of poetry reading	3	9/5/2022 7:00:00 PM	Room B	15
-- 4	Story Time for Kids	Storytelling session for children	3	7/20/2022 10:00:00 AM	Children's Section	25


-- SELECT * FROM View_Loan
-- LoanID	BookID	MemberID	LoanDate	DueDate	ReturnDate	LateFee
-- 1	1	1	2022-07-01	2022-07-15		0.00
-- 2	2	2	2022-06-20	2022-07-04	2022-07-05	1.50
-- 3	3	3	2022-07-10	2022-07-24		0.00
-- 4	4	4	2022-07-05	2022-07-19		0.00


-- SELECT * FROM View_MemberEvent
-- MemberEventID	MemberID	EventID	RegistrationDate	AttendanceStatus
-- 1	1	1	2022-07-10	Attended
-- 2	2	1	2022-07-11	Missed
-- 3	3	2	2022-08-05	Attended
-- 4	4	2	2022-08-06	Attended
-- 5	1	3	2022-08-30	Missed
-- 6	2	3	2022-08-31	Attended
-- 7	3	4	2022-07-15	Attended
-- 8	4	4	2022-07-16	Missed
