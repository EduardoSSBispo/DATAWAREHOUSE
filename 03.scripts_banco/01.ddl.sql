CREATE DATABASE SALAO
USE SALAO

USE MASTER
DROP DATABASE SALAO


DROP TABLE TB_SERVICO
DROP TABLE TB_AGENDAMENTO
DROP TABLE TB_CLIENTE
DROP TABLE TB_TIPO_SERVICO
DROP TABLE TB_PRODUTO
DROP TABLE TB_SERVICO_PRODUTO
DROP TABLE TB_SALAO
DROP TABLE TB_FUNCIONARIO_ESPECIALIZACAO
DROP TABLE TB_FUNCIONARIO
DROP TABLE TB_ESPECIALIZACAO


----------- Criação do Ambiente Operacional -----------

-- Salão
CREATE TABLE TB_SALAO(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NOME VARCHAR(45) NOT NULL,
	CNPJ VARCHAR (18) NOT NULL UNIQUE,
	RUA VARCHAR(45) NOT NULL,
	CIDADE VARCHAR(45) NOT NULL,
	UF VARCHAR(2) NOT NULL,
	NUMERO VARCHAR(10) --retirar depois
)

-- Agendamento
CREATE TABLE TB_AGENDAMENTO (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    horario DATETIME NOT NULL,
    status VARCHAR(11) NOT NULL CHECK(STATUS IN('AGENDADO', 'CANCELADO', 'TERMINADO')),
    VALOR_TOTAL FLOAT NOT NULL,
    idSalao INT NOT NULL,
    idCliente INT NOT NULL,
)

-- Cliente
CREATE TABLE TB_CLIENTE (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(45) NOT NULL UNIQUE,
    EMAIL VARCHAR(50),
    dt_nascimento DATE NOT NULL,
    telefone VARCHAR(45) NOT NULL,
    SEXO VARCHAR(15),
    rua VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    numero VARCHAR(10) 
)

-- Funcionário
CREATE TABLE TB_FUNCIONARIO(
	MATRICULA INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NOME VARCHAR(45) NOT NULL,
	CPF VARCHAR(15) NOT NULL UNIQUE,
	TELEFONE VARCHAR(20) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	DTNASCIMENTO DATE NOT NULL,
	SALARIO FLOAT NOT NULL,
	DT_CONTRATACAO DATETIME NOT NULL,
	DT_DEMISSAO DATETIME,
	CIDADE VARCHAR(45) NOT NULL,
	RUA VARCHAR(45) NOT NULL,
	BAIRRO VARCHAR(45) NOT NULL,
	ID_SALAO INT NOT NULL
)

-- Serviço
CREATE TABLE TB_SERVICO (
    ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    descricao VARCHAR(200),
    idFuncionario INT NOT NULL,
    idAgendamento INT NOT NULL,
	idTipoServico INT NOT NULL
)

-- Produtos de um serviço
CREATE TABLE TB_PRODUTO_SERVICO (
    CODIGO_PRODUTO INT NOT NULL,
    ID_SERVICO INT NOT NULL,
	PRIMARY KEY(CODIGO_PRODUTO, ID_SERVICO)
)

CREATE TABLE TB_TIPO_SERVICO(
	CODIGO INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SERVICO VARCHAR(45) NOT NULL,
	VALOR FLOAT NOT NULL
)

-- Produto
CREATE TABLE TB_PRODUTO(
	CODIGO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NOME VARCHAR(45) NOT NULL,
	QUANTIDADE INT NOT NULL,
	VALOR FLOAT NOT NULL
)

-- Especializações de um funcionario
CREATE TABLE TB_FUNCIONARIO_ESPECIALIZACAO(
	MATRICULA_FUNCIONARIO INT NOT NULL,
	ID_ESPECIALIZACAO INT NOT NULL
	PRIMARY KEY(MATRICULA_FUNCIONARIO, ID_ESPECIALIZACAO)
)

