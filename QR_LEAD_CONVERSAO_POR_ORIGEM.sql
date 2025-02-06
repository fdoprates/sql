/* com ano e mes */

SELECT
    a.LeadSource,
    a.ANO,
    a.MES,
    count(a.LeadSource) as qtd,
    a.Stage
from (SELECT DISTINCT
    L.ContactKey,
    L.FirstName,
    L.LastName,
    L.LeadSource,
    L.Assistant_8__c,
    L.CPF__c,
    L.Email,
    L.Course__c,
    L.Class__C,
    IIF(oli.Class_Id__c = l.SKU_VTEX__c, 'Convertido' , l.status) as Stage,
    DATEPART(YEAR,o.CreatedDate) ANO,
    DATEPART(MONTH,o.CreatedDate) MES
FROM ENT.Lead_Salesforce_Ensino AS L

    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON L.Email = e.EmailAddress
    
    INNER JOIN ent.Account_Salesforce_Ensino a
    ON a.Id = e.ParentId
    
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
    ON o.AccountId = a.Id
    
    INNER JOIN ent.OpportunityLineItem_Salesforce_Ensino oli
    ON o.Id = oli.OpportunityId
    
WHERE oli.Class_Id__c = l.SKU_VTEX__c
AND CONVERT(CHAR(10), l.CreatedDate , 120) < CONVERT(CHAR(10), o.CreatedDate, 120) ) as a
group by a.LeadSource,a.MES,a.ANO, a.Stage


/* ----------------------------------------------------*/
SELECT
    a.LeadSource,
    count(a.LeadSource) as qtd
from (SELECT DISTINCT
    L.ContactKey,
    L.FirstName,
    L.LastName,
    L.LeadSource,
    L.Assistant_8__c,
    L.CPF__c,
    L.Email,
    L.Course__c,
    L.Class__C,
    IIF(oli.Class_Id__c = l.SKU_VTEX__c, 'Convertido' , l.status) as Stage
FROM ENT.Lead_Salesforce_Ensino AS L

    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON L.Email = e.EmailAddress
    
    INNER JOIN ent.Account_Salesforce_Ensino a
    ON a.Id = e.ParentId
    
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
    ON o.AccountId = a.Id
    
    INNER JOIN ent.OpportunityLineItem_Salesforce_Ensino oli
    ON o.Id = oli.OpportunityId
    
WHERE oli.Class_Id__c = l.SKU_VTEX__c
AND CONVERT(CHAR(10), l.CreatedDate , 120) < CONVERT(CHAR(10), o.CreatedDate, 120) ) as a
group by LeadSource



/* ---------------------------------------------------- MEDIA DE DIA DE CONVERSAO POR LEAD SOURCE -------------------- */ 

SELECT
    a.LeadSource,
    count(a.LeadSource) as qtd,
    a.Assistant_8__c,
    avg(avg_conversion) as avg_conversion
from (SELECT DISTINCT
    L.ContactKey,
    L.FirstName,
    L.LastName,
    L.LeadSource,
    L.Assistant_8__c,
    DATEDIFF(DAY, l.CreatedDate,o.CreatedDate) AS avg_conversion,
    L.CPF__c,
    L.Email,
    L.Course__c,
    L.Class__C,
    IIF(oli.Class_Id__c = l.SKU_VTEX__c, 'Convertido' , l.status) as Stage
FROM ENT.Lead_Salesforce_Ensino AS L

    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON L.Email = e.EmailAddress
    
    INNER JOIN ent.Account_Salesforce_Ensino a
    ON a.Id = e.ParentId
    
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
    ON o.AccountId = a.Id
    
    INNER JOIN ent.OpportunityLineItem_Salesforce_Ensino oli
    ON o.Id = oli.OpportunityId
    
WHERE oli.Class_Id__c = l.SKU_VTEX__c
AND CONVERT(CHAR(10), l.CreatedDate , 120) < CONVERT(CHAR(10), o.CreatedDate, 120) ) as a
group by a.LeadSource, a.Assistant_8__c



/* ---------------------------------------SEM CATEGORIA DE PRODUTO------------------------------------------------ */

SELECT
    a.LeadSource,
    count(a.LeadSource) as qtd,
    a.Assistant_8__c,
    avg(avg_conversion) as avg_conversion,
    a.Quartile
