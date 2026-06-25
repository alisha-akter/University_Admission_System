DROP DATABASE IF EXISTS university_admission;

CREATE DATABASE university_admission;
USE university_admission;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Class_Info;
DROP TABLE IF EXISTS Hall;
DROP TABLE IF EXISTS Admission;
DROP TABLE IF EXISTS Subject_Choice;
DROP TABLE IF EXISTS Result;
DROP TABLE IF EXISTS Academic_details;
DROP TABLE IF EXISTS Admit_Card;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Applicant;
DROP TABLE IF EXISTS Guardians_Info;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE IF NOT EXISTS Guardians_Info (
    GuardianID INT AUTO_INCREMENT PRIMARY KEY,
    Fathers_name VARCHAR(50) NOT NULL,
    Mothers_name VARCHAR(50) NOT NULL,
    Fathers_mobileno VARCHAR(15) NOT NULL,
    Mothers_mobileno VARCHAR(15) NOT NULL,
    Fathers_occupation VARCHAR(50),
    Mothers_occupation VARCHAR(50),
    Income DECIMAL(10,2) CHECK (Income >= 0),
    Guardian_name VARCHAR(50),
    Guardian_mobileno VARCHAR(15),
    Guardian_address VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Applicant (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    GuardianID INT,
    Reg_no VARCHAR(20) UNIQUE,
    Name VARCHAR(50) NOT NULL,
    Date_of_birth DATE,
    Mobile_no VARCHAR(15) UNIQUE,
    Email VARCHAR(50) UNIQUE,
    Religion VARCHAR(30),
    Nationality VARCHAR(30),
    Marital_Status ENUM('Unmarried','Married'),
    Blood_group ENUM('A+','A-','B+','B-','O+','O-','AB+','AB-'),
    Present_address VARCHAR(100),
    Permanent_address VARCHAR(100),
    Image LONGBLOB,
    Signature LONGBLOB,
    FOREIGN KEY (GuardianID) REFERENCES Guardians_Info(GuardianID)
);

CREATE TABLE IF NOT EXISTS Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    Payment_method ENUM('Bkash','Nagad','Rocket'),
    Payment_date DATE,
    TransactionID VARCHAR(30) UNIQUE,
    Status ENUM('Pending','Completed','Failed'),
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID)
);

CREATE TABLE IF NOT EXISTS Admit_Card (
    Exam_roll INT PRIMARY KEY,
    GuardianID INT,
    Exam_date DATE,
    Exam_center VARCHAR(50),
    Shift VARCHAR(50),
    Room_no VARCHAR(10),
    Unit VARCHAR(10),
    Language ENUM('English','Bangla'),
    FOREIGN KEY (GuardianID) REFERENCES Guardians_Info(GuardianID)
);

CREATE TABLE IF NOT EXISTS Academic_details (
    Reg_no VARCHAR(20) PRIMARY KEY,
    StudentID INT,
    SSC_roll INT,
    SSC_yearofpassing YEAR,
    SSC_result DECIMAL(3,2) CHECK (SSC_result BETWEEN 1.00 AND 5.00),
    SSC_institution VARCHAR(100),
    HSC_roll INT,
    HSC_yearofpassing YEAR,
    HSC_result DECIMAL(3,2) CHECK (HSC_result BETWEEN 1.00 AND 5.00),
    HSC_institution VARCHAR(100),
    HSC_Group ENUM('Science','Commerce','Arts'),
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID)
);

CREATE TABLE IF NOT EXISTS Result (
    ResultID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    Exam_roll INT,
    SSC_marks INT CHECK (SSC_marks >= 0),
    HSC_marks INT CHECK (HSC_marks >= 0),
    Total_score INT CHECK (Total_score >= 0),
    Merit_pos INT,
    Result_date DATE,
    Status ENUM('Pass','Fail'),
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID),
    FOREIGN KEY (Exam_roll) REFERENCES Admit_Card(Exam_roll)
);

CREATE TABLE IF NOT EXISTS Subject_Choice (
    Subject_choiceID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    GuardianID INT,
    Exam_roll INT,
    ResultID INT,
    Reg_no VARCHAR(20),
    Subject_list VARCHAR(100),
    Obtained_sub VARCHAR(100),
    Pending_sub VARCHAR(100),
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID),
    FOREIGN KEY (GuardianID) REFERENCES Guardians_Info(GuardianID),
    FOREIGN KEY (Exam_roll) REFERENCES Admit_Card(Exam_roll),
    FOREIGN KEY (ResultID) REFERENCES Result(ResultID)
);

