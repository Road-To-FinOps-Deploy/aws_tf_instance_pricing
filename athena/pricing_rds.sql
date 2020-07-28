CREATE OR REPLACE VIEW pricing_rds AS 
SELECT
  "replace"("od_pricedata_rds"."col19", '"') "InstanceType"
, "replace"("od_pricedata_rds"."col34", '"') "Database Engine"
, "replace"("od_pricedata_rds"."col35", '"') "Database Edition"
, "replace"("od_pricedata_rds"."col17", '"') "Region"
, "replace"("od_pricedata_rds"."col37", '"') "Deployment Option"
, "replace"("od_pricedata_rds"."col40", '"') "usageType"
, "replace"("od_pricedata_rds"."col36", '"') "License Model"
, "replace"("od_pricedata_rds"."col25", '"') "Memory"
, "replace"("od_pricedata_rds"."col26", '"') "Storage"
, "replace"("od_pricedata_rds"."col47", '"') "Operation"
, "replace"("od_pricedata_rds"."col21", '"') "Instance Family"
, "replace"("od_pricedata_rds"."col9", '"') "ODRate"
FROM
  pricing.od_pricedata_rds
