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
    , height as superhero_height
    , publisher as superhero_publisher
    , skin_color as superhero_skin_color
    , alignment as superhero_alignment
    , weight as superhero_weight

FROM {{ source('tutorial', 'superheroes') }}