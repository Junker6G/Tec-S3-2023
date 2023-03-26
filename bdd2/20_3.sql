SELECT t."Name", g."Name", mt."Name"
FROM "Track" t
JOIN "Genre" g on t."GenreId" = g."GenreId"
JOIN "MediaType" mt on mt."MediaTypeId" = t."MediaTypeId";

SELECT G."Name", (count(*)) as countTrack FROM "Track"
JOIN "Genre" G on G."GenreId" = "Track"."GenreId"
GROUP BY G."Name";

SELECT A."ArtistId", A."Name" FROM "Artist" as A
WHERE A."Name" NOT IN (
    SELECT A."Name" FROM "Artist" as A
    JOIN "Album" AL on A."ArtistId" = AL."ArtistId"
);

SELECT A."Name", count(T."Name") FROM "Artist" A
JOIN "Album" A1 on A."ArtistId" = A1."ArtistId"
JOIN "Track" T on A1."AlbumId" = T."AlbumId"
GROUP BY A."Name" HAVING count(T."Name") > 50
ORDER BY count(T."Name");