CREATE TABLE IF NOT EXISTS Admission (
    AdmissionID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    GuardianID INT,
    Exam_roll INT,
    ResultID INT,
    Department VARCHAR(50),
    Amount DECIMAL(10,2),
    Session VARCHAR(20),
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID),
    FOREIGN KEY (GuardianID) REFERENCES Guardians_Info(GuardianID),
    FOREIGN KEY (Exam_roll) REFERENCES Admit_Card(Exam_roll),
    FOREIGN KEY (ResultID) REFERENCES Result(ResultID)
);

CREATE TABLE IF NOT EXISTS Hall (
    HallID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    Reg_no VARCHAR(20),
    AdmissionID INT,
    Hall_name VARCHAR(50),
    Room_no VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID),
    FOREIGN KEY (Reg_no) REFERENCES Academic_details(Reg_no),
    FOREIGN KEY (AdmissionID) REFERENCES Admission(AdmissionID)
);

CREATE TABLE IF NOT EXISTS Class_Info (
    Edu_mail VARCHAR(50) PRIMARY KEY,
    StudentID INT,
    ResultID INT,
    Roll INT UNIQUE,
    AdmissionID INT,
    FOREIGN KEY (StudentID) REFERENCES Applicant(StudentID),
    FOREIGN KEY (ResultID) REFERENCES Result(ResultID),
    FOREIGN KEY (AdmissionID) REFERENCES Admission(AdmissionID)
);


INSERT INTO Guardians_Info 
(Fathers_name, Mothers_name, Fathers_mobileno, Mothers_mobileno, Fathers_occupation, Mothers_occupation, Income, Guardian_name, Guardian_mobileno, Guardian_address)
VALUES
('Rahim Uddin','Ayesha Begum','01711111111','01811111111','Business','Housewife',50000,'Rahim Uddin','01711111111','Dhaka'),
('Karim Hossain','Fatema Begum','01722222222','01822222222','Teacher','Housewife',40000,'Karim Hossain','01722222222','Chittagong'),
('Salam Mia','Rokeya Begum','01733333333','01833333333','Farmer','Housewife',30000,'Salam Mia','01733333333','Rajshahi'),
('Jamal Uddin','Shirin Akter','01744444444','01844444444','Doctor','Housewife',80000,'Jamal Uddin','01744444444','Sylhet'),
('Habib Ullah','Nazma Khatun','01755555555','01855555555','Engineer','Teacher',70000,'Habib Ullah','01755555555','Khulna'),
('Rashid Ali','Parveen Akter','01766666666','01866666666','Lawyer','Housewife',60000,'Rashid Ali','01766666666','Barisal'),
('Saidur Rahman','Nurjahan Begum','01777777777','01877777777','Shopkeeper','Housewife',25000,'Saidur Rahman','01777777777','Rangpur'),
('Imran Hossain','Shahnaz Akter','01788888888','01888888888','Govt. Service','Housewife',55000,'Imran Hossain','01788888888','Comilla'),
('Bashir Uddin','Rubi Begum','01799999999','01899999999','Business','Housewife',65000,'Bashir Uddin','01799999999','Jessore'),
('Azizur Rahman','Hosne Ara','01710101010','01810101010','Banker','Housewife',75000,'Azizur Rahman','01710101010','Mymensingh');

