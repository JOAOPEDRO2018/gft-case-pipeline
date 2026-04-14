Pipeline de Dados ANS - Arquitetura Medallion
Este repositório contém a solução do Desafio Técnico de Engenharia de Dados, focado na ingestão e processamento de dados de 
beneficiários da ANS (Agência Nacional de Saúde Suplementar) utilizando Google BigQuery e os princípios da Medallion.

Decisões Arquiteturais
A escolha do Google BigQuery como motor de processamento (OLAP) baseia-se na sua natureza colunar e 
escalabilidade massiva, ideal para cargas de trabalho analíticas e pipelines ELT. O fluxo foi estruturado 
em três camadas estritas (Medallion Architecture):

Camada Bronze (Raw)
Estratégia: Data Virtualization via EXTERNAL TABLE.

Justificativa: Em vez de internalizar o arquivo pesado imediatamente, o BigQuery lê o CSV diretamente do 
Google Cloud Storage (GCS). O encoding foi forçado para UTF-8 para evitar caracteres corrompidos. 

Camada Silver (Refined)
Estratégia: Schema Enforcement e Tipagem.

Justificativa: Conversão da tabela externa para formato nativo colunar (Capacitor/Parquet-like). Aplicação de contratos 
de dados rígidos utilizando CAST explícito (ex: INT64 para métricas, DATE para data de carga) e padronização da nomenclatura.

Camada Gold (Curated / Data Mart)
Estratégia: Data Pruning e Particionamento.

Justificativa: A tabela foi desenhada exclusivamente para responder a análises de beneficiários da carteira atual.

Filtro de Ruído: Aplicação da regra de negócio WHERE qt_beneficiarios_ativos > 0, removendo registros históricos zerados
antes que cheguem à camada de BI, reduzindo o custo de scaneamento.

Performance: Tabela particionada (PARTITION BY dt_carga) para otimizar I/O em consultas temporais futuras.

Execução do Pipeline
Em um ambiente de produção corporativo, este pipeline (DAG) seria orquestrado pelo Apache Airflow ou via dbt Core, 
executando os scripts localizados na pasta /sql na seguinte sequência de dependência:
01_bronze_layer.sql ➔ 02_silver_layer.sql ➔ 03_gold_layer.sql

Resultados das Análises 
As respostas para as perguntas de negócio encontram-se na pasta /analises.
(Nota: Embora as perguntas B e C não citassem explicitamente beneficiários "ativos", 
a principio assumiu-se como premissa o cálculo sobre a carteira de ativos, 
sendo necessário a confirmação, posterior, do cliente para eventual esclarecimento).

