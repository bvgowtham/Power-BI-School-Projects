USE master

--Create a Staging DB 
CREATE DATABASE WISStagingDB
GO
USE WISStagingDB
GO

-- Create Enrollment_Graduation Table
CREATE TABLE [dbo].[Enrollment_Graduation](
[EnrollKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Year] [int] NOT NULL,
[Geography]  [nvarchar](255) NOT NULL,
[STEMField] [nvarchar](255) NOT NULL,
[Gender] [nvarchar](255) NOT NULL,
[EnrollmentNo] [int] NOT NULL,
[GraduationNo] [int] NOT NULL
)
GO

-- Create ManagementRoles Table
CREATE TABLE [dbo].[ManagementRoles](
[RoleKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Year] [int] NOT NULL,
[Geography]  [nvarchar](255) NOT NULL,
[NOC] [nvarchar](255) NOT NULL,
[Gender] [nvarchar](255) NOT NULL,
[TotalNoEmployment] [bigint] NOT NULL,
)
GO

-- Create PayDisparity Table
CREATE TABLE [dbo].[PayDisparity](
[PDKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Year] [int] NOT NULL,
[Geography]  [nvarchar](255) NOT NULL,
[STEMField] [nvarchar](255) NOT NULL,
[Gender] [nvarchar](255) NOT NULL,
[YearlyIncome] [bigint] NOT NULL,
)
GO

-- Create WomenOfColor Table
CREATE TABLE [dbo].[WomenOfColor](
[WOCKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[JobType]  [nvarchar](255) NOT NULL,
[Race] [nvarchar](255) NOT NULL,
[Number] [bigint] NOT NULL,
[STEMField] [nvarchar](255) NOT NULL,
)
GO

-- Create FactorsAffecting Table
CREATE TABLE [dbo].[FactorsAffecting](
[FAKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
[JobType] [nvarchar](255) NOT NULL,
[Factors] [nvarchar](255) NOT NULL,
[Gender] [nvarchar](255) NOT NULL,
[Responses] [int] NOT NULL,
[Year] [int] NOT NULL,
[Race] [nvarchar](255) NOT NULL,
[STEM] [nvarchar](255) NOT NULL,
)
GO