INSERT INTO Applicant (GuardianID, Reg_no, Name, Date_of_birth, Mobile_no, Email, Religion, Nationality, Marital_Status, Blood_group, Present_address, Permanent_address)
VALUES
(1,'1001','Abdullah','2002-05-10','01611111111','abdullah@mail.com','Islam','Bangladeshi','Unmarried','A+','Dhaka','Dhaka'),
(2,'1002','Mariam','2001-03-14','01622222222','mariam@mail.com','Islam','Bangladeshi','Unmarried','B+','Chittagong','Chittagong'),
(3,'1003','Nusrat','2003-01-20','01633333333','nusrat@mail.com','Islam','Bangladeshi','Unmarried','O+','Rajshahi','Rajshahi'),
(4,'1004','Hasan','2002-07-18','01644444444','hasan@mail.com','Islam','Bangladeshi','Unmarried','AB+','Sylhet','Sylhet'),
(5,'1005','Tania','2001-09-11','01655555555','tania@mail.com','Islam','Bangladeshi','Unmarried','A-','Khulna','Khulna'),
(6,'1006','Sabbir','2002-06-25','01666666666','sabbir@mail.com','Islam','Bangladeshi','Unmarried','B-','Barisal','Barisal'),
(7,'1007','Farhana','2003-04-30','01677777777','farhana@mail.com','Islam','Bangladeshi','Unmarried','O-','Rangpur','Rangpur'),
(8,'1008','Rakib','2001-08-22','01688888888','rakib@mail.com','Islam','Bangladeshi','Unmarried','AB-','Comilla','Comilla'),
(9,'1009','Sadia','2002-12-05','01699999999','sadia@mail.com','Islam','Bangladeshi','Unmarried','A+','Jessore','Jessore'),
(10,'1010','Mahmud','2001-11-17','01610101010','mahmud@mail.com','Islam','Bangladeshi','Unmarried','B+','Mymensingh','Mymensingh');

INSERT INTO Academic_details (Reg_no, StudentID, SSC_roll, SSC_yearofpassing, SSC_result, SSC_institution, HSC_roll, HSC_yearofpassing, HSC_result, HSC_institution, HSC_Group)
VALUES
('1001',1,20011,2018,4.80,'Dhaka School',30011,2020,4.90,'Dhaka College','Science'),
('1002',2,20012,2018,4.50,'Chittagong School',30012,2020,4.70,'Chittagong College','Science'),
('1003',3,20013,2019,4.60,'Rajshahi School',30013,2021,4.80,'Rajshahi College','Science'),
('1004',4,20014,2018,5.00,'Sylhet School',30014,2020,5.00,'Sylhet College','Science'),
('1005',5,20015,2019,4.70,'Khulna School',30015,2021,4.60,'Khulna College','Science'),
('1006',6,20016,2018,4.90,'Barisal School',30016,2020,4.95,'Barisal College','Science'),
('1007',7,20017,2019,4.40,'Rangpur School',30017,2021,4.70,'Rangpur College','Science'),
('1008',8,20018,2018,4.85,'Comilla School',30018,2020,4.95,'Comilla College','Science'),
('1009',9,20019,2019,4.75,'Jessore School',30019,2021,4.65,'Jessore College','Science'),
('1010',10,20020,2018,4.60,'Mymensingh School',30020,2020,4.80,'Mymensingh College','Science');

INSERT INTO Payment (StudentID, Amount, Payment_method, Payment_date, TransactionID, Status)
VALUES
(1,6000.00,'Bkash','2022-06-01','TXN001','Completed'),
(2,6000.00,'Nagad','2022-06-02','TXN002','Completed'),
(3,6000.00,'Rocket','2022-06-03','TXN003','Completed'),
(4,6000.00,'Bkash','2022-06-04','TXN004','Completed'),
(5,6000.00,'Nagad','2022-06-05','TXN005','Completed'),
(6,6000.00,'Rocket','2022-06-06','TXN006','Completed'),
(7,6000.00,'Bkash','2022-06-07','TXN007','Completed'),
(8,6000.00,'Nagad','2022-06-08','TXN008','Completed'),
(9,6000.00,'Rocket','2022-06-09','TXN009','Completed'),
(10,6000.00,'Bkash','2022-06-10','TXN010','Completed');

INSERT INTO Admit_Card (Exam_roll, GuardianID, Exam_date, Exam_center, Shift, Room_no, Unit, Language)
VALUES
(5001,1,'2022-07-01','Dhaka College','Morning','101','A','English'),
(5002,2,'2022-07-01','Chittagong College','Morning','102','A','Bangla'),
(5003,3,'2022-07-01','Rajshahi College','Afternoon','103','B','English'),
(5004,4,'2022-07-01','Sylhet College','Morning','104','B','Bangla'),
(5005,5,'2022-07-01','Khulna College','Afternoon','105','C','English'),
(5006,6,'2022-07-01','Barisal College','Morning','106','C','Bangla'),
(5007,7,'2022-07-01','Rangpur College','Afternoon','107','D','English'),
(5008,8,'2022-07-01','Comilla College','Morning','108','D','Bangla'),
(5009,9,'2022-07-01','Jessore College','Afternoon','109','E','English'),
(5010,10,'2022-07-01','Mymensingh College','Morning','110','E','Bangla');

