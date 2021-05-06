
USE [WISDataMart] 
GO
MERGE INTO [dbo].[FactWIS] tgt
USING ( SELECT yr.[YearID],prv.[ProvinceID], stem.[STEMID],noc.[NOCID], sex.[GenderID],src.[GraduationNo], src.[EnrollmentNo],
src.[TotalNoEmployment],src.[YearlyIncome] FROM (SELECT enrgrad.[Year], enrgrad.[Geography],enrgrad.[Gender], enrgrad.[STEMField],
mgtrole.[NOC], enrgrad.[EnrollmentNo], enrgrad.[GraduationNo], mgtrole.[TotalNoEmployment],pay.[YearlyIncome]
FROM  [WISStagingDB].[dbo].[Enrollment_Graduation] enrgrad
INNER JOIN [WISStagingDB].[dbo].[ManagementRoles] mgtrole
ON enrgrad.[Year] = mgtrole.[Year] AND enrgrad.[Geography] = mgtrole.[Geography] AND enrgrad.[Gender] = mgtrole.[Gender]
AND enrgrad.[STEMField] = (CASE WHEN mgtrole.[NOC] = 'Engineering Manager' THEN 'Engineering' 
WHEN mgtrole.[NOC] = 'Technical Manager' THEN 'Technology' WHEN mgtrole.[NOC] = 'Mathematician' THEN 'Mathematics'
ELSE 'Science' END)
INNER JOIN [WISStagingDB].[dbo].[PayDisparity] pay
ON enrgrad.[Year] = pay.[Year] AND enrgrad.[Geography] = pay.[Geography] AND enrgrad.[Gender] = pay.[Gender]
AND enrgrad.[STEMField] = pay.[STEMField]) src
JOIN [dbo].[DimYear] yr ON src.[Year] = yr.[CalendarYear]
JOIN [dbo].[DimProvince] prv ON src.[Geography] = prv.[StateProvinceName]
JOIN [dbo].[DimGender] sex ON src.[Gender] = sex.[Name]
JOIN [dbo].[DimSTEM] stem ON src.[STEMField] = stem.[Name]
JOIN [dbo].[DimNOC] noc ON src.[NOC] = noc.[NOCName]) AS mrgtbl
ON (mrgtbl.[YearID] = tgt.[YearID] AND mrgtbl.[ProvinceID] = tgt.[ProvinceID]
AND mrgtbl.[STEMID]= tgt.[STEMID] AND mrgtbl.[NOCID] = tgt.[NOCID] AND mrgtbl.[GenderID] = tgt.[GenderID])
WHEN MATCHED AND tgt.[GraduationNo] <> mrgtbl.[GraduationNo] OR tgt.[EnrollmentNo] <> mrgtbl.[EnrollmentNo] 
OR tgt.[TotNoEmp] <> mrgtbl.[TotalNoEmployment] OR tgt.[YearlyIncome] <> mrgtbl.[YearlyIncome]
THEN UPDATE SET tgt.[GraduationNo] = mrgtbl.[GraduationNo],tgt.[EnrollmentNo] = mrgtbl.[EnrollmentNo],
tgt.[TotNoEmp] = mrgtbl.[TotalNoEmployment], tgt.[YearlyIncome] = mrgtbl.[YearlyIncome]
WHEN NOT MATCHED THEN
INSERT ([YearID],[ProvinceID],[STEMID],[NOCID],[GenderID],[GraduationNo],[EnrollmentNo],[TotNoEmp],[YearlyIncome]) 
VALUES (mrgtbl.[YearID],mrgtbl.[ProvinceID],mrgtbl.[STEMID],mrgtbl.[NOCID],mrgtbl.[GenderID],mrgtbl.[GraduationNo],
mrgtbl.[EnrollmentNo],mrgtbl.[TotalNoEmployment],mrgtbl.[YearlyIncome]);
GO
