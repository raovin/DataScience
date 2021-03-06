Building and Organizing Complex Queries


WITH summary_data AS
    (
     SELECT
        pl.playlist_id,
        pl.name playlist_name,
        t.name track_name,
        (t.milliseconds/1000) length_seconds
    FROM playlist pl
    LEFT JOIN playlist_track pt ON pt.playlist_id = pl.playlist_id
    LEFT JOIN track t ON t.track_id = pt.track_id
    )

SELECT 
    playlist_id, 
    playlist_name, 
    COUNT(track_name) number_of_tracks,
    SUM(length_seconds)
FROM summary_data
GROUP BY 1, 2
ORDER BY playlist_id;


WITH playlist_info AS
    (
     SELECT
         p.playlist_id,
         p.name playlist_name,
         t.name track_name,
         (t.milliseconds / 1000) length_seconds
     FROM playlist p
     LEFT JOIN playlist_track pt ON pt.playlist_id = p.playlist_id
     LEFT JOIN track t ON t.track_id = pt.track_id
    )

SELECT
    playlist_id,
    playlist_name,
    COUNT(track_name) number_of_tracks,
    SUM(length_seconds) length_seconds
FROM playlist_info
GROUP BY 1, 2
ORDER BY 1;