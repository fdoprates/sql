SELECT DISTINCT
        o.SubscriberKey
    ,   l.Email
    ,   l.FirstName
    ,   l.Profession__c
    ,   l.Specialty__c
    ,   l.Assistant_1__c
    ,   l.Assistant_2__c
    ,   l.Assistant_3__c
    ,   l.Assistant_4__c
    ,   l.Assistant_5__c
    ,   l.Assistant_6__c
    ,   l.Assistant_7__c
    ,   l.Assistant_8__c
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
    INNER JOIN Einstein_MC_Predictive_Scores AS eins ON l.email = eins.email_address
WHERE o.RN >=2 
AND (J.EmailName LIKE '%POS-GRAD%')
AND DATEDIFF(MONTH, o.EventDate, GETDATE()) BETWEEN 0 AND 6
AND (eins.EmailEngagementPersona = 'loyalists' 
OR   eins.EmailEngagementPersona = 'Window Shoppers')
