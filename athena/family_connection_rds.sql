CREATE OR REPLACE VIEW family_connection_rds AS 
SELECT
  *
, concat('db.', family, newest_version, size) as "upgrade"
FROM
  (pricing.newest_families_rds
INNER JOIN (
   SELECT
     "InstanceType"
   , "Database Engine"
   , "Database Edition"
   , "Region"
   , "Deployment Option"
   , "usageType"
   , "License Model"
   , "Memory"
   , "Storage"
   , "Operation"
   , "Instance Family"
   , "ODRate"
   , "substr"("replace"("InstanceType", 'db.', ''), 1, 1) "og_family"
   , "substr"("replace"("InstanceType", 'db.', ''), 2, 1) "og_version"
   , "substr"("replace"("InstanceType", 'db.', ''), 3) "size"
   FROM
     pricing.pricing_rds
)  f ON (("newest_families_rds"."family" = "f"."og_family") AND ("length"("substr"("InstanceType", 2, ("strpos"("InstanceType", '.') - 2))) < 2)))
