CREATE OR REPLACE VIEW family_connection AS 
SELECT
  *
, "concat"("family", "newest_version", "size") "upgrade"
FROM
  (pricing.newest_families
INNER JOIN (
   SELECT
     "InstanceType"
   , "OS2"
   , "ODRate"
   , "Region"
   , "Tenancy"
   , "CapacityStatus"
   , "PreInstalledSW"
   , "usageType"
   , "operation"
   , "substr"("InstanceType", 1, 1) "og_family"
   , "substr"("InstanceType", 2, 1) "og_version"
   , "substr"("InstanceType", 3) "size"
   FROM
     pricing.pricing
)  f ON (("newest_families"."family" = "f"."og_family") AND ("length"("substr"("InstanceType", 2, ("strpos"("InstanceType", '.') - 2))) < 2)))
