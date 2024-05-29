
--Ecrire dans le terminal le code au dessus pour utiliser Pig MapReduce
pig x- MapReduce

-- Charger les données brutes à partir du fichier spécifié en utilisant PigStorage avec une virgule comme séparateur
raw_data = LOAD '/user/cloudera/rawdata/airline/flight' USING PigStorage(',') AS 
	(year:chararray, month:chararray, dayOfMonth:chararray, dayOfWeek:chararray, DepTime:chararray,
	CRSDepTime:chararray, ArrTime:chararray, CRSArrTime:chararray, UniqueCarrier:chararray, FlightNum:chararray,
	TailNum:chararray, ActualElapsedTime:chararray, CRSElapsedTime:chararray, AirTime:chararray, ArrDelay:chararray,
	DepDelay:chararray, Origin:chararray, Dest:chararray, Distance:chararray, TaxiIn:chararray, TaxiOut:chararray,
	Cancelled:chararray, CancellationCode:chararray, Diverted:chararray, CarrierDelay:chararray, WeatherDelay:chararray,
	NASDelay:chararray, SecurityDelay:chararray, LateAircraftDelay:chararray);

-- Filtrer les données pour exclure les en-têtes (lignes où l'année est 'Year')
headless_data = FILTER raw_data BY (year != 'Year');

-- Générer les données filtrées avec des valeurs par défaut pour les champs manquants ('NA')
rel_data = FOREACH headless_data GENERATE 
    year, 
    month, 
    dayOfMonth, 
    dayOfWeek, 
    (DepTime == 'NA' OR DepTime IS NULL ? '0' : DepTime) AS depTime,
    (CRSDepTime == 'NA' OR CRSDepTime IS NULL ? '0' : CRSDepTime) AS crsDepTime,
    (ArrTime == 'NA' OR ArrTime IS NULL ? '0' : ArrTime) AS arrTime,
    (CRSArrTime == 'NA' OR CRSArrTime IS NULL ? '0' : CRSArrTime) AS crsArrTime,
    (UniqueCarrier == 'NA' OR UniqueCarrier IS NULL ? '0' : UniqueCarrier) AS UniqueCarrier,
    (FlightNum == 'NA' OR FlightNum IS NULL ? '0' : FlightNum) AS FlightNum,
    (TailNum == 'NA' OR TailNum IS NULL ? '0' : TailNum) AS TailNum,
    (ActualElapsedTime == 'NA' OR ActualElapsedTime IS NULL ? '0' : ActualElapsedTime) AS ActualElapsedTime,
    (CRSElapsedTime == 'NA' OR CRSElapsedTime IS NULL ? '0' : CRSElapsedTime) AS CRSElapsedTime,
    (AirTime == 'NA' OR AirTime IS NULL ? '0' : AirTime) AS AirTime,
    (ArrDelay == 'NA' OR ArrDelay IS NULL ? '0' : ArrDelay) AS ArrDelay,
    (DepDelay == 'NA' OR DepDelay IS NULL ? '0' : DepDelay) AS DepDelay,
    (Origin == 'NA' OR Origin IS NULL ? '0' : Origin) AS Origin,
    (Dest == 'NA' OR Dest IS NULL ? '0' : Dest) AS Dest,
    (Distance == 'NA' OR Distance IS NULL ? '0' : Distance) AS Distance,
    (TaxiIn == 'NA' OR TaxiIn IS NULL ? '0' : TaxiIn) AS TaxiIn,
    (TaxiOut == 'NA' OR TaxiOut IS NULL ? '0' : TaxiOut) AS TaxiOut,
    (Cancelled == 'NA' OR Cancelled IS NULL ? '0' : Cancelled) AS Cancelled,
    (CancellationCode == 'NA' OR CancellationCode IS NULL ? '0' : CancellationCode) AS CancellationCode,
    (Diverted == 'NA' OR Diverted IS NULL ? '0' : Diverted) AS Diverted,
    (CarrierDelay == 'NA' OR CarrierDelay IS NULL ? '0' : CarrierDelay) AS CarrierDelay,
    (WeatherDelay == 'NA' OR WeatherDelay IS NULL ? '0' : WeatherDelay) AS WeatherDelay,
    (NASDelay == 'NA' OR NASDelay IS NULL ? '0' : NASDelay) AS NASDelay,
    (SecurityDelay == 'NA' OR SecurityDelay IS NULL ? '0' : (int)SecurityDelay) AS SecurityDelay,
    (LateAircraftDelay == 'NA' OR LateAircraftDelay IS NULL ? '0' : LateAircraftDelay) AS LateAircraftDelay;
-- Stocker les données traitées dans le dossier de sortie spécifié en utilisant PigStorage avec une virgule comme séparateur
STORE rel_data INTO '/user/cloudera/output/airline/flight' USING PigStorage(',');
-- STORE rel_date INTO 'airline.txt_flight' USING org.apache.hive.hcatalog.pig.HCatStorer(); -- Stocker les données dans Hive (commenté)
