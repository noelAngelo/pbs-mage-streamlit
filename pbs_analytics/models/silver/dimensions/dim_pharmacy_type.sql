-- dim_pharmacy_type.sql

with source as (
    select * from {{ ref('supplementary_supply_report') }}
),

renamed as (
    select distinct
        -- pharmacy type
        phrmcy_type as pharmacy_type_id
    from source
),

model as (
    select
        *,
        -- different pharmacy types
        case
            WHEN pharmacy_type_id = 'S90' THEN 'Community pharmacies and friendly societies'
            WHEN pharmacy_type_id = 'S92' THEN 'Approved medical practitioners'
            WHEN pharmacy_type_id = 'S94 PRI' THEN 'Private hospitals'
            WHEN pharmacy_type_id = 'S94 PUB' THEN 'Public hospitals'
            else null -- handle any other cases
        end as pharmacy_type_value
    from renamed
)
select * from model