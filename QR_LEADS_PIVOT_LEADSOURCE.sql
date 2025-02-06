SELECT DISTINCT
B1.ContactKey
,B1.FirstName
,B1.LastName
,B1.Email
,B1.Phone
,B1.CarrinhoAbandonado
,B1.AviseMe
,B1.DBM
,B1.Newsletter
,B1.AcademiaDigital
,B1.Formulario
,B1.LandingPage
,B1.Facebook
FROM (SELECT DISTINCT
A1.ContactKey
,A1.FirstName
,A1.LastName
,A1.Email
,A1.Phone
,A2.Qtd_Carrinho AS CarrinhoAbandonado
,A3.Qtd_AviseMe AS AviseMe
,A4.Qtd_DBM AS DBM
,A5.Qtd_Newsletter AS Newsletter
,A6.Qtd_ADE AS AcademiaDigital
,A7.Qtd_FORM AS Formulario
,A8.Qtd_LP AS LandingPage
,A9.Qtd_FB AS Facebook
,ROW_NUMBER() OVER (PARTITION BY A1.Email ORDER BY A1.Email ASC) AS RowNumber
FROM TB_LEADS_ENSINO AS A1
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_Carrinho FROM TB_LEADS_ENSINO WHERE LeadSource = 'Carrinho Abandonado' GROUP BY Email) AS A2
        ON A1.Email = A2.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_AviseMe FROM TB_LEADS_ENSINO WHERE LeadSource = 'Avise-Me' GROUP BY Email) AS A3
        ON A1.Email = A3.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_DBM FROM TB_LEADS_ENSINO WHERE LeadSource = 'Call Me now' GROUP BY Email) AS A4
        ON A1.Email = A4.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_Newsletter FROM TB_LEADS_ENSINO WHERE LeadSource = 'Newsletter' GROUP BY Email) AS A5
        ON A1.Email = A5.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_ADE FROM TB_LEADS_ENSINO WHERE LeadSource = 'Academia Digital' GROUP BY Email) AS A6
        ON A1.Email = A6.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_FORM FROM TB_LEADS_ENSINO WHERE LeadSource = 'Form' GROUP BY Email) AS A7
        ON A1.Email = A7.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_LP FROM TB_LEADS_ENSINO WHERE LeadSource = 'Landing Page' GROUP BY Email) AS A8
        ON A1.Email = A8.Email
    LEFT JOIN (SELECT Email, count(LeadSource) AS Qtd_FB FROM TB_LEADS_ENSINO WHERE LeadSource = 'Facebook' GROUP BY Email) AS A9
        ON A1.Email = A9.Email) AS B1
WHERE B1.RowNumber < 2





