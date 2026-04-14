CREATE OR REPLACE TABLE gft-data-pipeline.gold_layer.analise_benef
PARTITION BY dt_carga 
AS
SELECT
    id_operadora,
    razao_social,
    UF,
    id_municipio,
    nm_municipio,
    faixa_etaria,
    qt_beneficiario_ativo,
    dt_carga
FROM gft-data-pipeline.silver_layer.refined_ans_benef
WHERE qt_beneficiario_ativo > 0; 
