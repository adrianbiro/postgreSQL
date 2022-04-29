SELECT *
FROM "Playlist"

SELECT *
FROM "Track"

SELECT *
FROM "PlaylistTrack"

SELECT COUNT (*)
FROM "Track"
--FROM "Playlist"
FROM "PlaylistTrack"

-- Ako sa volá prvá skladba podľa abecedy z playlistov, ktorých názov  je tvorený aspoň 12 písmenami 
--/*NAJPRV JOIN
SELECT *
FROM "PlaylistTrack" plt  -- je alias  
JOIN "Track" t
	ON plt."TrackId"=t."TrackId"
JOIN "Playlist" pl -- potom1
	ON plt."PlaylistId"=pl."PlaylistId"
WHERE LENGTH(pl."Name") > 12  -- potom2
ORDER BY t."Name"  -- zoraduje sa podla abcd
*/

SELECT t."Name" 
FROM "PlaylistTrack" plt
JOIN "Playlist" pl 
	ON pl."PlaylistId"=plt."PlaylistId"
	AND LENGTH(pl."Name") > 12
JOIN "Track" t 
	ON t."TrackId"=plt."TrackId"
ORDER BY t."Name"


-- TODO 