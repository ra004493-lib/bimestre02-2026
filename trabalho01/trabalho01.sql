
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE veiculo (
    id_veiculo SERIAL PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    placa VARCHAR(7) NOT NULL UNIQUE,
    ano INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Disponivel',
    CHECK (status IN ('Disponivel', 'Alugado', 'Manutencao'))
);

CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_veiculo INT NOT NULL,
    data_reserva DATE NOT NULL,
    data_retirada DATE NOT NULL,
    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_veiculo)
        REFERENCES veiculo(id_veiculo)
);

CREATE TABLE contrato (
    id_contrato SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL UNIQUE,
    valor_total NUMERIC(10,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    CHECK (valor_total > 0),
    FOREIGN KEY (id_reserva)
        REFERENCES reserva(id_reserva)
);

CREATE TABLE pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    id_contrato INT NOT NULL,
    valor_pago NUMERIC(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    CHECK (valor_pago > 0),
    FOREIGN KEY (id_contrato)
        REFERENCES contrato(id_contrato)
);

INSERT INTO cliente (nome, cpf, telefone, email) VALUES
('João Silva','11111111111','35999990001','joao@email.com'),
('Maria Souza','22222222222','35999990002','maria@email.com'),
('Pedro Lima','33333333333','35999990003','pedro@email.com'),
('Ana Costa','44444444444','35999990004','ana@email.com'),
('Carlos Santos','55555555555','35999990005','carlos@email.com');

INSERT INTO veiculo (modelo, marca, placa, ano, status) VALUES
('Onix','Chevrolet','ABC1234',2022,'Disponivel'),
('HB20','Hyundai','DEF5678',2021,'Disponivel'),
('Corolla','Toyota','GHI9012',2023,'Alugado'),
('Argo','Fiat','JKL3456',2022,'Disponivel'),
('Compass','Jeep','MNO7890',2024,'Manutencao');

INSERT INTO reserva (id_cliente,id_veiculo,data_reserva,data_retirada) VALUES
(1,1,'2026-05-01','2026-05-05'),
(2,2,'2026-05-02','2026-05-06'),
(3,3,'2026-05-03','2026-05-07'),
(4,4,'2026-05-04','2026-05-08'),
(5,5,'2026-05-05','2026-05-09');

INSERT INTO contrato (id_reserva,valor_total,data_inicio,data_fim) VALUES
(1,800.00,'2026-05-05','2026-05-10'),
(2,700.00,'2026-05-06','2026-05-11'),
(3,1200.00,'2026-05-07','2026-05-12'),
(4,650.00,'2026-05-08','2026-05-13'),
(5,1500.00,'2026-05-09','2026-05-14');

INSERT INTO pagamento (id_contrato,valor_pago,data_pagamento,forma_pagamento) VALUES
(1,800.00,'2026-05-05','Cartao'),
(2,700.00,'2026-05-06','Pix'),
(3,1200.00,'2026-05-07','Cartao'),
(4,650.00,'2026-05-08','Dinheiro'),
(5,1500.00,'2026-05-09','Pix');


SELECT
    c.nome,
    v.modelo,
    ct.valor_total
FROM cliente c
JOIN reserva r ON c.id_cliente = r.id_cliente
JOIN veiculo v ON r.id_veiculo = v.id_veiculo
JOIN contrato ct ON r.id_reserva = ct.id_reserva;


SELECT
    forma_pagamento,
    SUM(valor_pago) AS total_recebido
FROM pagamento
GROUP BY forma_pagamento;

SELECT *
FROM veiculo
WHERE status = 'Disponivel';

SELECT
    c.nome,
    COUNT(r.id_reserva) AS quantidade_reservas
FROM cliente c
JOIN reserva r
ON c.id_cliente = r.id_cliente
GROUP BY c.nome;




