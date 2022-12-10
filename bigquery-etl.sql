/*join all dataset that start from '202'
*/

CREATE TABLE `bike_dataset.joined_dataset` AS(
SELECT * FROM `bike_dataset.202*`
);

/*create bike_trip table from joined_dataset and perform data transformation */
CREATE TABLE `bike_dataset.bike_trip` AS (
    SELECT a.ride_id,
           a.rideable_type,
           a.started_at,
           a.ended_at,
           a.start_station_name,
           a.start_station_id,
           a.end_station_name,
           a.end_station_id,
           a.start_lat,
           a.start_lng,
           a.end_lat,
           a.end_lng,
           a.member_casual,
        TIMESTAMP_DIFF(a.ended_at, a.started_at, SECOND) AS trip_duration,
        EXTRACT(YEAR FROM a.started_at) AS YEAR,
        EXTRACT(MONTH FROM a.started_at) AS MO,
        EXTRACT(DAY FROM a.started_at) AS DY,
        EXTRACT(HOUR FROM a.started_at) AS HR,
        EXTRACT(DAYOFWEEK FROM a.started_at) AS day_start,
    FROM `bike_dataset.joined_dataset` AS a
    ORDER BY started_at DESC
);

/* join weather table to bike_trip table */
CREATE OR REPLACE TABLE `acoustic-portal-322707.bike_dataset.bike_trip` AS (
SELECT a.*, b.T2M, b.RH2M, b.PRECTOTCORR, b.WS10M
FROM `acoustic-portal-322707.bike_dataset.bike_trip` AS a
JOIN `acoustic-portal-322707.bike_dataset.weather_chicago_beta`  AS b
ON a.YEAR = b.YEAR AND
   a.MO = b.MO AND
   a.DY = b.DY AND
   a.HR = b.HR
);
