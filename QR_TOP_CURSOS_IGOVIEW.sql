SELECT top 9999999999 p.name, count(p.name) as qtd
FROM IGO_VIEWS AS V
    INNER JOIN ENT.Product2_Salesforce_Ensino as p
        on p.ExternalId =  V.sku
group by p.name
order by count(p.name) desc
