SELECT 
  t1.*,
  (t1.`ultimo_valor_pago_mes`-t1.`valor_pago_mes_ant`) pmt
FROM (
  SELECT 
    t1.`identificador`,
    t1.`data_cessao`,
    t1.`safra_referencia`,
    t1.`ultimo_valor_pago_mes`,
    LAG(t1.`ultimo_valor_pago_mes`, 1) OVER (
          PARTITION BY t1.`identificador`
          ORDER BY t1.`safra_referencia`
      ) valor_pago_mes_ant
  FROM (
    SELECT 
        t1.`identificador`,
        t1.`data_cessao`,
        t1.`valor_pago` as valor_pago,
        t1.`data_referencia`,
        t1.`safra_referencia`,
        LAST_VALUE(t1.`valor_pago`) OVER ( # último valor pago em cada mês
          PARTITION BY t1.identificador, t1.`safra_referencia`
            ORDER BY t1.`data_referencia`
            RANGE BETWEEN
          UNBOUNDED PRECEDING AND
                UNBOUNDED FOLLOWING
        ) AS ultimo_valor_pago_mes
    FROM 
    (
      SELECT 
          `identificador`, 
          `valor_pago`,
          `data_cessao`,
          `data_referencia`,
           DATE_FORMAT(`data_referencia` ,'%Y-%m-01') safra_referencia
      FROM carteira_varejo_analitica
      WHERE status = "Ativo" #AND produto in ("TOMATICO-VARIAVEL", "TOMATICO FIXO")
    ) t1 
  ) t1
  GROUP BY 1,2,3,4
) t1