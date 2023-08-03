-- dim_item_drug_map.sql

with renamed as (
    select 
        "ITEM_CODE" as item_code,
        "DRUG_NAME" as drug_name,
        "FORM/STRENGTH" as form,
        "ATC5_Code" as code
    from {{ ref('item_drug_map') }}
),

model as (
    select
        *
    from renamed
)

select * from model