INSERT INTO Result (StudentID, Exam_roll, SSC_marks, HSC_marks, Total_score, Merit_pos, Result_date, Status)
VALUES
(1,5001,480,490,970,1,'2022-07-10','Pass'),
(2,5002,450,470,920,2,'2022-07-10','Pass'),
(3,5003,460,480,940,3,'2022-07-10','Pass'),
(4,5004,500,500,1000,1,'2022-07-10','Pass'),
(5,5005,470,460,930,4,'2022-07-10','Pass'),
(6,5006,490,495,985,1,'2022-07-10','Pass'),
(7,5007,440,470,910,5,'2022-07-10','Pass'),
(8,5008,485,495,980,2,'2022-07-10','Pass'),
(9,5009,475,465,940,3,'2022-07-10','Pass'),
(10,5010,460,480,940,3,'2022-07-10','Pass');

INSERT INTO Subject_Choice (StudentID, GuardianID, Exam_roll, ResultID, Reg_no, Subject_list, Obtained_sub, Pending_sub)
VALUES
(1,1,5001,1,'1001','CSE,IIT','CSE','IIT'),
(2,2,5002,2,'1002','English,Bangla','English','Bangla'),
(3,3,5003,3,'1003','IIT,Physics','IIT','Physics'),
(4,4,5004,4,'1004','IR,English','IR','English'),
(5,5,5005,5,'1005','Chemistry,Physics','Chemistry','Physics'),
(6,6,5006,6,'1006','Journalism,Bangla','Journalism','Bangla'),
(7,7,5007,7,'1007','CSE,Chemistry','CSE','Chemistry'),
(8,8,5008,8,'1008','IR,Bangla','IR','Bangla'),
(9,9,5009,9,'1009','CSE,Math','CSE','Math'),
(10,10,5010,10,'1010','Law,English','Law','English');

INSERT INTO Admission (StudentID, GuardianID, Exam_roll, ResultID, Department, Amount, Session)
VALUES
(1,1,5001,1,'CSE',6000,'2022-2023'),
(2,2,5002,2,'English',6000,'2022-2023'),
(3,3,5003,3,'IIT',6000,'2022-2023'),
(4,4,5004,4,'IR',6000,'2022-2023'),
(5,5,5005,5,'Chemistry',6000,'2022-2023'),
(6,6,5006,6,'Journalism',6000,'2022-2023'),
(7,7,5007,7,'CSE',6000,'2022-2023'),
(8,8,5008,8,'IR',6000,'2022-2023'),
(9,9,5009,9,'CSE',6000,'2022-2023'),
(10,10,5010,10,'Law',6000,'2022-2023');

INSERT INTO Hall (StudentID, Reg_no, AdmissionID, Hall_name, Room_no)
VALUES
(1,'1001',1,'Shahidullah Hall','A101'),
(2,'1002',2,'Salimullah Hall','B102'),
(3,'1003',3,'Sufia Kamal Hall','C103'),
(4,'1004',4,'Suhrawardy Hall','D104'),
(5,'1005',5,'Sher-e-Bangla Hall','E105'),
(6,'1006',6,'Fazlul Huq Hall','F106'),
(7,'1007',7,'Muktijoddha Hall','G107'),
(8,'1008',8,'Titumir Hall','H108'),
(9,'1009',9,'Shamsunnahar Hall','I109'),
(10,'1010',10,'Kabi Nazrul Hall','J110');

INSERT INTO Class_Info (Edu_mail, StudentID, ResultID, Roll, AdmissionID)
VALUES
('abdullah@cse.ju.ac.bd',1,1,2022001,1),
('mariam@eng.ju.ac.bd',2,2,2022002,2),
('nusrat@iit.ju.ac.bd',3,3,2022003,3),
('hasan@ir.ju.ac.bd',4,4,2022004,4),
('tania@chem.ju.ac.bd',5,5,2022005,5),
('sabbir@jour.ju.ac.bd',6,6,2022006,6),
('farhana@cse.ju.ac.bd',7,7,2022007,7),
('rakib@ir.du.jc.bd',8,8,2022008,8),
('sadia@cse.du.jc.bd',9,9,2022009,9),
('mahmud@law.du.jc.bd',10,10,2022010,10);


