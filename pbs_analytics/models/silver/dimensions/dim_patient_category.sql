-- dim_patient_category.sql

with source as (
    select * from {{ ref('monthly_supply_report') }}
),

renamed as (
    select distinct
        -- category
        patient_cat as patient_category_id
    from source
),

model as (
    select
        *,
        -- different patient categories
        case
            when patient_category_id = 'C0' then 'Concessional safety net'
            when patient_category_id = 'C1' then 'Concessional non-safety net'
            when patient_category_id = 'DB' then 'Prescriber Bag'
            when patient_category_id = 'G1' then 'General safety net'
            when patient_category_id = 'G2' then 'General non-safety net'
            when patient_category_id = 'R0' then 'RPBS safety net'
            when patient_category_id = 'R1' then 'RPBS non-safety net'
            when patient_category_id = 'UK' then 'Patient category could not be determined'
            else null -- handle any other cases
        end as patient_category_value
    from renamed
)
select * from model