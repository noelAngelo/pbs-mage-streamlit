-- fct_number_of_prescriptions.sql

with source as (
    select
        didm.item_code,
        dpc.patient_category_id,
        dsd.supply_timestamp,
        sum(msr.prescriptions) as number_of_prescriptions
    from {{ ref('monthly_supply_report') }} msr
    join {{ ref('dim_item_drug_map') }} didm on msr.item_code = didm.item_code
    join {{ ref('dim_patient_category') }} dpc on msr.patient_cat = dpc.patient_category_id
    join {{ ref('dim_supply_date') }} dsd on msr.month_of_supply = dsd.date_id::integer
    group by didm.item_code, dpc.patient_category_id, dsd.supply_timestamp
)
select * from source