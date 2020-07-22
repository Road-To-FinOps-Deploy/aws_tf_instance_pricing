SELECT
        line_item_usage_account_id,
         product_instance_type,
         product_operating_system,
         product_location,
         sum(line_item_usage_amount) AS line_item_usage_amount,
         sum(line_item_unblended_cost) AS line_item_unblended_cost,
         odrate, pricing_public_on_demand_rate,
         sum(cast(odrate AS decimal(10,
        5))*line_item_usage_amount) as calc_charge
FROM "$cur.database"."$cur.table" AS kpmg
LEFT JOIN "pricingdev"."pricing"
    ON kpmg.product_location=pricing.region
        AND kpmg.product_operating_system=pricing.os2
        AND kpmg.product_instance_type=pricing.instancetype
        AND kpmg.product_tenancy=pricing.tenancy
        AND kpmg.product_pre_installed_sw=pricing.PreInstalledSW
        and kpmg.product_capacitystatus=pricing.CapacityStatus
        and kpmg.product_usagetype=pricing.usageType
        and kpmg.pricing_public_on_demand_rate=pricing.odrate
WHERE month = '5'
        AND year = '2020'
        AND line_item_product_code = 'AmazonEC2'
        AND product_instance_type <> ''
        AND line_item_line_item_type = 'Usage'
        AND line_item_operation like 'RunInstances%'
        AND pricing_term = 'OnDemand'
        AND pricing_unit = 'Hrs'

GROUP BY  line_item_usage_account_id, 
product_instance_type, product_operating_system,product_location, odrate, pricing_public_on_demand_rate
ORDER BY   product_instance_type limit 20


-----------------------------------------------------


-- join to make rate card
 SELECT f.InstanceType, f.family, f.newest_version,f.Region, f.Tenancy, f.CapacityStatus, f.PreInstalledSW,  ODRate as Origonal_Rate, Upgrade, Rate as New_Rate  FROM "pricingdev"."family_connection" as f
  join (
   select InstanceType, OS2 as OS, Region, ODRate as Rate, "Tenancy"
   , "CapacityStatus"
   , "PreInstalledSW"
   FROM "pricingdev"."pricing"
   ) as P
  on P.OS = f.OS2
  and P.InstanceType= f.upgrade
  and P.Region= f.Region
   and P.Tenancy= f.Tenancy
    and P.CapacityStatus= f.CapacityStatus
    and P.PreInstalledSW= f.PreInstalledSW


-------------------

-- TOGETHER

SELECT 
         line_item_usage_account_id,
         product_instance_type,
         product_operating_system,
         product_location,
         sum(line_item_usage_amount) AS line_item_usage_amount,
         sum(line_item_unblended_cost) AS line_item_unblended_cost,
         Origonal_Rate,
         Upgrade,
         New_Rate,
         sum(cast(Origonal_Rate AS decimal(10,
         5))*line_item_usage_amount) AS old_charge,
         sum(cast(New_Rate AS decimal(10,
         5))*line_item_usage_amount) AS new_charge
FROM "$cur.database"."$cur.table" AS kpmg
LEFT JOIN 
    (SELECT f.InstanceType,
         f.family,
         f.newest_version,
         f.Region,
         f.Tenancy,
         f.CapacityStatus,
         f.PreInstalledSW,
         f.OS2,
         ODRate AS Origonal_Rate,
         Upgrade, p.operation,
         Rate AS New_Rate
    FROM "pricingdev"."family_connection" AS f
    JOIN 
        (SELECT InstanceType,
         OS2 AS OS,
         Region,
         ODRate AS Rate,
         operation,
         "Tenancy" ,
         "CapacityStatus" ,
         "PreInstalledSW", 
          usageType
        FROM "pricingdev"."pricing" ) AS P
            ON P.OS = f.OS2
                AND P.InstanceType= f.upgrade
                AND P.Region= f.Region
                AND P.Tenancy= f.Tenancy
                AND P.CapacityStatus= f.CapacityStatus
                AND P.PreInstalledSW= f.PreInstalledSW
                AND P.operation=f.operation ) AS Rate_card
        ON kpmg.product_location=Rate_card.region
        AND kpmg.product_operating_system=Rate_card.os2
        AND kpmg.product_instance_type=Rate_card.instancetype
        AND kpmg.product_tenancy=Rate_card.tenancy
        AND kpmg.product_pre_installed_sw=Rate_card.PreInstalledSW
        and kpmg.product_capacitystatus=Rate_card.CapacityStatus
        and kpmg.product_operation=Rate_card.Operation
 WHERE if((date_format(current_timestamp , '%M') = 'January'), month = '12', month = CAST((month(now())-1) AS VARCHAR) )
            AND if((date_format(current_timestamp , '%M') = 'January'), year = CAST((year(now())-1) AS VARCHAR) ,year = CAST(year(now()) AS VARCHAR))        AND line_item_product_code = 'AmazonEC2'
        and product_instance_type_family <> ''
        AND line_item_line_item_type = 'Usage'
        AND pricing_term = 'OnDemand'
        AND pricing_unit = 'Hrs'
GROUP BY  line_item_usage_account_id, product_instance_type, product_operating_system,product_location,Origonal_Rate, Upgrade, New_Rate
ORDER BY product_instance_type 