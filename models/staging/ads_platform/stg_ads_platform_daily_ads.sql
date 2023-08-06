WITH source AS (

    SELECT * FROM {{ source('ads_platform', 'daily_ads') }}

),

renamed AS (

    SELECT
        date,
        campaign_id,
        {{ dbt_utils.generate_surrogate_key(['date', 'campaign_id']) }} AS surrogate_key,
        spend,
        cpm,
        ctr,
        -- Assumes that there are no gaps in dates for a campaign
        {{ rolling_aggregate('spend', 'campaign_id', 'date', 'sum', 7) }}

    FROM source

)

SELECT * FROM renamed
