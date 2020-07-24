 CREATE
        OR REPLACE VIEW newest_families_rds AS
WITH dataset AS 
    (SELECT "multimap_agg"("A",
         "B") "dict"
    FROM 
        (SELECT DISTINCT "substr"("InstanceType",
         1,
         1) "A" ,
         "substr"("InstanceType",
         2,
         ("strpos"("InstanceType",
         '.') - 2)) "B"
        FROM 
            (SELECT DISTINCT replace("InstanceType",
         'db.', '') as InstanceType
            FROM pricing.pricing_rds ) )
            WHERE ("length"("B") < 2) )
        SELECT "t"."family" ,
         "array_max"("version") "newest_version"
    FROM (dataset
    CROSS JOIN UNNEST("dict") t (family, version))
GROUP BY  "t"."family", "version" 