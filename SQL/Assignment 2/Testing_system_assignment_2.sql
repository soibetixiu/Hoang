DROP DATABASE IF EXISTS testing_system_assignment_2;
CREATE DATABASE testing_system_assignment_2;
USE testing_system_assignment_2;

DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
    DepartmentID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
    PositionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    AccountID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Fullname VARCHAR(100) NOT NULL,
    DepartmentID INT UNSIGNED NOT NULL,
    PositionID INT UNSIGNED NOT NULL,
    Createdate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(50) NOT NULL UNIQUE,
    CreatorID INT UNSIGNED,
    Createdate DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount` (
    GroupID INT UNSIGNED NOT NULL,
    AccountID INT UNSIGNED NOT NULL,
    Joindate DATE,
    FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account` (AccountID),
    PRIMARY KEY (GroupID , AccountID)
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion` (
    TypeID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion` (
    CategoryID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question` (
    QuestionID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content VARCHAR(50) NOT NULL,
    CategoryID INT UNSIGNED NOT NULL,
    TypeID INT UNSIGNED NOT NULL,
    CreatorID INT UNSIGNED NOT NULL,
    CreateDate DATE,
	FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion` (CategoryID),
    FOREIGN KEY (TypeID) REFERENCES `TypeQuestion` (TypeID),
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`testing_system_assignment_2`.`question`, CONSTRAINT `question_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categoryquestion` (`CategoryID`))


DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer` (
    AnswerID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content VARCHAR(100) NOT NULL,
    QuestionID INT UNSIGNED NOT NULL,
    isCorrect BIT DEFAULT 1,
    FOREIGN KEY (QuestionID) REFERENCES `Question` (QuestionID)
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam` (
    ExamID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code` VARCHAR(50) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    CategoryID INT UNSIGNED NOT NULL,
    Duration INT UNSIGNED NOT NULL,
    CreatorID INT UNSIGNED NOT NULL,
    CreateDate DATE,
	FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion` (CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion` (
    ExamID INT UNSIGNED NOT NULL,
    QuestionID INT UNSIGNED NOT NULL,
	FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID),
    FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    PRIMARY KEY (ExamID , QuestionID)
);

INSERT INTO `Department`(DepartmentName)
VALUES
(N'Marketing' ),
(N'Sale' ),
(N'Bảo vệ' ),
(N'Nhân sự' ),
(N'Kỹ thuật' );

INSERT INTO `Position` (PositionName )
VALUES 
('Dev' ),
('Test' ),
('Scrum Master'),
('PM' );

INSERT INTO `Account` (Email, Username, FullName, DepartmentID, PositionID, CreateDate)
VALUES 
('Email1@gmail.com','Username1','Fullname1','5','1','2020-03-05'),

('Email2@gmail.com','Username2','Fullname2','1','2','2020-03-05'),

('Email3@gmail.com','Username3','Fullname3','2','2','2020-03-07'),

('Email4@gmail.com','Username4','Fullname4', '3','4','2020-03-08'),

('Email5@gmail.com','Username5','Fullname5','4','4','2020-03-10');

INSERT INTO `Group` (GroupName, CreatorID, CreateDate)
VALUES
(N'Testing System',5,'2019-03-05'),
(N'Development',1,'2020-03-07'),
(N'VTI Sale 01',2,'2020-03-09'),
(N'VTI Sale 02',3,'2020-03-10'),
(N'VTI Sale 03',4,'2020-03-28');

INSERT INTO `GroupAccount` (GroupID ,AccountID ,JoinDate )
VALUES
(1, 1,'2019-03-05'),

(1,2,'2020-03-07'),

(3,3,'2020-03-09'),

(3,4,'2020-03-10'),

(5,5,'2020-03-28');

INSERT INTO `TypeQuestion` (TypeName)
VALUES 
('Essay' ),
('Multiple-Choice' );

INSERT INTO `CategoryQuestion` (CategoryName )
VALUES 
('Java'),
('ASP.NET'),
('ADO.NET'),
('SQL'),
('Postman');

INSERT INTO `Question` (Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES
('Câu hỏi về Java','1','1','2','2020-04-05'),

('Câu Hỏi về PHP','1','2','2','2020-04-05'),

('Hỏi về C#','1','2','3','2020-04-06'),

('Hỏi về Ruby','1','1','4','2020-04-06'),

('Hỏi về Postman','5','1','5','2020-04-06');

INSERT INTO `Answer` ( Content,QuestionID,isCorrect)
VALUES
('Trả lời 01' , 1 , 0),
('Trả lời 02' , 1 , 1),
('Trả lời 03', 1 , 0 ),
('Trả lời 04', 1 , 1 ),
('Trả lời 05', 2 , 1 );

INSERT INTO `Exam` (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES
('VTIQ001' , 'Đề thi C#' ,1 , 60 , '5' ,'2019-04-05'),
('VTIQ002' , 'Đề thi PHP' ,2 , 60 , '2' ,'2019-04-05'),
('VTIQ003' , 'Đề thi C++' , 3 ,120 , '2' ,'2019-04-07'),
('VTIQ004' , 'Đề thi Java' , 4 , 60, '3' ,'2020-04-08'),
('VTIQ005' , 'Đề thi Ruby' , 5 , 120, '4' ,'2020-04-10');

INSERT INTO `ExamQuestion` (ExamID, QuestionID)
VALUES 
( 1 , 5 ),
( 2 , 3 ),
( 3 , 2 ),
( 4 , 3 ),
( 5 , 4 );







