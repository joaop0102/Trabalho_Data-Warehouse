SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS fato_consumo;
DROP TABLE IF EXISTS fato_hospedagem;
DROP TABLE IF EXISTS dim_servico;
DROP TABLE IF EXISTS dim_produto;
DROP TABLE IF EXISTS dim_apto;
DROP TABLE IF EXISTS dim_tempo;
DROP TABLE IF EXISTS dim_agencia;
DROP TABLE IF EXISTS dim_hospede;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE dim_hospede (
    id_hospede INT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_agencia (
    id_agencia INT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_tempo (
    id_tempo INT PRIMARY KEY,
    ano CHAR(4) NOT NULL,
    mes CHAR(2) NOT NULL,
    dia VARCHAR(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_apto (
    id_apartamento INT PRIMARY KEY,
    numero INT NOT NULL UNIQUE,
    andar INT NOT NULL,
    tipo VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_produto (
    id_produto INT PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_servico (
    id_servico INT PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_hospedagem (
    id_hospedagem INT PRIMARY KEY,
    hospede_id INT NOT NULL,
    tempo_id INT NOT NULL,
    agencia_id INT NOT NULL,
    apartamento_id INT NOT NULL,
    motivo_viagem INT NOT NULL,
    valor_faturado DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_hospedagem_hospede FOREIGN KEY (hospede_id) REFERENCES dim_hospede(id_hospede),
    CONSTRAINT fk_hospedagem_tempo FOREIGN KEY (tempo_id) REFERENCES dim_tempo(id_tempo),
    CONSTRAINT fk_hospedagem_agencia FOREIGN KEY (agencia_id) REFERENCES dim_agencia(id_agencia),
    CONSTRAINT fk_hospedagem_apto FOREIGN KEY (apartamento_id) REFERENCES dim_apto(id_apartamento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_consumo (
    id_consumo INT PRIMARY KEY,
    tempo_id INT NOT NULL,
    hospede_id INT NOT NULL,
    apartamento_id INT NOT NULL,
    produto_id INT NOT NULL,
    servico_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_consumo DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_consumo_tempo FOREIGN KEY (tempo_id) REFERENCES dim_tempo(id_tempo),
    CONSTRAINT fk_consumo_hospede FOREIGN KEY (hospede_id) REFERENCES dim_hospede(id_hospede),
    CONSTRAINT fk_consumo_apto FOREIGN KEY (apartamento_id) REFERENCES dim_apto(id_apartamento),
    CONSTRAINT fk_consumo_produto FOREIGN KEY (produto_id) REFERENCES dim_produto(id_produto),
    CONSTRAINT fk_consumo_servico FOREIGN KEY (servico_id) REFERENCES dim_servico(id_servico)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_fato_hospedagem_hospede ON fato_hospedagem(hospede_id);
CREATE INDEX idx_fato_hospedagem_tempo ON fato_hospedagem(tempo_id);
CREATE INDEX idx_fato_hospedagem_agencia ON fato_hospedagem(agencia_id);
CREATE INDEX idx_fato_hospedagem_apto ON fato_hospedagem(apartamento_id);
CREATE INDEX idx_fato_hospedagem_valor ON fato_hospedagem(valor_faturado);

CREATE INDEX idx_fato_consumo_tempo ON fato_consumo(tempo_id);
CREATE INDEX idx_fato_consumo_hospede ON fato_consumo(hospede_id);
CREATE INDEX idx_fato_consumo_apto ON fato_consumo(apartamento_id);
CREATE INDEX idx_fato_consumo_produto ON fato_consumo(produto_id);
CREATE INDEX idx_fato_consumo_servico ON fato_consumo(servico_id);
CREATE INDEX idx_fato_consumo_valor ON fato_consumo(valor_consumo);
