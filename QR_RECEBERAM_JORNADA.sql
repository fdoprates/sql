SELECT DISTINCT
J.JobID
,J.EmailName
,S.EventDate AS DT_ENVIO
,S.SubscriberKey
,a.Id AS AccountId
,a.PersonContactId AS PersonContactId
,o.Id AS OpportunityId
,CONVERT(CHAR(10), o.CreatedDate , 120) AS CreatedDate
,CONVERT(CHAR(10), o.LastModifiedDate , 120) AS LastModifiedDate
FROM _JOB AS J
    INNER JOIN _SENT AS S
        ON J.JobID = S.JobID
    LEFT JOIN ent.Account_Salesforce_Ensino a
        ON a.Id = S.SubscriberKey
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
        ON o.AccountId = a.Id
WHERE CONVERT(CHAR(10), S.EventDate, 120) > CONVERT(CHAR(10), GETDATE()-2, 120)
AND J.EmailName LIKE 'JOR%'







/* ------------------------------- version 2 -------------------------------------- */

SELECT DISTINCT
J.JobID
,J.EmailName
,S.EventDate AS DT_ENVIO
,S.SubscriberKey
,a.Id AS AccountId
,a.PersonContactId AS PersonContactId
,o.Id AS OpportunityId
,o.StageName
,e.EmailAddress
,CONVERT(CHAR(10), o.CreatedDate , 120) AS CreatedDate
,CONVERT(CHAR(10), o.LastModifiedDate , 120) AS LastModifiedDate
FROM _JOB AS J
    INNER JOIN _SENT AS S
        ON J.JobID = S.JobID 
    INNER JOIN  _JourneyActivity AS JA
        ON JA.JourneyActivityObjectID = J.TriggererSendDefinitionObjectID
    INNER JOIN ent.Account_Salesforce_Ensino a
        ON a.PersonContactId = S.SubscriberKey
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
        ON o.AccountId = a.Id
    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON a.Id = e.ParentId
WHERE CONVERT(CHAR(10), S.EventDate, 120) > CONVERT(CHAR(10), GETDATE()-2, 120)
AND J.EmailName LIKE 'JOR%'


_JourneyActivity

TriggererSendDefinitionObjectID








SELECT DISTINCT
J.JobID
,J.EmailName
,S.EventDate AS DT_ENVIO
,S.SubscriberKey
,a.Id AS AccountId
,a.PersonContactId AS PersonContactId
,o.Id AS OpportunityId
,o.StageName
,e.EmailAddress
,CONVERT(CHAR(10), o.CreatedDate , 120) AS CreatedDate
,CONVERT(CHAR(10), o.LastModifiedDate , 120) AS LastModifiedDate
FROM _JOB AS J
    INNER JOIN _SENT AS S
        ON J.JobID = S.JobID
    INNER JOIN  _JourneyActivity AS JA
        ON JA.JourneyActivityObjectID = J.TriggererSendDefinitionObjectID AND J.JobID = S.JobID
    INNER JOIN ent.Account_Salesforce_Ensino a
        ON a.PersonContactId = S.SubscriberKey
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
        ON o.AccountId = a.Id
    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON a.Id = e.ParentId
WHERE CONVERT(CHAR(10), S.EventDate, 120) > CONVERT(CHAR(10), GETDATE()-2, 120)
AND J.EmailName LIKE 'JOR%'
AND o.Id = '0064x00000ORaTjAAL'



/* -------------------------------------------------------------------------------- */

SELECT j.journeyname,
       j.versionnumber,
       ja.activityname  AS EmailName,
       s.eventdate      AS SendTime,
       s.subscriberkey AS ContactKey,
       s.subscriberid   AS ContactID,
       s.jobid,
       s.listid,
       s.batchid
FROM   [_sent] AS s
       INNER JOIN [_journeyactivity] AS ja
               ON s.triggerersenddefinitionobjectid = ja.journeyactivityobjectid
       INNER JOIN [_journey] AS j
               ON ja.versionid = j.versionid
    INNER JOIN ent.Account_Salesforce_Ensino a
        ON a.PersonContactId = S.SubscriberKey
    INNER JOIN ent.Opportunity_Salesforce_Ensino o
        ON o.AccountId = a.Id
    INNER JOIN ent.ContactPointEmail_Salesforce_Ensino e
    ON a.Id = e.ParentId
WHERE  ja.activitytype IN ( 'EMAIL', 'EMAILV2' )
AND s.eventdate > Dateadd(hour, -24, Getdate())        
AND j.journeyname LIKE 'JOR%'