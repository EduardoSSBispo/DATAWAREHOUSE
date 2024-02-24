-- Qual cidade teve mais agendamentos por per�odo


-- Quais sal�es com menos agendamentos por per�odo


-- Quais sal�es com mais agendamentos, por semestre


-- Qual m�s ocorrem mais agendamentos


-- Qual m�s ocorrem mais cancelamentos de agendamentos


-- Qual a faixa et�ria que mais frequenta os sal�es por cidade
SELECT F.FAIXA_ETARIA, SUM(S.NUMERO_SERVICO)
FROM FATO_SERVICO S JOIN DIM_FAIXA_ETARIA F
ON(S.ID_FAIXA_ETARIA = F.ID_FAIXA_ETARIA)
JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY F.FAIXA_ETARIA, A.CIDADE

-- Qual servi�o mais pedido, por sal�o, por per�odo
SELECT A.NM_SALAO, T.NOME_TRIMESTRE, SUM(S.NUMERO_SERVICO)
FROM FATO_SERVICO S JOIN DIM_TEMPO T
ON(S.ID_DT_AGENDAMENTO = T.ID_TEMPO)
JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY A.NM_SALAO, T.NOME_TRIMESTRE

-- Quais funcion�rios que mais atendem servi�os, por sal�o
SELECT F.NM_FUNCIONARIO, SUM(S.NUMERO_SERVICO) AS 'SERVI�OS ATENDIDOS'
FROM FATO_SERVICO S JOIN DIM_FUNCIONARIO F
ON(S.ID_FUNCIONARIO = F.ID_FUNCIONARIO)
GROUP BY  NM_FUNCIONARIO

-- Quais sal�es agendam menos servi�os, por cidade
SELECT A.CIDADE, A.NM_SALAO, SUM(S.NUMERO_SERVICO)
FROM FATO_SERVICO S JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY A.CIDADE

-- Qual a m�dia de renda por sal�o
SELECT A.NM_SALAO, AVG(S.VALOR_SERVICO)
FROM FATO_SERVICO S JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY A.NM_SALAO