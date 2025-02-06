SELECT DISTINCT
A.ANO,
A.MES,
COUNT(A.CONTACTKEY) AS QTD_CONTACT
FROM (SELECT L.CONTACTKEY,L.EMAIL,DATEPART(year, L.CreatedDate) AS ANO, DATEPART(month, L.CreatedDate) AS MES,
ROW_NUMBER() OVER (PARTITION BY L.Email ORDER BY L.Email ASC) AS RowNumber FROM ENT.Lead_Salesforce_Ensino AS L) AS A
WHERE RowNumber < 2
GROUP BY A.ANO,A.MES




/* -------------------------------- FILTRO POR MESES ---------------- */ 

SELECT DISTINCT
A.ANO,
COUNT(A.Email) AS QTD_CONTACT
FROM (SELECT L.CONTACTKEY,L.EMAIL,DATEPART(year, L.CreatedDate) AS ANO, DATEPART(month, L.CreatedDate) AS MES,
ROW_NUMBER() OVER (PARTITION BY L.Email ORDER BY L.Email ASC) AS RowNumber FROM ENT.Lead_Salesforce_Ensino AS L) AS A
WHERE RowNumber < 2 AND MES < 10
GROUP BY A.ANO

/* -------------------------------- FILTRO POR ORIGEM DE LEAD ------------------- */

SELECT DISTINCT
A.ANO,
COUNT(A.Email) AS QTD_CONTACT
FROM (SELECT L.CONTACTKEY,L.EMAIL,DATEPART(year, L.CreatedDate) AS ANO, DATEPART(month, L.CreatedDate) AS MES,
ROW_NUMBER() OVER (PARTITION BY L.Email ORDER BY L.Email ASC) AS RowNumber FROM ENT.Lead_Salesforce_Ensino AS L WHERE L.LeadSource = 'Form') AS A
WHERE RowNumber < 2 AND MES < 10
GROUP BY A.ANO


/* ---------------------------------------------------*/
SELECT DISTINCT
    A.ANO,
    A.MES,
    COUNT(A.Email) AS QTD_CONTACT
        FROM (SELECT L.EMAIL,
                DATEPART(year, L.CreatedDate) AS ANO, 
                DATEPART(month, L.CreatedDate) AS MES,
                ROW_NUMBER() OVER (PARTITION BY L.Email ORDER BY L.Email ASC) AS RowNumber 
                FROM ENT.Lead_Salesforce_Ensino AS L 
                    WHERE L.LeadSource = 'Form' 
                    AND (L.Assistant_8__c <> 'Graduacao - Avise-me - VTEX' 
                            AND L.Assistant_8__c <> 'Einstein Week')) AS A
    WHERE A.RowNumber < 2 AND MES < 12
    GROUP BY A.ANO,A.MES


/* -------------------------------------*/

SELECT
    DATEPART(year, L.CreatedDate) AS ANO,
    COUNT(DISTINCT L.EMAIL) AS QTD_NovosLeads
FROM 
    ENT.Lead_Salesforce_Ensino AS L
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM ENT.Lead_Salesforce_Ensino AS L_PrevYear
        WHERE L_PrevYear.EMAIL = L.EMAIL AND DATEPART(year, L_PrevYear.CreatedDate) = DATEPART(year, L.CreatedDate) - 1
    )
GROUP BY 
    DATEPART(year, L.CreatedDate)


