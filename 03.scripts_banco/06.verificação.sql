-- Qual cidade teve mais agendamentos por período


-- Quais salões com menos agendamentos por período


-- Quais salões com mais agendamentos, por semestre


-- Qual mês ocorrem mais agendamentos


-- Qual mês ocorrem mais cancelamentos de agendamentos


-- Qual a faixa etária que mais frequenta os salões por cidade
SELECT F.FAIXA_ETARIA, SUM(S.NUMERO_SERVICO)
FROM FATO_SERVICO S JOIN DIM_FAIXA_ETARIA F
ON(S.ID_FAIXA_ETARIA = F.ID_FAIXA_ETARIA)
JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY F.FAIXA_ETARIA, A.CIDADE

-- Qual serviço mais pedido, por salão, por período
SELECT A.NM_SALAO, T.NOME_TRIMESTRE, SUM(S.NUMERO_SERVICO)
FROM FATO_SERVICO S JOIN DIM_TEMPO T
ON(S.ID_DT_AGENDAMENTO = T.ID_TEMPO)
JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY A.NM_SALAO, T.NOME_TRIMESTRE

-- Quais funcionários que mais atendem serviços, por salão
SELECT F.NM_FUNCIONARIO, SUM(S.NUMERO_SERVICO) AS 'SERVIÇOS ATENDIDOS'
FROM FATO_SERVICO S JOIN DIM_FUNCIONARIO F
ON(S.ID_FUNCIONARIO = F.ID_FUNCIONARIO)
GROUP BY  NM_FUNCIONARIO

-- Quais salões agendam menos serviços, por cidade
SELECT A.CIDADE, A.NM_SALAO, SUM(S.NUMERO_SERVICO)
FROM FATO_SERVICO S JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY A.CIDADE

-- Qual a média de renda por salão
SELECT A.NM_SALAO, AVG(S.VALOR_SERVICO)
FROM FATO_SERVICO S JOIN DIM_SALAO A
ON(S.ID_SALAO = A.ID_SALAO)
GROUP BY A.NM_SALAO