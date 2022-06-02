-- interpretação 1

-- lista 10 operadoras que tiveram maior despesa com o evento informado no último trimeste
SELECT
  operadora.reg_ans,
  razao_social,
  max_data as trimestre,
  despesa
FROM
  -- lista despesas com o evento informado no último trimeste
  (SELECT
    reg_ans,
    MAX(data) AS max_data,
    SUM(vl_saldo_inicial - vl_saldo_final) as despesa
  FROM
    -- identifica o último trimestre
    (SELECT
      MAX(data) AS max_data
    FROM demonstracao_contabil) as result_data,
    demonstracao_contabil
  WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
  AND vl_saldo_inicial > vl_saldo_final
  AND result_data.max_data = data
  GROUP BY reg_ans) as result_despesa,
  operadora
WHERE result_despesa.reg_ans = operadora.reg_ans
ORDER BY despesa DESC
LIMIT 10;

-- lista 10 operadoras que tiveram maior despesa com o evento informado no último ano
SELECT
  operadora.reg_ans,
  razao_social,
  min_data as min_trimestre,
  max_data as max_trimestre,
  despesa
FROM
  -- lista despesas com o evento informado no último ano
  (SELECT
    reg_ans,
    MIN(data) AS min_data,
    MAX(data) AS max_data,
    SUM(vl_saldo_inicial - vl_saldo_final) as despesa
  FROM
    -- identifica o último ano
    (SELECT
      DATE_TRUNC('YEAR', MAX(data))::DATE max_ano
    FROM demonstracao_contabil) as result_data,
    demonstracao_contabil
  WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
  AND vl_saldo_inicial > vl_saldo_final
  AND result_data.max_ano <= data
  GROUP BY reg_ans) as result_despesa,
  operadora
WHERE result_despesa.reg_ans = operadora.reg_ans
ORDER BY despesa DESC
LIMIT 10;

-- interpretação 2

-- lista 10 operadoras que tiveram maior despesa com o evento informado no último trimeste
SELECT
  operadora.reg_ans,
  razao_social,
  max_data AS trimestre,
  qtde_despesa
FROM
  -- lista despesas com o evento informado no último trimeste
  (SELECT
    reg_ans,
    MAX(data) AS max_data,
    COUNT(*) as qtde_despesa
  FROM
    -- identifica o último trimestre
    (SELECT
      MAX(data) AS max_data
    FROM demonstracao_contabil) AS result_data,
    demonstracao_contabil
  WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
  AND result_data.max_data = data
  GROUP BY reg_ans) AS result_despesa,
  operadora
WHERE result_despesa.reg_ans = operadora.reg_ans
ORDER BY qtde_despesa DESC
LIMIT 10;

-- lista 10 operadoras que tiveram maior despesa com o evento informado no último ano
SELECT
  operadora.reg_ans,
  razao_social,
  min_data as min_trimestre,
  max_data as max_trimestre,
  qtde_despesa
FROM
  -- lista despesas com o evento informado no último ano
  (SELECT
    reg_ans,
    MIN(data) AS min_data,
    MAX(data) AS max_data,
    COUNT(*) as qtde_despesa
  FROM
    -- identifica o último ano
    (SELECT
      DATE_TRUNC('YEAR', MAX(data))::DATE max_ano
    FROM demonstracao_contabil) as result_data,
    demonstracao_contabil
  WHERE descricao LIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
  AND result_data.max_ano <= data
  GROUP BY reg_ans) AS result_despesa,
  operadora
WHERE result_despesa.reg_ans = operadora.reg_ans
ORDER BY qtde_despesa DESC
LIMIT 10;