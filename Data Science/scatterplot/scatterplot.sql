SELECT 
               SUM(
               WEAPON10 
               + DRUG10
               + LIQUOR10
               + WEAPON11
               + DRUG11
               + LIQUOR11
               + WEAPON12
               + DRUG12
               + LIQUOR12) as TotalArrests,
               SUM(Total)/1000 AS TotalPeople
               FROM rkhadse.OnCampusArrest
               GROUP BY ID;
               
               
               SELECT 
               SUM(
               WEAPON10 
               + DRUG10
               + LIQUOR10
               + WEAPON11
               + DRUG11
               + LIQUOR11
               + WEAPON12
               + DRUG12
               + LIQUOR12) as TotalArrests,
               SUM(Total)/1000 AS TotalPeople
               FROM rkhadse.NonCampusArrest
               GROUP BY ID;