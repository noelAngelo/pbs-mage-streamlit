-- dim_date.sql

with source as (
    select * from {{ ref('monthly_supply_report') }}
),

renamed as (
    
    select distinct
        -- date
        month_of_supply::text as date_id
    from source
),

extracted as (
    select
        *,
        -- extracted year
        SUBSTRING(date_id, 1, 4)::integer as supply_year,
        -- extracted month
        SUBSTRING(date_id, 5)::integer as supply_month
    from renamed
),

model as (
    select
        *,
        -- extract timestamp
        make_timestamp(supply_year, supply_month, 1, 0, 0, 0) as supply_timestamp
    from extracted
)

select 
    *,
    TO_CHAR(supply_timestamp, 'Day') as weekday
from model