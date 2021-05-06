
USE [WISDataMart]
GO
MERGE INTO [dbo].[FactReasons] tgt
USING ( SELECT race.RaceID,stem.STEMID,jt.JobTypeID,fac.FactorID,
(CASE WHEN src.Gender = 'None' THEN 3 ELSE gen.GenderID END) AS GenderID, src.Response, src.Number
FROM (SELECT DISTINCT woc.JobType, woc.Race, woc.[STEMField],
(CASE WHEN woc.JobType = 'Full time' THEN 'None' ELSE fcta.Factors END) AS Factor, 
(CASE WHEN woc.JobType = 'Full time' THEN 'None' ELSE fcta.Gender END) AS Gender, woc.Number, 
(CASE WHEN woc.JobType = 'Full time' THEN 0 ELSE fcta.[Responses] END) AS Response
FROM  [WISStagingDB].[dbo].[WomenOfColor] woc
LEFT JOIN [WISStagingDB].[dbo].[FactorsAffecting] fcta
ON woc.JobType = fcta.JobType AND woc.Race = fcta.Race AND woc.STEMField = fcta.STEM) src
LEFT JOIN [dbo].[DimRace] race
ON src.Race = race.RaceName
LEFT JOIN [dbo].[DimSTEM] stem
ON src.[STEMField] = stem.Name
LEFT JOIN [dbo].[DimJobType] jt
ON src.[JobType] = jt.JobTypeName
LEFT JOIN [dbo].[DimFactor] fac
ON src.[Factor] = fac.Factor
LEFT JOIN [dbo].[DimGender] gen
ON src.[Gender] = gen.Name ) AS mrgtbl
ON (mrgtbl.[RaceID] = tgt.[RaceID] AND mrgtbl.[STEMID] = tgt.[STEMID] AND mrgtbl.[JobTypeID]= tgt.[JobTypeID]
AND mrgtbl.[FactorID] = tgt.[FactorID] AND mrgtbl.[GenderID] = tgt.[GenderID]
) WHEN MATCHED AND tgt.[ResponseNo] <> mrgtbl.[Response] OR tgt.[RaceNo] <> mrgtbl.[Number] 
THEN UPDATE SET tgt.[ResponseNo] = mrgtbl.[Response], tgt.[RaceNo] = mrgtbl.[Number]
WHEN NOT MATCHED THEN
INSERT ([RaceID],[STEMID],[JobTypeID],[FactorID],[GenderID],[ResponseNo],[RaceNo])
VALUES (mrgtbl.[RaceID],mrgtbl.[STEMID],mrgtbl.[JobTypeID],mrgtbl.[FactorID],mrgtbl.[GenderID],mrgtbl.Response,mrgtbl.Number);
GO