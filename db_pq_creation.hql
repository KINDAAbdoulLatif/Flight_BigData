--Utiliser la table airline
use airline;

-- Créer une table externe pour les transporteurs
create external table pq_carriers (
    cdde varchar(4), 
    description varchar(30)
) 
stored as parquet
location '/user/cloudera/output/airline/carriers';

-- Insérer les données dans la table pq_carriers en excluant les en-têtes
insert overwrite table pq_carriers 
select * from txt_carriers where cdde <> 'Code';

-- Créer une table externe pour les informations des avions
create external table pq_plane_info (
    tailnum varchar(4), 
    type varchar(30),
    manufacturer string,
    issue_date varchar(16), 
    model varchar(10), 
    status varchar(10),
    aircraft_type varchar(30),
    pyear int
)  
stored as parquet
location '/user/cloudera/output/airline/plane_infos';

-- Insérer les données dans la table pq_plane_info en excluant les en-têtes
insert overwrite table pq_plane_info
select * from txt_plane_info where tailnum <> 'tailnum';

-- Créer une table externe pour les aéroports
create external table pq_airports (
    iata string, 
    airport string, 
    city string,
    state string, 
    country string, 
    geolat float, 
    geolong float
)
stored as parquet
location '/user/cloudera/output/airline/airports';

-- Insérer les données dans la table pq_airports en excluant les en-têtes
insert overwrite table pq_airports
select * from airports where iata <> 'iata';

-- Créer une table externe pour les vols (à exécuter depuis Impala)
create external table pq_flight 
    (year smallint, month tinyint, dayofmonth tinyint, dayofweek tinyint,
    deptime smallint, crsdeptime smallint, arrtime smallint, crsarrtime smallint, 
    uniquecarrier string, flightnum string, tailnum string, actualelapsedtime smallint,
    crselapsedtime smallint, airtime smallint, arrdelay smallint, depdelay smallint, 
    origin string, dest string, distance smallint, taxiin string, taxiout string,
    cancelled string, cancellationcode string, diverted string, carrierdelay smallint,
    weatherdelay smallint, nasdelay smallint, securitydelay smallint, lateaircraftdelay smallint)
stored as parquet
location '/user/cloudera/output/airline/pq_flight';

-- Insérer les données dans la table pq_flight
insert overwrite table pq_flight 
select * from txt_flight;
