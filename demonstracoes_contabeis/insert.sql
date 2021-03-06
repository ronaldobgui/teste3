-- cria uma tabela uma tabela temporária para tratar os dados

CREATE TEMPORARY TABLE IF NOT EXISTS temp_demonstracao_contabil (
  id SERIAL NOT NULL,
  data DATE NOT NULL,
  reg_ans BIGINT NOT NULL,
  cd_conta_contabil INT NOT NULL,
  descricao VARCHAR(150) NOT NULL,
  vl_saldo_inicial VARCHAR(20),
  vl_saldo_final VARCHAR(20),
  PRIMARY KEY (id)
);

-- importa o csv 1T2020 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2020\1T2020.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 2T2020 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2020\2T2020.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 3T2020 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2020\3T2020.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 4T2020 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2020\4T2020.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 1T2021 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2021\1T2021.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 2T2021 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2021\2T2021.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 3T2021 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2021\3T2021.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'win1252';

-- importa o csv 4T2021 para a tabela temporária

COPY temp_demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_inicial,
  vl_saldo_final
)
FROM 'C:\teste3\demonstracoes_contabeis\2021\4T2021.csv'
WITH DELIMITER ';' QUOTE '"' CSV HEADER ENCODING 'utf8';

-- insere os dados da tabela temporária na tabela principal

INSERT INTO demonstracao_contabil (
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  vl_saldo_inicial,
  vl_saldo_final
)
SELECT
  data,
  reg_ans,
  cd_conta_contabil,
  descricao,
  REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC as vl_saldo_inicial,
  REPLACE(vl_saldo_final, ',', '.')::NUMERIC as vl_saldo_final
FROM temp_demonstracao_contabil;

-- deleta a tabela temporária

DROP TABLE temp_demonstracao_contabil;

-- exibe a quantidade de colunas na tabela principal

SELECT COUNT(*) FROM demonstracao_contabil;

-- COUNT=5965857 inserted in 5 min 46 secs.