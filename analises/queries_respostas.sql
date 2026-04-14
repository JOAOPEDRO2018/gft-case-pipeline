select id_operadora, razao_social, sum(qt_beneficiario_ativo) soma_ativos from gft-data-pipeline.gold_layer.analise_benef
group by all
order by soma_ativos desc
limit 5


select ab.faixa_etaria, sum(ab.qt_beneficiario_ativo) total_ativo from gft-data-pipeline.gold_layer.analise_benef ab
group by all
order by total_ativo desc
limit 1


select ab.id_municipio, nm_municipio, uf,  sum(ab.qt_beneficiario_ativo) total_ativo from gft-data-pipeline.gold_layer.analise_benef ab
group by all
order by total_ativo desc

