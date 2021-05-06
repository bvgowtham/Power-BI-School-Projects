USE master

--Create a Data Mart 
CREATE DATABASE WISDataMart
GO
USE WISDataMart
GO

-- Create DimSTEM Table
CREATE TABLE [dbo].[DimSTEM](
[STEMID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
[Name] [nvarchar](50) NOT NULL,
)
GO
--Insert values into DimSTEM Table
INSERT INTO [dbo].[DimSTEM]
VALUES('Science'),('Technology'),('Engineering'),('Mathematics')
GO

-- Create DimProvince Table
CREATE TABLE [dbo].[DimProvince](
	[ProvinceID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
	[StateProvinceName] [nvarchar](50) NULL,
	[RegionCode] [nvarchar](3) NULL,
	[Country] [nvarchar](50) NULL,
 ) 
GO

--Insert values into DimProvince Table
INSERT INTO [dbo].[DimProvince]
VALUES('Newfoundland and Labrador','NL','Canada'),
('Prince Edward Island','PE','Canada'),
('Nova Scotia','NS','Canada'),
('New Brunswick','NB','Canada'),
('Quebec','QC','Canada'),
('Ontario','ON','Canada'),
('Manitoba','MB','Canada'),
('Saskatchewan','SK','Canada'),
('Alberta','AB','Canada'),
('British Columbia','BC','Canada')

GO

-- Create DimYear Table
CREATE TABLE [dbo].[DimYear](
[YearID] [int] NOT NULL PRIMARY KEY NONCLUSTERED,
[CalendarYear] [int] NOT NULL,
)
GO

-- Create DimRace Table
CREATE TABLE [dbo].[DimRace](
[RaceID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
[RaceName] [nvarchar](50) NOT NULL,
)
GO
--Insert values into DimRace Table
INSERT INTO [dbo].[DimRace]
VALUES('Indigenous'),('Asian'),('African American'),('Caucasian'),('More than one race')
GO

-- Create DimJobType Table
CREATE TABLE [dbo].DimJobType
([JobTypeID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
 [JobTypeName] [nvarchar](50) NOT NULL,
 )

 GO
--Insert values into DimJobType Table
INSERT INTO [dbo].DimJobType 
VALUES ('Full time'), ('Part time')
GO

-- Create DimGender Table
CREATE TABLE [dbo].DimGender
([GenderID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
 [Name] [nvarchar](50) NOT NULL,
 )
 GO

--Insert values into DimGender Table
INSERT INTO [dbo].DimGender 
VALUES ('Female'), ('Male'), ('None')
GO

-- Create DimNOC Table
CREATE TABLE DimNOC
 ([NOCID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
 [NOCName] [nvarchar](50) NOT NULL,
 )
 GO

--Insert values into DimNOC Table
INSERT INTO [dbo].DimNOC 
VALUES ('Scientist'), ('Technical Manager'), ('Engineering Manager'),('Mathematician')

GO

-- Create DimFactor Table
CREATE TABLE [dbo].DimFactor
 ([FactorID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
	[Factor] [nvarchar](255) NOT NULL,
 )
 GO

-- Create FactWIS Table
CREATE TABLE [dbo].[FactWIS](
[WISID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[YearID] [int] NOT NULL REFERENCES [dbo].[DimYear](YearID),
[ProvinceID] [int] NOT NULL REFERENCES [dbo].[DimProvince](ProvinceID),
[STEMID] [int] NOT NULL REFERENCES [dbo].[DimSTEM](STEMID),
[NOCID] [int] NOT NULL REFERENCES [dbo].[DimNOC](NOCID),
[GenderID] [int] NOT NULL REFERENCES [dbo].[DimGender](GenderID),
[GraduationNo] [bigint] NOT NULL,
[EnrollmentNo] [bigint] NOT NULL,
[TotNoEmp] [bigint] NOT NULL,
[YearlyIncome] [bigint] NOT NULL,
)
GO

-- Create FactReasons Table
CREATE TABLE [dbo].[FactReasons](
[ReasonID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[RaceID] [int] NOT NULL REFERENCES [dbo].[DimRace](RaceID),
[STEMID] [int] NOT NULL REFERENCES [dbo].[DimSTEM](STEMID),
[JobTypeID] [int] NOT NULL REFERENCES [dbo].[DimJobType](JobTypeID),
[FactorID] [int] NOT NULL REFERENCES [dbo].[DimFactor](FactorID),
[GenderID] [int] NOT NULL REFERENCES [dbo].[DimGender](GenderID),
[ResponseNo] [bigint] NOT NULL,
[RaceNo] [bigint] NOT NULL,
)
GO