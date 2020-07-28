
-- Rate card
SELECT f.InstanceType,
         f.family,
         f.newest_version,
         f.Region,
         f."deployment option",
         f."license model",
         f."database edition",
         f."Database Engine",
         ODRate AS Origonal_Rate,
         Upgrade, 
         p.operation,
         Rate AS New_Rate
    FROM "pricing"."family_connection_rds" AS f
    JOIN 
        (SELECT InstanceType,
         "Database Engine",
         Region,
         ODRate AS Rate,
         operation,
         "deployment option" ,
         "license model" ,
         "database edition", 
          usageType
        FROM "pricing"."pricing_rds" )
        AS P
            ON P."Database Engine" = f."Database Engine"
                AND P.InstanceType= f.upgrade
                AND P.Region= f.Region
                AND P."deployment option"= f."deployment option"
                AND P."license model"= f."license model"
                AND P."database edition"= f."database edition"

                            
                
-- TOGETHER

SELECT accounts.project,
         line_item_usage_account_id,
         product_instance_type,
         product_database_engine,
         product_deployment_option,
         product_database_edition,
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
FROM "Database_value"."cur" AS kpmg
LEFT JOIN "Database_value"."accounts"
    ON kpmg.line_item_usage_account_id = accounts."account id"
LEFT JOIN 
    (SELECT f.InstanceType,
         f.family,
         f.newest_version,
         f.Region,
         f."deployment option",
         f."license model",
         f."database edition",
         f."Database Engine",
         ODRate AS Origonal_Rate,
         Upgrade, 
         p.operation,
         Rate AS New_Rate
    FROM "pricing"."family_connection_rds" AS f
    JOIN 
        (SELECT InstanceType,
         "Database Engine",
         Region,
         ODRate AS Rate,
         operation,
         "deployment option" ,
         "license model" ,
         "database edition", 
          usageType
        FROM "pricing"."pricing_rds" )
        AS P
            ON P."Database Engine" = f."Database Engine"
                AND P.InstanceType= f.upgrade
                AND P.Region= f.Region
                AND P."deployment option"= f."deployment option"
                AND P."license model"= f."license model"
                AND P."database edition"= f."database edition"

                ) AS Rate_card
        ON kpmg.product_location=Rate_card.region
        AND kpmg.product_database_engine=Rate_card."Database Engine"
        AND kpmg.product_instance_type=Rate_card.instancetype
        AND kpmg.product_deployment_option=Rate_card."deployment option"
        AND kpmg.product_database_edition=Rate_card."database edition"
        and kpmg.product_license_model=Rate_card."license model"
        
 WHERE if((date_format(current_timestamp , '%M') = 'January'), month = '12', month = CAST((month(now())-1) AS VARCHAR) )
            AND if((date_format(current_timestamp , '%M') = 'January'), year = CAST((year(now())-1) AS VARCHAR) ,year = CAST(year(now()) AS VARCHAR)) AND line_item_product_code = 'AmazonRDS'
        and product_instance_type_family <> ''
        AND line_item_line_item_type = 'Usage'
        AND pricing_term = 'OnDemand'
        AND pricing_unit = 'Hrs'
       -- AND accounts.project = 'EMX'
GROUP BY  line_item_usage_account_id, product_instance_type, product_deployment_option, product_database_engine,product_database_edition,  product_location, accounts.project, Origonal_Rate, Upgrade, New_Rate
ORDER BY  accounts.project, product_instance_type