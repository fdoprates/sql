select distinct
l.email,
case
    when j.EmailName like '%CUAT%'
        then 'CUAT'
    when j.EmailName like '%CUAT-EAD%'
        then 'CUATEAD'
    when j.EmailName like '%POS-GRAD%'
        then 'POSGRAD'
    when j.EmailName like '%POS-EAD%'
        then 'POSEAD'
    else 'AVALIAR'
    end as campanha,
convert(char(10),s.EventDate, 120) as EventDate
from _sent as s
inner join ent.lead_salesforce_ensino as l
on s.SubscriberKey = l.ContactKey
inner join _job as j
on j.JobId = s.Jobid
where datepart(mm, convert(char(10),s.EventDate, 120)) = '03'