-- Especialização
CREATE TABLE TB_ESPECIALIZACAO(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NOME VARCHAR(30) NOT NULL
)

-- Chaves estrangeiras

ALTER TABLE TB_AGENDAMENTO
ADD CONSTRAINT FK_AGENDAMENTO_TO_SALAO
FOREIGN KEY (idSalao) REFERENCES TB_SALAO(id);

ALTER TABLE TB_AGENDAMENTO
ADD CONSTRAINT FK_AGENDAMENTO_TO_CLIENTE
FOREIGN KEY (idCliente) REFERENCES TB_CLIENTE(id);

ALTER TABLE TB_SERVICO
ADD CONSTRAINT FK_SERVICO_TO_FUNCIONARIO
FOREIGN KEY (idFuncionario) REFERENCES TB_FUNCIONARIO(MATRICULA);

ALTER TABLE TB_SERVICO
ADD CONSTRAINT FK_SERVICO_TO_AGENDAMENTO
FOREIGN KEY (idAgendamento) REFERENCES TB_AGENDAMENTO(id);

ALTER TABLE TB_PRODUTO_SERVICO
ADD CONSTRAINT FK_SERVICOPRODUTO_TO_PRODUTO
FOREIGN KEY (CODIGO_PRODUTO) REFERENCES TB_PRODUTO(CODIGO);

ALTER TABLE TB_PRODUTO_SERVICO
ADD CONSTRAINT FK_SERVICOPRODUTO_TO_SERVICO
FOREIGN KEY (ID_SERVICO) REFERENCES TB_SERVICO(ID);

ALTER TABLE TB_FUNCIONARIO_ESPECIALIZACAO
ADD CONSTRAINT FK_FUNCIONARIO_ESPECIALIZACAO_TO_FUNCIONARIO
FOREIGN KEY(MATRICULA_FUNCIONARIO) REFERENCES TB_FUNCIONARIO(MATRICULA)

ALTER TABLE TB_FUNCIONARIO_ESPECIALIZACAO
ADD CONSTRAINT FK_FUNCIONARIO_ESPECIALIZACAO_TO_ESPECIALIZACAO
FOREIGN KEY(ID_ESPECIALIZACAO) REFERENCES TB_ESPECIALIZACAO(ID)

ALTER TABLE TB_FUNCIONARIO
ADD CONSTRAINT FK_FUNCIONARIO_TO_SALAO
FOREIGN KEY(ID_SALAO) REFERENCES TB_SALAO(ID)

ALTER TABLE TB_SERVICO
ADD CONSTRAINT FK_TIPOSERVICO_TO_SERVICO
FOREIGN KEY(idTipoServico) REFERENCES TB_TIPO_SERVICO(CODIGO)


----------- Fim da Criação do Ambiente Operacional -----------


----------- Criação do Staging -----------

----------- Fim da Criação do Staging -----------


----------- Criação do Ambiente Dimensional -----------

-- Dimensão Tempo
CREATE TABLE DIM_TEMPO (
	ID_TEMPO BIGINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	NIVEL VARCHAR(8) NOT NULL CHECK (NIVEL IN ('DIA','MES','ANO')),
	DATA DATETIME NULL,
	DIA INT NULL,
	DIA_SEMANA VARCHAR(50) NULL,
	FIM_SEMANA VARCHAR(3) NULL CHECK (FIM_SEMANA IN ('SIM','NAO')),
	FERIADO VARCHAR(100) NULL,
	FL_FERIADO VARCHAR(3) NULL CHECK (FL_FERIADO IN ('SIM','NAO')),
	MES INT NULL,
	NOME_MES VARCHAR(100) NULL,
	TRIMESTRE INT NULL,
	NOME_TRIMESTRE VARCHAR(100) NULL,
	SEMESTRE INT NULL,
	NOME_SEMESTRE VARCHAR(100) NULL,
	ANO INT NOT NULL
)
CREATE INDEX IX_DIM_TEMPO_DATA ON DIM_TEMPO (DATA)
CREATE INDEX IX_DIM_TEMPO_DATA_MES ON DIM_TEMPO (NIVEL, MES)
CREATE INDEX IX_DIM_TEMPO_DATA_ANO ON DIM_TEMPO (NIVEL, ANO)

