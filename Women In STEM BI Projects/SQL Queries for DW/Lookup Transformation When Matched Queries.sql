--When matched row then update column
UPDATE Enrollment_Graduation SET EnrollmentNo=?,
GraduationNo = ?
WHERE Year = ?
AND Geography = ?
AND STEMField = ?
AND Gender = ?

UPDATE ManagementRoles SET TotalNoEmployment=?
WHERE Year = ?
AND Geography = ?
AND NOC = ?
AND Gender = ?

UPDATE PayDisparity SET YearlyIncome=?
WHERE Year = ?
AND Geography = ?
AND STEMField = ?
AND Gender = ?

UPDATE WomenOfColor SET Number=?
WHERE JobType = ?
AND Race = ?
AND STEMField = ?

UPDATE FactorsAffecting SET Responses=?
WHERE JobType = ?
AND Factors = ?
AND Gender = ?
AND Year=?
