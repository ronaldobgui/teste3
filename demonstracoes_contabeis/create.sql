CREATE TABLE IF NOT EXISTS demonstracao_contabil (
  id SERIAL NOT NULL,
  data DATE NOT NULL,
  reg_ans VARCHAR(8) NOT NULL,
  cd_conta_contabil VARCHAR(9) NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  vl_saldo_inicial NUMERIC(14, 2),
  vl_saldo_final NUMERIC(14, 2),
  PRIMARY KEY (id)
);