SELECT
MessageID,
CampaignID,
Sent,
Delivered,
Undelivered,
MessageText,
SubscriberKey,
Name
FROM _smsmessagetracking
WHERE MessageID NOT IN ('246','240','244','247','227')
AND NAME LIKE '%PROSELETIVO%'
/* WHERE RETIRA DISPAROS QUE NAO SAO DE JORNADAS */