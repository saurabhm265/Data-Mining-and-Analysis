USE rkhadse;

CREATE TABLE OnCampusArrest
(
ID int NOT NULL primary KEY AUTO_INCREMENT,
UNITID_P int,
INSTNM varchar(255),
BRANCH varchar(255),
Address varchar(255),
City varchar(255),
State varchar(255),
ZIP int,
sector_cd int,
Sector_desc varchar(255),
men_total int,
women_total int,
Total int,
WEAPON10 int,
DRUG10 int,
LIQUOR10 int,
WEAPON11 int,
DRUG11 int,
LIQUOR11 int,
WEAPON12 int,
DRUG12 int,
LIQUOR12 int,
FILTER10 int,
FILTER11 int,
FILTER12 int
);

CREATE TABLE NonCampusArrest
(
ID int NOT NULL primary KEY AUTO_INCREMENT,
UNITID_P int,
INSTNM varchar(255),
BRANCH varchar(255),
Address varchar(255),
City varchar(255),
State varchar(255),
ZIP int,
sector_cd int,
Sector_desc varchar(255),
men_total int,
women_total int,
Total int,
WEAPON10 int,
DRUG10 int,
LIQUOR10 int,
WEAPON11 int,
DRUG11 int,
LIQUOR11 int,
WEAPON12 int,
DRUG12 int,
LIQUOR12 int,
FILTER10 int,
FILTER11 int,
FILTER12 int
);
