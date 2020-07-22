CREATE OR REPLACE VIEW pricing AS 
SELECT
  "sp"."location" "Region"
, "sp"."discountedoperation" "OS"
, "replace"("od"."col18", '"') "InstanceType"
, "replace"("od"."col35", '"') "Tenancy"
, "replace"("od"."col9", '"') "ODRate"
, "sp"."discountedrate" "SPRate"
, "replace"("od"."col37", '"') "OS2"
, "replace"("od"."col48", '"') "CapacityStatus"
, "replace"("od"."col46", '"') "usageType"
, "replace"("od"."col76", '"') "PreInstalledSW"
, "replace"("od"."col47", '"') "Operation"
FROM
  (pricing.sp_pricedata sp
INNER JOIN pricing.od_pricedata od ON (("sp"."discountedusagetype" = "replace"("od"."col46", '"')) AND ("sp"."discountedoperation" = "replace"("od"."col47", '"'))))
WHERE (((("od"."col9" IS NOT NULL) AND (NOT ("sp"."location" LIKE 'Any'))) AND ("sp"."purchaseoption" LIKE 'No Upfront')) AND ("sp"."leasecontractlength" = 1))
