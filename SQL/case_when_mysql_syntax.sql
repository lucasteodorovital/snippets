SELECT 
    t2.identificador as identificador
    ,t1.idade_default as idade_default
    ,t4.data_default
    ,t3.idade_meses_max

FROM (SELECT
	t1.identificador, 
    min(t1.idade_default) as idade_default
FROM (SELECT 
	identificador,
	CASE
	    WHEN flag_default = 0 THEN null
	    WHEN flag_default = 1 THEN TIMESTAMPDIFF(MONTH, data_cessao, data_referencia) + DATEDIFF(data_referencia,data_cessao + INTERVAL TIMESTAMPDIFF(MONTH, data_cessao, data_referencia) MONTH)/DATEDIFF(data_cessao + INTERVAL TIMESTAMPDIFF(MONTH, data_cessao, data_referencia) + 1 MONTH, data_cessao + INTERVAL TIMESTAMPDIFF(MONTH, data_cessao, data_referencia) MONTH)
    END AS idade_default
FROM carteira_varejo_analitica) t1
GROUP BY 1) t1

INNER JOIN carteira_varejo_analitica t2
ON t1.identificador = t2.identificador

INNER JOIN (
    SELECT 
		identificador,
		max(idade_meses) AS idade_meses_max
	FROM carteira_varejo_analitica cva 
	GROUP BY 1 ) t3
ON t1.identificador = t3.identificador

LEFT JOIN (SELECT
    identificador,
    min(data_referencia) as data_default
FROM carteira_varejo_analitica
WHERE flag_default = 1
GROUP BY identificador) t4
ON t1.identificador = t4.identificador

GROUP BY 1,2,3