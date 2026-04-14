CREATE OR REPLACE EXTERNAL TABLE `gft-data-pipeline.bronze_layer.tab_ans_benef`
OPTIONS (
  format = 'CSV',
  uris = ['gs://gft-data-bronze/pda-024-icb-TO-2025_08.csv'],
  skip_leading_rows = 1,
  field_delimiter = ';', 
  encoding = 'UTF8', 
  max_bad_records = 0
);
