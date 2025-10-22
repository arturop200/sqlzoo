-- 1.
SELECT
  title,
  artist
FROM
  album
  JOIN track ON (album.asin = track.album)
WHERE
  song = 'Alison';

-- 2.
SELECT
  artist
FROM
  album
  JOIN track ON album.asin = track.album
WHERE
  song = 'Exodus';

-- 3.
SELECT
  song
FROM
  album
  JOIN track ON album.asin = track.album
WHERE
  title = 'Blur';

-- 4.
SELECT
  title,
  COUNT(*)
FROM
  album
  JOIN track ON (asin = album)
GROUP BY
  title;

-- 5.
SELECT
  title,
  COUNT(*)
FROM
  album
  JOIN track ON album.asin = track.album
WHERE
  song LIKE '%Heart%'
GROUP BY
  title;

-- 6.
SELECT
  song
FROM
  album
  JOIN track ON album.asin = track.album
WHERE
  title = song;

-- 7.
SELECT
  title
FROM
  album
WHERE
  title = artist;

-- 8.
SELECT
  song,
  COUNT(DISTINCT asin)
FROM
  album
  JOIN track ON album.asin = track.album
GROUP BY
  song
HAVING
  COUNT(DISTINCT asin) > 2;

-- 9.
SELECT
  title,
  price,
  COUNT(song) AS number_of_tracks
FROM
  album
  JOIN track ON album.asin = track.album
GROUP BY
  title,
  price
HAVING
  price / COUNT(song) < 0.50;

-- 10.
SELECT
  title,
  COUNT(asin)
FROM
  album
  JOIN track ON album.asin = track.album
GROUP BY
  title,
  asin
ORDER BY
  COUNT(asin) DESC,
  title;