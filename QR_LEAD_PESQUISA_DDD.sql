-- SF query builder

SELECT DISTINCT
    CONTACTKEY,
    FirstName,
    LastName,
    Email,
    PHONE,
    'pt-br' AS Locale
FROM (SELECT
    CONTACTKEY,
    LeadSource,
    FirstName,
    LastName,
    Email,
    Profession__c,
    CASE
        WHEN LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')) = 11 
            THEN CONCAT('55', REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')) 
        WHEN LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')) = 13
            THEN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, ')', ''), '(', ''), '+', ''), ' ', ''), '-', '')
    END AS Phone,
    Opt_in__c,
    HasOptedOutOfEmail
FROM Ent.Lead_Salesforce_Ensino) AS A
WHERE HasOptedOutOfEmail = 0
    AND SUBSTRING(phone,3,2) NOT IN (11,12,13,14,15,16,17,18,19,21,22,24,31,32,33,34,35,37,38)


/*
Norte
– Acre (68)
– Amapá (96)
– Amazonas (92,97)
– Pará (91,93,94)
– Rondônia (69)
– Roraima (95)
– Tocantins (63)
*/


/*
Nordeste
– Alagoas (82)
– Bahia (71,73,74,75,77)
– Ceará (85,88)
– Maranhão (98,99)
– Paraíba (83)
– Pernambuco (81,87)
– Piauí (86,89)
– Rio Grande do Norte (84)
– Sergipe (79)
*/


/*
Centro-Oeste
– Distrito Federal (61)
– Goiás (62,64)
– Mato Grosso (65,66)
– Mato Grosso do Sul (67)
*/


/*
Sudeste
– Espírito Santo (27,28)
– Minas Gerais (31,32,33,34,35,37,38)
– Rio de Janeiro (21,22,24)
– São Paulo (11,12,13,14,15,16,17,18,19)
*/


/*
Sul
– Paraná (41,42,43,44,45,46)
– Rio Grande do Sul (51,53,54,55)
– Santa Catarina (47,48,49)
*/


    




            

