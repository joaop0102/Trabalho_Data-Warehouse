-- Query 1
SELECT
    t.ano,
    t.mes,
    a.nome AS agencia,
    ap.tipo AS tipo_apartamento,
    COUNT(*) AS total_hospedagens,
    SUM(fh.valor_faturado) AS faturamento_total,
    AVG(fh.valor_faturado) AS ticket_medio
FROM fato_hospedagem fh
INNER JOIN dim_tempo t ON t.id_tempo = fh.tempo_id
INNER JOIN dim_agencia a ON a.id_agencia = fh.agencia_id
INNER JOIN dim_apto ap ON ap.id_apartamento = fh.apartamento_id
GROUP BY t.ano, t.mes, a.nome, ap.tipo
ORDER BY t.ano, t.mes, faturamento_total DESC;

-- Query 2
SELECT
    h.nome AS hospede,
    p.descricao AS produto,
    s.descricao AS servico,
    SUM(fc.quantidade) AS quantidade_total,
    SUM(fc.valor_consumo) AS valor_total_consumido,
    AVG(fc.valor_consumo) AS consumo_medio
FROM fato_consumo fc
INNER JOIN dim_hospede h ON h.id_hospede = fc.hospede_id
INNER JOIN dim_produto p ON p.id_produto = fc.produto_id
INNER JOIN dim_servico s ON s.id_servico = fc.servico_id
GROUP BY h.nome, p.descricao, s.descricao
ORDER BY valor_total_consumido DESC;