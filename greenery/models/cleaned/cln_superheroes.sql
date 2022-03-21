{{
  config(
    materialized='table'
  )
}}

SELECT 
    id AS superhero_guid
    , name as superhero_name
    , gender as superhero_gender
    , eye_color as superhero_eye_color
    , race as superhero_race
    , hair_color as superhero_hair_color
    , NULLIF(height, -99) as superhero_height
    , publisher as superhero_publisher
    , skin_color as superhero_skin_color
    , alignment as superhero_alignment
    , NULLIF(weight, -99) as superhero_weight
    , created_at as created_at_utc
    , updated_at as updated_at_utc

FROM {{ source('tutorial', 'superheroes') }}