--QUERY ABAIXO RETORNA UM VALOR OS MESES ENTRE A DATA ATUAL E A DATA DE ABERTURA. CONDICAO TER 2 ABERTURA NO PERIODO DE 2 MESES
SELECT DISTINCT
        o.SubscriberKey
    ,   l.Email
FROM (SELECT 
        SubscriberKey
    ,   JobID
    ,   EventDate
    ,   Domain
    ,   ROW_NUMBER() OVER(PARTITION BY SubscriberKey ORDER BY EventDate DESC) AS RN
    FROM _Open
    WHERE ISUNIQUE = 1)  AS o
    JOIN ent.Lead_Salesforce_Ensino l ON l.ContactKey = o.SubscriberKey
    JOIN _JOB AS J ON o.JOBID = J.JobID
WHERE o.RN >=2 
AND (J.EmailName LIKE '%CUAT%')
AND DATEDIFF(MONTH, o.EventDate, GETDATE()) BETWEEN 0 AND 2




--VERSÃO PARA SABER OS DOMINIOS
SELECT DISTINCT
        o.SubscriberKey
    ,   l.Email
FROM (SELECT 
        SubscriberKey
    ,   JobID
    ,   EventDate
    ,   Domain
    ,   ROW_NUMBER() OVER(PARTITION BY SubscriberKey ORDER BY EventDate DESC) AS RN
    FROM _Open
    WHERE ISUNIQUE = 1)  AS o
    JOIN ent.Lead_Salesforce_Ensino l ON l.ContactKey = o.SubscriberKey
    JOIN _JOB AS J ON o.JOBID = J.JobID
WHERE o.RN >=2 
AND (o.Domain LIKE '%OUTLOOK%' 
OR o.Domain LIKE '%LIVE%' 
OR o.Domain LIKE '%MSN%' 
OR o.Domain LIKE '%HOTMAIL%'
OR o.Domain LIKE '%GOOGLE%' 
OR o.Domain LIKE '%GMAIL%'
OR o.Domain LIKE '%YAHOO%'
OR o.Domain LIKE '%AOL%'
OR o.Domain LIKE '%EINSTEIN%'
OR o.Domain NOT LIKE '%OUTLOOK%' 
OR o.Domain NOT LIKE '%LIVE%' 
OR o.Domain NOT LIKE '%MSN%' 
OR o.Domain NOT LIKE '%HOTMAIL%'
OR o.Domain NOT LIKE '%GOOGLE%' 
OR o.Domain NOT LIKE '%GMAIL%'
OR o.Domain NOT LIKE '%YAHOO%'
OR o.Domain NOT LIKE '%AOL%'
OR o.Domain NOT LIKE '%EINSTEIN%'
) AND J.EmailName LIKE '%CUAT%'

