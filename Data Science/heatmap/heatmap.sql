USE rkhadse;
#Floor is used because library is doesn't accept decimals. It needed to be converted to INT
SELECT 
State,
Case when SUM(Total)=0 then 0
Else 
FLOOR(SUM( WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12) * 100000/SUM(Total))END AS ArrestRate
FROM rkhadse.OnCampusArrest  
UNION ALL
SELECT 
State,
Case when SUM(Total)=0 then 0
Else 
FLOOR(SUM( WEAPON10 + DRUG10 + LIQUOR10 + WEAPON11 + DRUG11 + LIQUOR11 + WEAPON12 + DRUG12 + LIQUOR12) * 100000/SUM(Total)) END AS ArrestRate
  FROM rkhadse.NonCampusArrest
  where State != '' AND State IS NOT NULL
  GROUP BY State
  ORDER BY State