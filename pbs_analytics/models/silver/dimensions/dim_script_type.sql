-- dim_script_type.sql

with source as (
    select * from {{ ref('monthly_supply_report') }}
),

renamed as (
    select distinct
        -- script type
        script_type as script_type_id
    from source
),

model as (
    select
        *,
        -- different script types
        case 
            when script_type_id = 'UNDER CO-PAYMENT' then 'Scripts where the government contribution is zero'
            when script_type_id = 'ABOVE CO-PAYMENT' then 'Scripts where cost is above the threshold of the PBS co-payment amount in each year'
        end as script_type_description
    from renamed
)

select * from model