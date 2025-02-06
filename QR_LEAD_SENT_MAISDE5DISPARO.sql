SELECT DISTINCT
    A.SubscriberKey
    ,A.Email
    ,A.FirstName
FROM (SELECT DISTINCT
        s.SubscriberKey
    ,   l.Email
    ,   l.FirstName
    ,   COUNT(s.SubscriberKey) AS qtd
    FROM (SELECT DISTINCT
            SubscriberKey
        ,   JobID
        ,   EventDate
        FROM _SENT)  AS s
    JOIN ent.Lead_Salesforce_Ensino l ON l.ContactKey = s.SubscriberKey
    JOIN _JOB AS J ON s.JOBID = J.JobID
WHERE DATEDIFF(DAY, s.EventDate, GETDATE()) BETWEEN 0 AND 3
GROUP BY s.SubscriberKey, l.Email, l.FirstName
HAVING COUNT(s.SubscriberKey) >= 5
) AS A


tonyemersoncardoso@gmail.com - 45 
magaly-tc@bol.com.br - 10 
rosemeire.guedes@einstein.br - 36
anna.drews@pulmoclinica.com.br - 18



SELECT DISTINCT
    A.SubscriberKey,
    A.Email,
    A.FirstName,
    A.qtd
FROM (
    SELECT DISTINCT
        s.SubscriberKey,
        l.Email,
        l.FirstName,
        COUNT(s.SubscriberKey) AS qtd
    FROM
        (SELECT DISTINCT
            SubscriberKey,
            JobID,
            EventDate
        FROM
            _SENT) AS s
    INNER JOIN ent.Lead_Salesforce_Ensino l ON l.ContactKey = s.SubscriberKey
    INNER JOIN _JOB AS J ON s.JOBID = J.JobID
    WHERE
        DATEDIFF(DAY, s.EventDate, GETDATE()) BETWEEN 0 AND 3
    GROUP BY
        s.SubscriberKey,
        l.Email,
        l.FirstName
    HAVING
        COUNT(s.SubscriberKey) >= 5
) AS A
WHERE
    A.Email IN (
        'tonyemersoncardoso@gmail.com',
        'magaly-tc@bol.com.br',
        'rosemeire.guedes@einstein.br',
        'anna.drews@pulmoclinica.com.br'
    )

