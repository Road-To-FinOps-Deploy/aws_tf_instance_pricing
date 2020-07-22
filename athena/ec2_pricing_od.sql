CREATE EXTERNAL TABLE IF NOT EXISTS pricingdev.ec2_od (
  `region` string,
  `type` string,
  `os` string,
  `price` decimal(38,18)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
) LOCATION 's3://<CUR BUCKET>/Pricing/EC2/On_Demand_Pricing/'
TBLPROPERTIES ('has_encrypted_data'='false', 'skip.header.line.count'='1');