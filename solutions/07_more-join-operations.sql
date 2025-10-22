-- 1. 1962 movies
SELECT
  id,
  title
FROM
  movie
WHERE
  yr = 1962
  AND budget > 2000000;

-- 2. When was Citizen Kane released?
SELECT
  yr
FROM
  movie
WHERE
  title = 'Citizen Kane';

-- 3. Star Trek movies
SELECT
  id,
  title,
  yr
FROM
  movie
WHERE
  title LIKE 'Star Trek%'
ORDER BY
  yr;

-- 4. id for actor Glenn Close
SELECT
  id
FROM
  actor
WHERE
  name = 'Glenn Close';

-- 5. id for Casablanca
SELECT
  id
FROM
  movie
WHERE
  yr = 1942
  AND title = 'Casablanca';

-- 6. Cast list for Casablanca
SELECT
  actor.name
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  movie.yr = 1942
  AND movie.title = 'Casablanca';

-- 7. Alien cast list
SELECT
  actor.name
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  movie.title = 'Alien';

-- 8. Harrison Ford movies
SELECT
  movie.title
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  actor.name = 'Harrison Ford';

-- 9. Harrison Ford as a supporting actor
SELECT
  movie.title
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  actor.name = 'Harrison Ford'
  AND casting.ord != 1;

-- 10. Lead actors in 1962 movies
SELECT
  movie.title,
  actor.name
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  casting.ord = 1
  AND yr = 1962;

-- 11. Busy years for Rock Hudson
SELECT
  yr,
  COUNT(title)
FROM
  movie
  JOIN casting ON movie.id = movieid
  JOIN actor ON actorid = actor.id
WHERE
  name = 'Rock Hudson'
GROUP BY
  yr
HAVING
  COUNT(title) > 2;

-- 12. Lead actor in Julie Andrews movies
SELECT
  movie.title,
  actor.name
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  movie.id IN (
    SELECT
      movieid
    FROM
      casting
    WHERE
      actorid = (
        SELECT
          id
        FROM
          actor
        WHERE
          name = 'Julie Andrews'
      )
  )
  AND casting.ord = 1;

-- 13. Actors with 15 leading roles
SELECT
  actor.name
FROM
  actor
  JOIN casting ON actor.id = casting.actorid
WHERE
  casting.ord = 1
GROUP BY
  actor.name
HAVING
  COUNT(actor.name) >= 15
ORDER BY
  actor.name;

-- 14. released in the year 1978
SELECT
  movie.title,
  COUNT(*) AS number_of_actors
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
WHERE
  movie.yr = 1978
GROUP BY
  movie.title
ORDER BY
  number_of_actors DESC,
  movie.title;

-- 15. with 'Art Garfunkel'
SELECT DISTINCT
  actor.name
FROM
  movie
  JOIN casting ON movie.id = casting.movieid
  JOIN actor ON casting.actorid = actor.id
WHERE
  movie.id IN (
    SELECT
      casting.movieid
    FROM
      casting
      JOIN actor ON casting.actorid = actor.id
    WHERE
      actor.id = (
        SELECT
          id
        FROM
          actor
        WHERE
          name = 'Art Garfunkel'
      )
  )
  AND actor.name != 'Art Garfunkel';