CREATE TABLE IF NOT EXISTS demonstracao_contabil (
  id SERIAL NOT NULL,
  data DATE NOT NULL,
  reg_ans INT NOT NULL,
  cd_conta_contabil INT NOT NULL,
  descricao VARCHAR(150) NOT NULL,
  vl_saldo_inicial NUMERIC(14, 2),
  vl_saldo_final NUMERIC(14, 2),
  PRIMARY KEY (id)
);