create table hoang;
use hoang;

--creat table: department
CREATE TABLE department (
    departmentid INT,
    departmentname VARCHAR(50)
);
CREATE TABLE position (
    position_id INT,
    position_name VARCHAR(50)
);
CREATE TABLE account_id (
    QuestionID INT,
    email VARCHAR(100),
    username VARCHAR(100),
    fullname VARCHAR(100),
    department_id INT,
    position_id INT,
    creatdate DATE
);
CREATE TABLE groupH (
    group_id INT,
    group_name VARCHAR(50),
    creator_id INT,
    creatdate DATE
);
CREATE TABLE GroupAccount (
    Group_id INT,
    Account_id INT,
    Joindate DATE
);
CREATE TABLE TypeQuestion (
    Type_id INT,
    TypeName VARCHAR(50)
);
CREATE TABLE CategoryQuestion (
    CategoryID INT,
    CategoryName VARBINARY(50)
);
CREATE TABLE Question (
    QuestionID INT,
    Content VARCHAR(50),
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE
);
CREATE TABLE Exam (
    ExamID INT,
    Codes INT,
    Title VARCHAR(50),
    CategoryID INT,
    Duration TIME,
    CreatorID INT,
    CreateDate DATE
);
CREATE TABLE ExamQuestion (
    ExamID INT,
    QuestionID INT
);
