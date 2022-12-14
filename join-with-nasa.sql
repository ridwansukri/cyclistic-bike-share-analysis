CREATE OR REPLACE TABLE `acoustic-portal-322707.bike_dataset.bike_trip` AS (
SELECT a.*, b.T2M, b.RH2M, b.PRECTOTCORR, b.WS10M
FROM `acoustic-portal-322707.bike_dataset.bike_trip` AS a
JOIN `acoustic-portal-322707.bike_dataset.weather_chicago_beta`  AS b
ON a.YEAR = b.YEAR AND
   a.MO = b.MO AND
   a.DY = b.DY AND
   a.HR = b.HR
);
