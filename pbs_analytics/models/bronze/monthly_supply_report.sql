SELECT 
    * 
FROM {{ source('pbs', 'raw_monthly_supply_report') }}