-- Dimensão Cliente
CREATE TABLE DIM_CLIENTE(
	ID_CLIENTE INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	COD_CLIENTE DATE NOT NULL,
	NM_CLIENTE VARCHAR(45) NOT NULL,
	DT_NASCIMENTO DATE NOT NULL,
	CIDADE VARCHAR(45) NOT NULL
)

-- DIM_TIPO_SERVICO
CREATE TABLE DIM_TIPO_SERVICO(
	ID_TIPO_SERVICO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	COD_TIPO_SERVICO INT NOT NULL,
	NM_TIPO_SERVICO VARCHAR(45)
)

-- DIM_FAIXA_ETARIA
CREATE TABLE DIM_FAIXA_ETARIA(
	ID_FAIXA_ETARIA INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	COD_FAIXA_ETARIA VARCHAR(45) NOT NULL,
	FAIXA_ETARIA VARCHAR(45) NOT NULL
)

-- DIM_FUNCIONARIO
CREATE TABLE DIM_FUNCIONARIO(
	ID_FUNCIONARIO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	COD_FUNCIONARIO INT NOT NULL,
	NM_FUNCIONARIO VARCHAR(45) NOT NULL,
	CPF VARCHAR(15) NOT NULL,
	TELEFONE VARCHAR(45) NOT NULL
)

-- FATO SERVICO
CREATE TABLE FATO_SERVICO(
	ID_SERVICO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ID_DT_AGENDAMENTO BIGINT NOT NULL,
	ID_FAIXA_ETARIA INT NOT NULL,
	ID_SALAO INT NOT NULL,
	ID_CLIENTE INT NOT NULL,
	ID_FUNCIONARIO INT NOT NULL,
	ID_TIPO_SERVICO INT NOT NULL,
	NUMERO_SERVICO INT NOT NULL DEFAULT(1),
	VALOR_SERVICO NUMERIC(10,2) NOT NULL
)

ALTER TABLE FATO_SERVICO
ADD CONSTRAINT FK_FATOSERVICO_TEMPO_DT_AGENDAMENTO
FOREIGN KEY (ID_DT_AGENDAMENTO) REFERENCES DIM_TEMPO(ID_TEMPO);

ALTER TABLE FATO_SERVICO
ADD CONSTRAINT FK_FATOSERVICO_FAIXA_ETARIA
FOREIGN KEY (ID_FAIXA_ETARIA) REFERENCES DIM_FAIXA_ETARIA(ID_FAIXA_ETARIA);

ALTER TABLE FATO_SERVICO
ADD CONSTRAINT FK_FATOSERVICO_SALAO
FOREIGN KEY (ID_SALAO) REFERENCES DIM_SALAO(ID_SALAO);

ALTER TABLE FATO_SERVICO
ADD CONSTRAINT FK_FATOSERVICO_CLIENTE
FOREIGN KEY (ID_CLIENTE) REFERENCES DIM_CLIENTE(ID_CLIENTE);

ALTER TABLE FATO_SERVICO
ADD CONSTRAINT FK_FATOSERVICO_FUNCIONARIO
FOREIGN KEY (ID_FUNCIONARIO) REFERENCES DIM_FUNCIONARIO(ID_FUNCIONARIO);

ALTER TABLE FATO_SERVICO
ADD CONSTRAINT FK_FATOSERVICO_TIPO_SERVICO
FOREIGN KEY (ID_TIPO_SERVICO) REFERENCES DIM_TIPO_SERVICO(ID_TIPO_SERVICO);

----------- Fim da Criação do Ambiente Dimensional -----------