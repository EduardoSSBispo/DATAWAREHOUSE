USE SALAO

-- SALÃO
CREATE PROCEDURE SP_POPULAR_SALAO (@NOME VARCHAR(45), @CNPJ VARCHAR(15), @DTNASCIMENTO DATETIME, @TELEFONE VARCHAR(20), @RUA VARCHAR(45), @CIDADE VARCHAR(45), @NUMERO VARCHAR(10) OUTPUT)
AS
BEGIN
	INSERT INTO TB_SALAO
	VALUES(@NOME, @CNPJ, @DTNASCIMENTO, @TELEFONE, @RUA, @CIDADE, @NUMERO)
END

-- AGENDAMENTO
CREATE PROCEDURE SP_POPULAR_AGENDAMENTO (@HORARIO DATETIME, @STATUS VARCHAR(11), @ID_SALAO INT, @ID_CLIENTE INT OUTPUT)
AS
BEGIN
	INSERT INTO TB_Agendamento
	VALUES(@HORARIO, @STATUS, @ID_SALAO, @ID_CLIENTE)
END

-- CLIENTE
CREATE PROCEDURE SP_POPULAR_CLIENTE (@ID_CLIENTE INT, @NOME VARCHAR(45), @CPF VARCHAR(45), @TELEFONE VARCHAR(45), @RUA VARCHAR(45), @CIDADE VARCHAR(45), @DT_NASCIMENTO DATETIME, @NUMERO VARCHAR(45) OUTPUT)
AS
BEGIN
	INSERT INTO TB_Cliente
	VALUES(@ID_CLIENTE, @NOME, @CPF, @TELEFONE, @RUA, @CIDADE, @DT_NASCIMENTO, @NUMERO)
END

-- FUNCIONARIO
CREATE PROCEDURE SP_POPULAR_FUNCIONARIO (@MATRICULA INT, @ID_ESPECIALIZACAO INT, @NOME VARCHAR(45), @CPF VARCHAR(45), @TELEFONE VARCHAR(20), @DT_NASCIMENTO DATETIME, @RUA VARCHAR(45), @CIDADE VARCHAR(45) OUTPUT)
AS
BEGIN
	INSERT INTO TB_Funcionario
	VALUES(@MATRICULA,@ID_ESPECIALIZACAO, @NOME, @CPF, @TELEFONE, @DT_NASCIMENTO, @RUA, @CIDADE)

END

--SERVICO
CREATE PROCEDURE SP_POPULAR_SERVICO (@ID_SERVICO INT, @DESCRICAO VARCHAR(200), @ID_FUNCIONARIO INT, @ID_AGENDAMENTO INT OUTPUT)
AS
BEGIN
	INSERT INTO TB_SERVICO
	VALUES(@ID_SERVICO, @ DESCRICAO, @ ID_FUNCIONARIO, @ ID_AGENDAMENTO)

END

--SERVICO_PRODUTO

CREATE PROCEDURE SP_POPULAR_SERVICO_PRODUTO (@CODIGO_PRODUTO INT, @ID_PRODUTO INT OUTPUT)
AS
BEGIN
	INSERT INTO TB_SERVICO_PRODUTO
	VALUES (@CODIGO_PRODUTO, @ID_PRODUTO)

END
--TIPO_SERVICO

CREATE PROCEDURE SP_POPULAR_TIPO_SERVICO(@CODIGO_TIPO_SERVICO INT, @SERVICO INT OUTPUT)
AS
BEGIN
	INSERT INTO TB_TIPO_SERVICO
	VALUES (@CODIGO_TIPO_SERVICO, @SERVICO)
END

	
--TIPO_SERVICO_SERVICO

CREATE PROCEDURE SP_POPULAR_TIPO_SERVICO_SERVICO (@ID_SERVICO INT, @ID_TIPO_SERVICO INT OUTPUT)
AS
BEGIN
	INSERT INTO TB_TIPO_SERVICO_SERVICO
	VALUES (@ID_SERVICO, @ID_TIPO_SERVICO)
END

-- PRODUTO

	CREATE PROCEDURE SP_POPULAR_PRODUTO (@CODIGO_PRODUTO INT, @NOME VARCHAR(45) OUTPUT)
AS
BEGIN
	INSERT INTO TB_PRODUTO
	VALUES (@CODIGO_PRODUTO, @NOME)
END


-- ESPECIALIZACAO
	
CREATE PROCEDURE SP_POPULAR_ESPECIALIZACAO (@ID_ESPECIALIZACAO INT, @NOME VARCHAR(45) OUTPUT)
AS
BEGIN
	INSERT INTO TB_ESPECIALIZACAO
	VALUES (@ID_ESPECIALIZACAO, @NOME)
END








