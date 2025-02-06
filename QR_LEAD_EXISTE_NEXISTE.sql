SELECT DISTINCT
A.ORIGEM,
A.Profession__c,
COUNT(A.ORIGEM) AS QTD_ORIGEM
FROM (SELECT
L.CONTACTKEY,
L.LeadSource,
L.FirstName,
L.LastName,
L.Email,
IIF(L.Email = N.Email, 'EXISTE', 'NAO EXISTE') AS ORIGEM,
L.Profession__c,
CASE
        WHEN LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(L.phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')) = 11 
            THEN CONCAT('55', REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(L.phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')) 
        WHEN LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(L.phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')) = 13
            THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(L.phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')
    END AS Phone
FROM
    (SELECT
        CONTACTKEY,
        LeadSource,
        FirstName,
        LastName,
        Email,
        Profession__c,
        Phone,
    ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Email ASC) AS RowNumber
    FROM Ent.Lead_Salesforce_Ensino) AS L
        LEFT JOIN TB_NEGATIVAR_ADE AS N
        ON L.Email = N.Email
WHERE RowNumber < 2 ) AS A
GROUP BY A.ORIGEM, A.Profession__c