-- dim_drug_type.sql

with source as (
    select * from {{ ref('supplementary_supply_report') }}
),

renamed as (
    select distinct
        -- drug type
        drug_type as drug_type_id
    from source
),

model as (
    select
        *,
        -- different drug types
        case 
            WHEN drug_type_id = 'DB' THEN 'Prescriber Bag'
            WHEN drug_type_id = 'DT' THEN 'Dental'
            WHEN drug_type_id = 'EP' THEN 'Extemporaneously Prepared'
            WHEN drug_type_id = 'GE' THEN 'General Schedule'
            WHEN drug_type_id = 'OT' THEN 'Optometrical'
            WHEN drug_type_id = 'PL' THEN 'Palliative Care'
            WHEN drug_type_id = 'R1' THEN 'RPBS Schedule'
            WHEN drug_type_id = 'RN' THEN 'Unlisted RPBS items'
            WHEN drug_type_id = 'UK' THEN 'Unknown'
            else NULL
        end as drug_type_description
    from renamed
)

select * from model