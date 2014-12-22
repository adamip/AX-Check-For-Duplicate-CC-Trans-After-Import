USE DynamicsAXProd;
/*
SELECT name, amountcurr, transdate FROM TrvPBSMaindata 
WHERE createddatetime BETWEEN '01/01/2014' AND  GETDATE()+10
GROUP BY name, amountcurr, transdate
HAVING COUNT(*) > 1
order by TRANSDATE desc


SELECT name, amountcurr, transdate, USERFIELD2 FROM TrvPBSMaindata 
WHERE transdate BETWEEN '01/01/2014' AND  (getdate()+1)
GROUP BY name, amountcurr, transdate, USERFIELD2
HAVING COUNT(*) > 1
order by transdate desc
*/

/*

SELECT * FROM TrvPBSMaindata WHERE AMOUNTCURR IN ( 3908.76, 128.38, 3542.96, 181.88);
SELECT * FROM TrvPBSMaindata WHERE AMOUNTCURR = 26.69 AND name = 'CHRISTOPHER MCGUIRE'
SELECT * FROM TrvPBSMaindata WHERE name = 'CHRISTOPHER MCGUIRE' AND Travelno = 'expn003454'

SELECT * into trvpbsmaindata__10_01_2010 FROM TRVPBSMAINDATA

*/
USE DynamicsAXProd;

DECLARE @StartTime Datetime
SET @StartTime = GETDATE()

SELECT RECID, TRANSFER, posted, travelno, TrvPBSMaindata.name, TrvPBSMaindata.amountcurr, TrvPBSMaindata.transdate, USERFIELD2, * 
FROM TrvPBSMaindata 
WHERE TrvPBSMaindata.NAME IN (
SELECT name FROM TrvPBSMaindata 
WHERE createddatetime BETWEEN '01/01/2014' AND  GETDATE()+10
GROUP BY name, amountcurr, transdate, USERFIELD2
HAVING COUNT(*) > 1) 
AND TrvPBSMaindata.AMOUNTCURR IN (SELECT amountcurr FROM TrvPBSMaindata 
WHERE createddatetime BETWEEN '01/01/2014' AND  GETDATE()+10
GROUP BY name, amountcurr, transdate, USERFIELD2
HAVING COUNT(*) > 1)
AND TrvPBSMaindata.transdate IN (SELECT transdate FROM TrvPBSMaindata 
WHERE createddatetime BETWEEN '01/01/2014' AND  GETDATE()+10
GROUP BY name, amountcurr, transdate, USERFIELD2
HAVING COUNT(*) > 1)
AND TrvPBSMaindata.USERFIELD2 IN (SELECT USERFIELD2 FROM TrvPBSMaindata 
WHERE createddatetime BETWEEN '01/01/2014' AND  GETDATE()+10
GROUP BY name, amountcurr, transdate, USERFIELD2
HAVING COUNT(*) > 1)
ORDER BY TrvPBSMaindata.name, TrvPBSMaindata.amountcurr, TrvPBSMaindata.transdate;

SELECT 'Check For AmEx Dup' + CHAR(13) + CONVERT( VARCHAR(50), CONVERT( TIME(0),( GETDATE() - @StartTime ))) AS [Time elapsed]

/*
DELETE FROM TrvPBSMaindata
WHERE recid IN ( );

DELETE FROM TrvPBSMaindata
WHERE recid IN ( );
*/