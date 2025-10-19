SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


--MISSION 1 (Query5) ¿Cuáles son las primeras 10 observaciones registradas?;
    SELECT * FROM observations LIMIT 10;

-- MISSION 2 (Query7) ¿Qué identificadores de región (region_id) aparecen en los datos?;
    SELECT DISTINCT region_id FROM observations;

-- MISSION 3 (Query9) ¿Cuántas especies distintas (species_id) se han observado?;
    SELECT COUNT(DISTINCT species_id) AS total_species FROM observations;

-- MISSION 4 (Query11) ¿Cuántas observaciones hay para la región con region_id = 2?;
    SELECT COUNT(*) FROM observations WHERE region_id = 2;

-- MISSION 5 (Query13) ¿Cuántas observaciones se registraron el día 1998-08-08?;
    SELECT COUNT(*) FROM observations WHERE observation_date = '1998-08-08';

-- MISSION 6 (Query15) ¿Cuál es el region_id con más observaciones?;
   SELECT region_id, COUNT(*) AS total FROM observations 
   GROUP BY region_id ORDER BY total DESC LIMIT 1;

-- MISSION 7 (Query17) ¿Cuáles son los 5 species_id más frecuentes?;
    SELECT species_id, COUNT(*) AS total from observations
    GROUP BY  species_id ORDER BY total DESC LIMIT 5;

-- MISSION 8 (Query19) ¿Qué especies (species_id) tienen menos de 5 registros?;
    SELECT species_id, COUNT(*) AS total FROM observations
    GROUP BY species_id HAVING total < 5 ORDER BY total;

-- MISION 9 (Query21) ¿Qué observadores (observer) registraron más observaciones?;
   SELECT observer, COUNT(*) AS total FROM observations 
   GROUP BY observer ORDER BY total;

-- MISION 10 (Query23) Muestra el nombre de la región (regions.name) para cada observación.;
    SELECT observations.id, regions.name FROM observations
    JOIN regions ON observations.region_id = regions.id;

-- MISION 11 (Query25) Muestra el nombre científico de cada especie registrada;
    SELECT observations.id, species.scientific_name FROM observations
    JOIN species ON observations.species_id = species.id;

-- MISION 12 (Query27) ¿Cuál es la especie más observada por cada región?;
SELECT
    common_name,
    total_specie,
    region
FROM (
    SELECT species.common_name, AS specie, regions.name AS region,
    COUNT(observations.species_id) AS total_specie, 
    RANK() OVER (PARTITION BY region ORDER BY COUNT(total_specie) DESC) as species_rank
    FROM observations JOIN species ON observations.species_id = species.id
    JOIN regions ON observations.region_id = regions.id
    GROUP BY region, specie) AS RankedObservations WHERE 
    species_rank = 1;
    -- No encuentro la manera de mostrar solo la especie más observada por cada región;


-- MISION 13 (Query29) Inserta una nueva observación ficticia en la tabla observations.;
    INSERT INTO observations (species_id, region_id, observer, observation_date, latitude, longitude)
    VALUES (10, 10, 'obsr251095', '2025-10-15', 77.978, -77.0160);

-- MISION 14 (Query31) Corrige el nombre científico de una especie con error tipográfico.;
    UPDATE species SET scientific_name = 'Pelecanus conspicillatus'
    WHERE scientific_name = 'Pelecanus conspicillatus';
-- MISION 15 (Query33) Elimina una observación de prueba (usa su id).;
    DELETE FROM observations WHERE id = '365';