from (SELECT DISTINCT
    L.ContactKey,
    L.FirstName,
    L.LastName,
    L.LeadSource,
    L.Assistant_8__c,
    DATEDIFF(DAY, l.CreatedDate,o.CreatedDate) AS avg_conversion,
    NTILE(4) OVER(ORDER BY DATEDIFF(DAY, l.CreatedDate,o.CreatedDate) DESC) AS Quartile,
    L.CPF__c,
    L.Email,
    L.Course__c,
    L.Class__C,
    IIF(oli.Class_Id__c = l.SKU_VTEX__c, 'Convertido' , l.status) as Stage
FROM ENT.Lead_Salesforce_Ensino AS L

    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON L.Email = e.EmailAddress
    
    INNER JOIN ent.Account_Salesforce_Ensino a
    ON a.Id = e.ParentId
    
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
    ON o.AccountId = a.Id
    
    INNER JOIN ent.OpportunityLineItem_Salesforce_Ensino oli
    ON o.Id = oli.OpportunityId
    
WHERE oli.Class_Id__c = l.SKU_VTEX__c
AND CONVERT(CHAR(10), l.CreatedDate , 120) < CONVERT(CHAR(10), o.CreatedDate, 120) ) as a
group by a.LeadSource, a.Assistant_8__c, a.Quartile

/* ---------------------------------------------- com category de produto ------------------------- */

SELECT
    a.LeadSource,
    count(a.LeadSource) as qtd,
    a.Assistant_8__c,
    avg(avg_conversion) as avg_conversion,
    a.Quartile,
    a.Product_name__c
from (SELECT DISTINCT
    L.ContactKey,
    L.FirstName,
    L.LastName,
    L.LeadSource,
    L.Assistant_8__c,
    DATEDIFF(DAY, l.CreatedDate,o.CreatedDate) AS avg_conversion,
    NTILE(4) OVER(ORDER BY DATEDIFF(DAY, l.CreatedDate,o.CreatedDate) DESC) AS Quartile,
    L.CPF__c,
    L.Email,
    L.Course__c,
    L.Class__C,
    L.Product_name__c,
    IIF(oli.Class_Id__c = l.SKU_VTEX__c, 'Convertido' , l.status) as Stage
FROM ENT.Lead_Salesforce_Ensino AS L

    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON L.Email = e.EmailAddress
    
    INNER JOIN ent.Account_Salesforce_Ensino a
    ON a.Id = e.ParentId
    
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
    ON o.AccountId = a.Id
    
    INNER JOIN ent.OpportunityLineItem_Salesforce_Ensino oli
    ON o.Id = oli.OpportunityId
    
WHERE oli.Class_Id__c = l.SKU_VTEX__c
AND CONVERT(CHAR(10), l.CreatedDate , 120) < CONVERT(CHAR(10), o.CreatedDate, 120) ) as a
group by a.LeadSource, a.Assistant_8__c, a.Quartile, a.Product_name__c



/* ------------------------------------------------ conversao por codigo P000 NÃO É ASSISTIDA --------------------*/

SELECT DISTINCT
A1.Id
,A1.ContactKey
,A.Id AS Account_id
,A1.FirstName
,A1.LastName
,A1.Email
,A1.LeadSource
,A1.StockKeepingUnit
,IIF(A1.ProductCode = oli.ProductCode, 'Convertido' , A1.status) as Stage
,DATEPART(YEAR,o.CreatedDate) AS ANO_OPP
,DATEPART(MONTH,o.CreatedDate) AS MES_OPP
,A1.ANO_LEAD
,A1.MES_LEAD
,IIF(H.ContactKey IS NULL, 0, 1) AS RECEBEU_JORNADA
,DATEPART(YEAR,h.EntryDate) AS ANO_JOR
,DATEPART(MONTH,h.EntryDate) AS MES_JOR
FROM (SELECT DISTINCT
    L.Id,
    L.ContactKey,
    L.LeadSource,
    L.FirstName,
    L.LastName,
    L.Email,
    L.Status,
    DATEPART(YEAR,L.CreatedDate) AS ANO_LEAD,
    DATEPART(MONTH,L.CreatedDate) AS MES_LEAD,
    p.productcode,
    P.StockKeepingUnit
FROM ENT.Lead_Salesforce_Ensino AS L
    INNER JOIN ENT.Product2_Salesforce_Ensino AS P
        ON L.SKU_VTEX__c = P.StockKeepingUnit
) AS A1
    INNER JOIN ENT.Product2_Salesforce_Ensino AS P1
    ON A1.ProductCode = P1.ProductCode

    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON A1.Email = e.EmailAddress
    
    INNER JOIN ent.Account_Salesforce_Ensino a
    ON a.Id = e.ParentId
    
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
    ON o.AccountId = a.Id
    
    INNER JOIN ent.OpportunityLineItem_Salesforce_Ensino oli
    ON o.Id = oli.OpportunityId

    LEFT JOIN TB02_CARRINHO_ABANDONADO_HISTORICO AS H
    ON A1.ContactKey = H.ContactKey