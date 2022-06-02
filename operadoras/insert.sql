CREATE TEMPORARY TABLE IF NOT EXISTS temp_operadora (
  id SERIAL NOT NULL,
  reg_ans VARCHAR(40),
  cnpj VARCHAR(20),
  razao_social VARCHAR(150),
  nome_fantasia VARCHAR(100),
  modalidade VARCHAR(75),
  logradouro VARCHAR(75),
  numero VARCHAR(25),
  complemento VARCHAR(50),
  bairro VARCHAR(50),
  cidade VARCHAR(35),
  uf CHAR(2),
  cep VARCHAR(8),
  ddd VARCHAR(3),
  telefone VARCHAR(20),
  fax VARCHAR(15),
  email VARCHAR(100),
  representante VARCHAR(100),
  cargo_representante VARCHAR(50),
  dt_reg_ans VARCHAR(17),
  PRIMARY KEY(id)
);

-- importa o csv Relatorio_cadop teste 3 para a tabela temporária

COPY temp_operadora (
  reg_ans,
  cnpj,
  razao_social,
  nome_fantasia,
  modalidade,
  logradouro,
  numero,
  complemento,
  bairro,
  cidade,
  uf,
  cep,
  ddd,
  telefone,
  fax,
  email,
  representante,
  cargo_representante,
  dt_reg_ans
)
FROM 'C:\teste3\operadoras\Relatorio_cadop teste 3.csv'
WITH DELIMITER ';' QUOTE '"' CSV ENCODING 'win1252';

-- insere os dados da tabela temporária na tabela principal

INSERT INTO operadora (
  reg_ans,
  cnpj,
  razao_social,
  nome_fantasia,
  modalidade,
  logradouro,
  numero,
  complemento,
  bairro,
  cidade,
  uf,
  cep,
  ddd,
  telefone,
  fax,
  email,
  representante,
  cargo_representante,
  dt_reg_ans
)
SELECT
  reg_ans::INT as reg_ans,
  replace(cnpj, ',', '.')::FLOAT::BIGINT as cnpj,
  razao_social,
  nome_fantasia,
  modalidade,
  logradouro,
  numero,
  complemento,
  bairro,
  cidade,
  uf,
  cep,
  ddd,
  telefone,
  fax,
  email,
  representante,
  cargo_representante,
  dt_reg_ans::DATE as dt_reg_ans
FROM temp_operadora WHERE id > 3;

-- deleta a tabela temporária

DROP TABLE temp_operadora;

-- exibe a quantidade de colunas na tabela principal

SELECT COUNT(*) FROM operadora;

-- COUNT=1155 inserted in 94 msec.